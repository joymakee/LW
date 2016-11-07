//
//  UITextField+Extension.m
//
//  Created by Joymake on 16/4/7.
//  Copyright © 2016年 Joymake. All rights reserved.
//

#import "UITextField+Extension.h"
#import "NSString+Extension.h"
#import <objc/runtime.h>

static const void * characterStrKey =&characterStrKey;
static const void * inputOldStrKey =&inputOldStrKey;
static const void * topicKey =&topicKey;
static const void * blockKey =&blockKey;

@implementation UITextField (Extension)

-(void)setMaxNum:(NSInteger)maxNum{
        objc_setAssociatedObject(self, characterStrKey, [NSNumber numberWithInteger:maxNum], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        [self addTarget:self action:@selector(willChangeEditing:) forControlEvents:UIControlEventEditingChanged];
    
}

-(void)willChangeEditing:(UITextField *)textField
{
    NSInteger characterNum = [objc_getAssociatedObject(self, characterStrKey) integerValue];
    if (characterNum) {
    UITextPosition* beginning = textField.beginningOfDocument;
    UITextRange* markedTextRange = textField.markedTextRange;
    UITextPosition* selectionStart = markedTextRange.start;
    UITextPosition* selectionEnd = markedTextRange.end;
    NSInteger location = [textField offsetFromPosition:beginning toPosition:selectionStart];
    NSInteger length = [textField offsetFromPosition:selectionStart toPosition:selectionEnd];
    NSRange tRange = NSMakeRange(location,length);
    NSString *newString = [textField.text substringWithRange:tRange];
    NSString *oldString = [textField.text stringByReplacingOccurrencesOfString:newString withString:@"" options:0 range:tRange];
    
    if(newString.length <= 0)//非汉字输入
    {
        if (textField.text.lengthAndChinese > characterNum) {
            textField.text =objc_getAssociatedObject(self, inputOldStrKey);
            [self showHUDTopic];
        }
        else
        {
            objc_setAssociatedObject(self, inputOldStrKey, textField.text, OBJC_ASSOCIATION_COPY);
        }
    }
    else//汉字输入
    {
        NSInteger tNewNumber = newString.lengthAndChinese;
        NSInteger tOldNumber = oldString.lengthAndChinese;
        BOOL isEnsure = (newString.length*2 == tNewNumber);//判断markedText是汉字还是字母。如果是汉字，说是用户最终输入。
        if(isEnsure && tNewNumber+tOldNumber > characterNum)
        {
            NSInteger tIndex = (tNewNumber+tOldNumber) - characterNum;
            tIndex = tNewNumber - tIndex;
            tIndex /= 2;
            NSString *finalStr = [oldString substringToIndex:location];
            finalStr = [finalStr stringByAppendingString:[newString substringToIndex:tIndex]];
            finalStr = [finalStr stringByAppendingString:[oldString substringFromIndex:location]];
            textField.text = finalStr;
            [self showHUDTopic];
        }
        else
        {
        }
    }
    }
    textFieldHasChangedBlock block =  objc_getAssociatedObject(self, blockKey);
    block?block():nil;
}

- (void)textFieldHasChanged:(textFieldHasChangedBlock)textHasChangedBlock{
    objc_setAssociatedObject(self, blockKey, textHasChangedBlock, OBJC_ASSOCIATION_COPY);

}

- (void)setTopicStr:(NSString *)topic{
    objc_setAssociatedObject(self, topicKey, topic, OBJC_ASSOCIATION_COPY);
}

-(void)showHUDTopic
{
    NSString *maxTopicStr = objc_getAssociatedObject(self, topicKey);
    if (maxTopicStr) {
//        [MBProgressHUD showMessage:maxTopicStr inView:nil];
    }
}
- (void)setLeftContentPadding:(CGFloat)padding {
    UIView *VV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, padding, 1)];
    self.leftView= VV;
    self.leftViewMode = UITextFieldViewModeAlways;
}
@end
