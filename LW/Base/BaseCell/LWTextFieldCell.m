//
//  TNASendCheckCodeCell.m
//  Toon
//
//  Created by Joymake on 16/5/4.
//  Copyright © 2016年 Joymake. All rights reserved.
//

#import "LWTextFieldCell.h"
#import <JoyKit/JoyKit.h>
#import <NSString+JoyCategory.h>
#import <UITextField+JoyCategory.h>

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

- (void)setCellWithModel:(JoyTextCellBaseModel *)model{
    __weak __typeof (&*self)weakSelf = self;
    [self.textFieldText textHasChanged:^{
        [weakSelf textFieldHasChanged];
    }];
    JoyTextCellBaseModel *setModel = (JoyTextCellBaseModel *)model;
    objc_setAssociatedObject(self, @selector(editingEnd:), setModel, OBJC_ASSOCIATION_RETAIN);
    self.changeTextKey = model.changeKey;
    self.textFieldText.keyboardType = model.keyboardType?model.keyboardType:UIKeyboardTypeDefault;
    [self.textFieldText setTextMaxNum:setModel.maxNumber];
    self.textFieldText.text = setModel.title;
    if (model.titleColor) {
        self.textFieldText.textColor = model.titleColor;
    }
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
    
//    JoyCellBaseModel *model = objc_getAssociatedObject(self, @"checkCode");
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
        JoyTextCellBaseModel *setModel = objc_getAssociatedObject(self, _cmd);
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


@interface LWTextViewCell ()<UITextViewDelegate>
@property (strong, nonatomic)  UITextView *textView;
@property (nonatomic,copy) NSString *inputOldStr;
@property (nonatomic,copy)NSString *changeTextKey;
@property (strong, nonatomic) UILabel *placeHolderLabel;
@property (nonatomic,assign)BOOL isNeedScroll;

@end

@implementation LWTextViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.placeHolderLabel];
        [self.contentView addSubview:self.textView];
        self.backgroundColor = self.contentView.backgroundColor = [UIColor clearColor];
        [self setConstraint];
        [self updateConstraintsIfNeeded];
    }
    return self;
}

-(UITextView *)textView{
    if (!_textView) {
        _textView = [[UITextView alloc]initWithFrame:CGRectZero];
        _textView.delegate = self;
        _textView.font = [UIFont systemFontOfSize:15];
        _textView.textColor = [UIColor whiteColor];
        _textView.backgroundColor = [UIColor colorWithRed:0.45 green:0.4 blue:0.4 alpha:0.4];
        _textView.layer.cornerRadius = 10;
    }
    return _textView;
}

-(UILabel *)placeHolderLabel{
    if(!_placeHolderLabel){
        _placeHolderLabel =[[UILabel alloc]init];
        _placeHolderLabel.font = [UIFont systemFontOfSize:15];
        _placeHolderLabel.textColor = [UIColor whiteColor];
    }
    return _placeHolderLabel;
}

-(void)setConstraint{
    MAS_CONSTRAINT(self.placeHolderLabel,
                   make.leading.mas_equalTo(20);
                   make.trailing.mas_equalTo(-15);
                   make.top.mas_equalTo(self.textView.mas_top).mas_offset(5);
                   );
    
    MAS_CONSTRAINT(self.textView,
                   make.leading.mas_equalTo(15);
                   make.trailing.mas_equalTo(-15);
                   make.height.mas_equalTo(100);
                   make.top.mas_equalTo(self.contentView.mas_top).offset(5);
                   make.centerY.mas_equalTo(self.contentView.mas_centerY);
                   );
}

- (void)setCellWithModel:(JoyTextCellBaseModel *)model{
    self.textView.returnKeyType = UIReturnKeyDone;
    objc_setAssociatedObject(self, @selector(setCellWithModel:), model, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    self.changeTextKey = model.changeKey;
    self.textView.keyboardType = model.keyboardType?model.keyboardType:UIKeyboardTypeDefault;
    self.maxNum = model.maxNumber;
    if (self.maxNum && model.subTitle.strLength> self.maxNum)
    {
        model.subTitle  =  [model.subTitle subToMaxIndex:self.maxNum];
    }
    self.textView.text = model.subTitle;
    self.placeHolderLabel.text = model.placeHolder;
    self.placeHolderLabel.hidden = self.textView.text.length;
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    if ([self.delegate respondsToSelector:@selector(textshouldBeginEditWithTextContainter:andIndexPath:)])
    {
        [self.delegate textshouldBeginEditWithTextContainter:textView andIndexPath:self.index];
    }
    return YES;
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView{
    if ([self.delegate respondsToSelector:@selector(textshouldEndEditWithTextContainter:andIndexPath:)])
    {
        [self.delegate textshouldEndEditWithTextContainter:textView andIndexPath:self.index];
    }
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView{
    
    if ([self.delegate respondsToSelector:@selector(textHasChanged:andText:andChangedKey:)]) {
        [self.delegate textHasChanged:self.index andText:textView.text andChangedKey:self.changeTextKey];
    }
    if (self.maxNum) {
        UITextPosition* beginning = textView.beginningOfDocument;
        UITextRange* markedTextRange = textView.markedTextRange;
        UITextPosition* selectionStart = markedTextRange.start;
        UITextPosition* selectionEnd = markedTextRange.end;
        NSInteger location = [textView offsetFromPosition:beginning toPosition:selectionStart];
        NSInteger length = [textView offsetFromPosition:selectionStart toPosition:selectionEnd];
        NSRange tRange = NSMakeRange(location,length);
        NSString *newString = [textView.text substringWithRange:tRange];
        NSString *oldString = [textView.text stringByReplacingOccurrencesOfString:newString withString:@"" options:0 range:tRange];
        if(newString.length <= 0)//非汉字输入
        {
            if (textView.text.strLength > self.maxNum)
            {textView.text = self.inputOldStr;}
            else
            {self.inputOldStr = textView.text;}
        }
        else//汉字输入
        {
            NSInteger tNewNumber = newString.strLength;
            NSInteger tOldNumber = oldString.strLength;
            BOOL isEnsure = (newString.length*2 == tNewNumber);//判断markedText是汉字还是字母。如果是汉字，说是用户最终输入。
            if(isEnsure && tNewNumber+tOldNumber > self.maxNum)
            {
                NSInteger tIndex = (tNewNumber+tOldNumber) - self.maxNum;
                tIndex = tNewNumber - tIndex;
                tIndex /= 2;
                NSString *finalStr = [oldString substringToIndex:location];
                finalStr = [finalStr stringByAppendingString:[newString substringToIndex:tIndex]];
                finalStr = [finalStr stringByAppendingString:[oldString substringFromIndex:location]];
                textView.text = finalStr;
            }
        }
    }
    self.placeHolderLabel.hidden = textView.text.length;
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    if ([self.delegate respondsToSelector:@selector(textChanged:andText:andChangedKey:)]) {
        JoyTextCellBaseModel *model = objc_getAssociatedObject(self, @selector(setCellWithModel:));
        model.title = textView.text;
        [self.delegate textChanged:self.index andText:textView.text andChangedKey:self.changeTextKey];
    }
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString*)text
{
    if(range.length == 1)
    {return YES;}
    if ((range.location == 0 && [text isEqualToString:@" "]) || [text isEqualToString:@"\n"])
    {return NO;}
    return YES;
}


@end
