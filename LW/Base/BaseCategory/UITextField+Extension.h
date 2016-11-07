//
//  UITextField+Extension.h
//
//  Created by Joymake on 16/4/7.
//  Copyright © 2016年 Joymake. All rights reserved.
//


typedef void(^textFieldHasChangedBlock)();
#import <UIKit/UIKit.h>

@interface UITextField (Extension)

//设置最大字符数限制，超过后会截掉
-(void)setMaxNum:(NSInteger )maxNum;

- (void)setTopicStr:(NSString *)topic;

- (void)textFieldHasChanged:(textFieldHasChangedBlock)textHasChangedBlock;

-(void)setLeftContentPadding:(CGFloat)padding;
@end
