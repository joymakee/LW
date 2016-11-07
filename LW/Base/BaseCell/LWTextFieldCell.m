//
//  TNASendCheckCodeCell.m
//  Toon
//
//  Created by Joymake on 16/5/4.
//  Copyright © 2016年 Joymake. All rights reserved.
//

#import "LWTextFieldCell.h"
#import "LWCellBaseModel.h"
#import "NSString+Extension.h"
#import "UITextField+Extension.h"

@interface LWTextFieldCell()<UITextFieldDelegate>{
    NSInteger _time;
    NSTimer *_timer;
}
@property (weak, nonatomic) IBOutlet UITextField *textFieldText;
@property (nonatomic,copy) NSString *inputOldStr;
@property (nonatomic,copy)NSString *changeTextKey;
@property (nonatomic,strong)UIButton *sendCheckCode;
@property (nonatomic,strong)UIView *textfieldRightView;
@property (nonatomic,strong)UIView *separateView;

@end

@implementation LWTextFieldCell

-(void)dealloc{
    [_timer invalidate];
    _timer = nil;
}

-(UIView *)separateView{
    if (!_separateView) {
        _separateView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 1, 44)];
        _separateView.backgroundColor = [UIColor lightGrayColor];
    }
    return _separateView;
}

-(UIView *)textfieldRightView{
    if (!_textfieldRightView) {
        _textfieldRightView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 120, 44)];
        [_textfieldRightView addSubview:self.separateView];
        [_textfieldRightView addSubview:self.sendCheckCode];
    }
    return _textfieldRightView;
}

- (UIButton *)sendCheckCode{
    if (!_sendCheckCode) {
        _sendCheckCode = [UIButton buttonWithType:UIButtonTypeCustom];
        [_sendCheckCode.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [_sendCheckCode setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_sendCheckCode setTitleColor:[UIColor colorWithRed:0.06f green:0.57f blue:0.89f alpha:1.00f] forState:UIControlStateNormal];
        [_sendCheckCode setTitleColor:[UIColor lightGrayColor] forState:UIControlStateSelected];
        [_sendCheckCode setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
        [_sendCheckCode addTarget:self action:@selector(sendCheckCodeAction:) forControlEvents:UIControlEventTouchUpInside];
        [_sendCheckCode setFrame:CGRectMake(10, 0, 100, 44)];
    }
    return _sendCheckCode;
}

- (void)setCellWithModel:(LWCellBaseTextModel *)model{
    __weak __typeof (&*self)weakSelf = self;
    [self.textFieldText textFieldHasChanged:^{
        [weakSelf textFieldHasChanged];
    }];
    LWCellBaseTextModel *setModel = (LWCellBaseTextModel *)model;
    objc_setAssociatedObject(self, @selector(editingEnd:), setModel, OBJC_ASSOCIATION_RETAIN);
    self.changeTextKey = model.changeKey;
    self.textFieldText.keyboardType = model.keyboardType?model.keyboardType:UIKeyboardTypeDefault;
    [self.textFieldText setMaxNum:setModel.maxNumber];
    self.textFieldText.text = setModel.title;
    self.textFieldText.secureTextEntry = model.secureTextEntry;
    self.textFieldText.placeholder = setModel.placeHolder;
    self.userInteractionEnabled =!setModel.disable;
    
    switch (model.textFieldModel) {
        case leftViewModel:
            break;
        case rightViewModel:
            _time = 60;
            self.textFieldText.rightViewMode = UITextFieldViewModeAlways;
            self.textFieldText.rightView = self.textfieldRightView;
            break;
        default:

            break;
    }
    self.textFieldText.borderStyle = model.borderStyle;
    [self setNeedsUpdateConstraints];
}


- (void)sendCheckCodeAction:(UIButton *)sendBtn{
    
//    LWCellBaseModel *model = objc_getAssociatedObject(self, @"checkCode");
//    if (model) {
//        model.sendCkeckCodeBlock?model.sendCkeckCodeBlock():nil;
//        if( model.isAccountValid){
//            [self startTimer];
//            [sendBtn setSelected:YES];
//            sendBtn.userInteractionEnabled = NO;}
//    }
}

- (void)startTimer
{
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(refreshLessTime) userInfo:@"" repeats:YES];
    
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:UITrackingRunLoopMode];
}

- (void)refreshLessTime{
    if (--_time) {
        [self.sendCheckCode setTitle:[NSString stringWithFormat:@"重新获取 (%ld)",(long)_time] forState:UIControlStateSelected];
        
    }else{
        _time = 60;
        [_timer  invalidate];
        _timer = nil;
        self.sendCheckCode.userInteractionEnabled = YES;
        [self.sendCheckCode setSelected:NO];
        [_sendCheckCode setTitle:@"重新获取验证码" forState:UIControlStateNormal];
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (IBAction)editingEnd:(UITextField *)textField {
        LWCellBaseTextModel *setModel = objc_getAssociatedObject(self, _cmd);
        setModel.title = textField.text;
    if ([self.delegate respondsToSelector:@selector(textChanged:andText:andChangedKey:)]) {
        [self.delegate textChanged:self.index andText:textField.text andChangedKey:self.changeTextKey];
    }
}

- (void)textFieldHasChanged{
    if ([self.delegate respondsToSelector:@selector(textHasChanged:andText:andChangedKey:)]) {
        [self.delegate textHasChanged:self.index andText:self.textFieldText.text andChangedKey:self.changeTextKey];
    }
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if ([self.delegate respondsToSelector:@selector(textshouldBeginEditWithTextContainter:andIndexPath:)]) {
        [self.delegate textshouldBeginEditWithTextContainter:textField andIndexPath:self.index];
    }
    return YES;
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    if ([self.delegate respondsToSelector:@selector(textshouldEndEditWithTextContainter:andIndexPath:)]) {
        [self.delegate textshouldEndEditWithTextContainter:textField andIndexPath:self.index];
    }
    return YES;
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    self.textFieldText.layer.masksToBounds = YES;
    self.textFieldText.layer.cornerRadius = CGRectGetHeight(self.textFieldText.frame)/2;
}
@end
