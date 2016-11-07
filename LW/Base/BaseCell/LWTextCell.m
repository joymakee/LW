//
//  LWTextCell.m
//  Toon
//
//  Created by Joymake on 16/3/16.
//  Copyright © 2016年 Joymake. All rights reserved.
//

#import "LWTextCell.h"
#import "LWCellBaseModel.h"
#import "NSString+Extension.h"
#import "UITextField+Extension.h"

@interface LWTextCell()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITextField *textFieldText;
@property (nonatomic,copy) NSString *inputOldStr;
@property (nonatomic,copy)NSString *changeTextKey;
@end

@implementation LWTextCell

- (void)setCellWithModel:(LWCellBaseTextModel *)model{
    LWCellBaseTextModel *setModel = (LWCellBaseTextModel *)model;
    self.changeTextKey = model.changeKey;
    self.textFieldText.keyboardType = model.keyboardType?model.keyboardType:UIKeyboardTypeDefault;
    [self.textFieldText setMaxNum:setModel.maxNumber];
    self.titleLabel.text = setModel.title;
    self.textFieldText.text = setModel.subTitle;
    self.textFieldText.placeholder = setModel.placeHolder;
    objc_setAssociatedObject(self, @selector(editingEnd:), setModel, OBJC_ASSOCIATION_RETAIN);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (IBAction)editDidBegin:(id)sender {
    
}

- (IBAction)editingEnd:(UITextField *)textField {
        LWCellBaseModel *setModel = objc_getAssociatedObject(self, _cmd);
        setModel.subTitle = textField.text;
    if ([self.delegate respondsToSelector:@selector(textChanged:andText:andChangedKey:)]) {
        [self.delegate textChanged:self.index andText:textField.text andChangedKey:self.changeTextKey];
    }
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    if ([self.delegate respondsToSelector:@selector(textshouldBeginEditWithTextContainter:andIndexPath:)]) {
        [self.delegate textshouldBeginEditWithTextContainter:textView andIndexPath:self.index];
    }
    return YES;
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView{
    if ([self.delegate respondsToSelector:@selector(textshouldEndEditWithTextContainter:andIndexPath:)]) {
        [self.delegate textshouldEndEditWithTextContainter:textView andIndexPath:self.index];
    }
    return YES;
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

@end
