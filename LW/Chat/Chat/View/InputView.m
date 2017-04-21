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
#import "LWImageView.h"
#import "JoyRecorder.h"

@interface InputView ()<UITextViewDelegate>
@property (nonatomic,strong)LWImageView *speakerImageView;
@property (nonatomic,strong)UITextView *inputTextView;
@property (nonatomic,strong)UIButton *showCustomKeyboardBtn;
@property (nonatomic,strong)UIButton *recordAudioBtn;
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
        [self addSubview:self.recordAudioBtn];
        [self addSubview:self.showCustomKeyboardBtn];
        [self addSubview:self.customKeyBoardView];
        [self.customKeyBoardInteracter getIntelligenceSource];
        [self.customKeyBoardView setData:self.customKeyBoardInteracter.dataArrayM];
        self.inputTextView.returnKeyType = UIReturnKeySend;
    }
    return self;
}

-(Intelligencelnteractor *)customKeyBoardInteracter{
    return _customKeyBoardInteracter = _customKeyBoardInteracter?:[[Intelligencelnteractor alloc]init];
}

- (CommonImageCollectView *)customKeyBoardView
{
    if (!_customKeyBoardView) {
        _customKeyBoardView = [[CommonImageCollectView alloc]init];
        [_customKeyBoardView setFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_W)];
    }
    return _customKeyBoardView;
}

-(UIButton *)recordAudioBtn
{
    if (!_recordAudioBtn) {
        _recordAudioBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _recordAudioBtn.layer.masksToBounds = YES;
        _recordAudioBtn.layer.cornerRadius = 5;
        _recordAudioBtn.layer.borderWidth = 0.8;
        _recordAudioBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
        [_recordAudioBtn addTarget:self action:@selector(recordAudio) forControlEvents:UIControlEventTouchDown];
        [_recordAudioBtn addTarget:self action:@selector(stopRecord) forControlEvents:UIControlEventTouchUpInside];

        [_recordAudioBtn addTarget:self action:@selector(stopRecord) forControlEvents:UIControlEventTouchUpOutside];
        [_recordAudioBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [_recordAudioBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];

        [_recordAudioBtn setTitle:@"按住 说话" forState:UIControlStateNormal];
        [_recordAudioBtn setTitle:@"松开 结束" forState:UIControlStateHighlighted];

        _recordAudioBtn.alpha = 0;
    }
    return _recordAudioBtn;
}

-(UITextView *)inputTextView
{
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

-(LWImageView *)speakerImageView{
    if(!_speakerImageView){
        _speakerImageView = [[LWImageView alloc]init];
        _speakerImageView.image = [UIImage imageNamed:@"happy.png"];
        __weak __typeof(&*self)weakSelf = self;
        _speakerImageView.lwImageTouchBlock = ^(ELwTouchActionType touchType)
        {
            touchType == ELwTouchActionSingleType?[weakSelf keyboardRecordSwitching]:nil;
        };
    }
    return _speakerImageView;
}

-(UIButton *)showCustomKeyboardBtn{
    if (!_showCustomKeyboardBtn) {
        _showCustomKeyboardBtn = [UIButton buttonWithType:UIButtonTypeContactAdd];
        [_showCustomKeyboardBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _showCustomKeyboardBtn;
}

- (void)updateConstraints{
    [super updateConstraints];
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
    
    [_recordAudioBtn mas_makeConstraints:^(MASConstraintMaker *make) {
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
    ChatMessage *inputModel = [[ChatMessage alloc]init];
    inputModel.message = self.inputTextView.text;
    self.messageBlock?self.messageBlock(inputModel):nil;
//    self.messageSendAction?self.messageSendAction(self.inputTextView.text):nil;
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

#pragma mark 录制
- (void)recordAudio{
    [self.speakerImageView rotate];
    [JoyRecorder shareInstance].recordAudioUrlStrPathFile = [NSString stringWithFormat:@"%dxx.caf",arc4random()%100];
    [[JoyRecorder shareInstance] startRecord];
}

#pragma mark 停止录制
- (void)stopRecord{
    __weak __typeof (&*self)weakSelf = self;
    [JoyRecorder shareInstance].recordFinishBlock = ^(CGFloat recordTime){
        ChatMessage *inputModel = [[ChatMessage alloc]init];
        inputModel.message = weakSelf.inputTextView.text;
        inputModel.chatType = EChatAudioType;
        inputModel.playTotalTime = recordTime;
        inputModel.urlPath = [JoyRecorder shareInstance].recordAudioUrlStrPathFile;
        weakSelf.messageBlock?weakSelf.messageBlock(inputModel):nil;
    };

    [self.speakerImageView stopAnimating];
    [[JoyRecorder shareInstance] stopRecord];
    [[JoyRecorder shareInstance] invalidate];
}

- (void)keyboardRecordSwitching{
    if(self.inputTextView.isFirstResponder){
        [self.inputTextView resignFirstResponder];
        self.inputTextView.alpha = 0;
        self.recordAudioBtn.alpha =1;
    }else{
        [self.inputTextView becomeFirstResponder];
        self.inputTextView.alpha = 1;
        self.recordAudioBtn.alpha =0;
    }
}

-(void)dealloc{
    [[JoyRecorder shareInstance] invalidate];
}
@end
