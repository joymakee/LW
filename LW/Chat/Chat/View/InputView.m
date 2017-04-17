//
//  InputView.m
//  LW
//
//  Created by wangguopeng on 2017/2/14.
//  Copyright © 2017年 joymake. All rights reserved.
//

#import "InputView.h"
#import "Masonry.h"
#import "CommonImageCollectView.h"
#import "Intelligencelnteractor.h"

@interface InputView ()<UITextViewDelegate>
@property (nonatomic,strong)UIImageView *speakerImageView;
@property (nonatomic,strong)UITextView *inputTextView;
@property (nonatomic,strong)UIButton *showCustomKeyboardBtn;
@property (nonatomic,strong)CommonImageCollectView *customKeyBoardView;
@property (nonatomic,strong)Intelligencelnteractor *customKeyBoardInteracter;

@end

static const float padding = 10;
const float KDefaultInputViewH = 33;

@implementation InputView

- (instancetype)init{
    if (self = [super init]) {
        [self addSubview:self.speakerImageView];
        [self addSubview:self.inputTextView];
        [self addSubview:self.showCustomKeyboardBtn];
        [self addSubview:self.customKeyBoardView];
        [self.customKeyBoardInteracter getIntelligenceSource];
        [self.customKeyBoardView setData:self.customKeyBoardInteracter.dataArrayM];
        self.inputTextView.returnKeyType = UIReturnKeySend;
        [self setConstraint];
    }
    return self;
}

-(Intelligencelnteractor *)customKeyBoardInteracter{
    return _customKeyBoardInteracter = _customKeyBoardInteracter?:[[Intelligencelnteractor alloc]init];
}

- (CommonImageCollectView *)customKeyBoardView{
    if (!_customKeyBoardView) {
        _customKeyBoardView = [[CommonImageCollectView alloc]init];
        [_customKeyBoardView setFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_W)];
    }
    return _customKeyBoardView;
}

-(UITextView *)inputTextView{
    if (!_inputTextView) {
        _inputTextView = [[UITextView alloc]initWithFrame:CGRectZero];
        _inputTextView.backgroundColor = [UIColor clearColor];
        _inputTextView.layer.masksToBounds = YES;
        _inputTextView.layer.cornerRadius = 5;
        _inputTextView.layer.borderWidth = 1;
        _inputTextView.layer.borderColor = [UIColor whiteColor].CGColor;
        _inputTextView.delegate = self;
        _inputTextView.textContainerInset = UIEdgeInsetsMake(10,5,5,5);
        _inputTextView.font = [UIFont systemFontOfSize:15];
    }
    return _inputTextView;
}

-(UIImageView *)speakerImageView{
    return _speakerImageView = _speakerImageView?:[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"happy.png"] highlightedImage:[UIImage imageNamed:@"happy.png"]];
}

-(UIButton *)showCustomKeyboardBtn{
    if (!_showCustomKeyboardBtn) {
        _showCustomKeyboardBtn = [UIButton buttonWithType:UIButtonTypeContactAdd];
        [_showCustomKeyboardBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _showCustomKeyboardBtn;
}

- (void)setConstraint{
    __weak __typeof(self)weakSelf  = self;

    [_speakerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.mas_left).offset(10);
        make.height.mas_equalTo(@26);
        make.width.mas_equalTo(@26);
        make.centerY.mas_equalTo(weakSelf.inputTextView.mas_centerY);
    }];

    [_inputTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.mas_top).offset(padding);
        make.left.mas_equalTo(weakSelf.speakerImageView.mas_right).offset(padding);
        make.right.mas_equalTo(weakSelf.showCustomKeyboardBtn.mas_left).offset(-5);
        make.height.mas_equalTo(@(KDefaultInputViewH));
    }];
    
    [_showCustomKeyboardBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(weakSelf.mas_right).offset(-5);
        make.height.mas_equalTo(@30);
        make.width.mas_equalTo(@30);
        make.centerY.mas_equalTo(weakSelf.inputTextView.mas_centerY);
    }];
    
    [_customKeyBoardView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.inputTextView.mas_bottom).offset(padding);
        make.left.mas_equalTo(weakSelf.mas_left);
        make.right.mas_equalTo(weakSelf.mas_right);
        make.height.mas_equalTo(@(SCREEN_W));
        make.width.mas_equalTo(@(SCREEN_W));
    }];
    
    [self updateConstraintsIfNeeded];
}


-(void)textViewDidBeginEditing:(UITextView *)textView{
    CGFloat newConstraintH = [self getTextViewMaxHeight];
    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(270+newConstraintH));
    }];
    [self updateConstraintsIfNeeded];
}

-(void)textViewDidEndEditing:(UITextView *)textView{
    CGFloat newConstraintH = [self getTextViewMaxHeight];

    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(newConstraintH));
    }];
    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(20+newConstraintH));
    }];

    [self updateConstraintsIfNeeded];
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if([text isEqualToString:@"\n"]){
        textView.text.length?[self resetInputViewConstraintH]:nil;
        return NO;
    }else{
        return YES;
    }
}

#pragma mark 重置输入框高度及内容
- (void)resetInputViewConstraintH{
    self.messageSendAction?self.messageSendAction(self.inputTextView.text):nil;
    self.inputTextView.text = nil;
    [self.inputTextView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(KDefaultInputViewH));
    }];
    [self updateConstraintsIfNeeded];
}

-(void)textViewDidChange:(UITextView *)textView{
    CGFloat newConstraintH = [self getTextViewMaxHeight];
    if(_inputTextView.size.height != newConstraintH){
    [_inputTextView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(newConstraintH));
    }];
        
    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(270+newConstraintH));
    }];
    [self updateConstraintsIfNeeded];
    }
}

- (CGFloat)getTextViewMaxHeight{
    CGSize constraintSize = CGSizeMake(self.inputTextView.contentSize.width, 40);
    CGSize size = [self.inputTextView sizeThatFits:constraintSize];
    return size.height>100?100:size.height;
}

- (void)btnClick:(id)btn{
    [self.inputTextView resignFirstResponder];
    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(SCREEN_W+KDefaultInputViewH+padding*2));
    }];
    [self updateConstraintsIfNeeded];
}
@end
