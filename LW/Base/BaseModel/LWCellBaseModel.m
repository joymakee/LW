//
//  LWCellBaseModel
//  Toon
//
//  Created by Joymake on 16/3/16.
//  Copyright © 2016年 Joymake. All rights reserved.
//

#import "LWCellBaseModel.h"
#import <Foundation/NSObjCRuntime.h>
#import "LWNavigationController.h"

@implementation LWCellBaseModel

#pragma mark 基本模型************************************************************************
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    NSLog(@"%@",key);
}

-(id)valueForUndefinedKey:(NSString *)key{
    NSLog(@"找不到%@对应的字段",key);
    return nil;
}

- (void)didSelect{
    if (self.tapAction) {
        SEL selector = NSSelectorFromString(self.tapAction);
        IMP imp = [self methodForSelector:selector];
        void (*func)(id, SEL) = (void *)imp;
        if ([self respondsToSelector:selector]) {
            func(self, selector);
        }
    }
}

@end

#pragma mark 头像类模型************************************************************************
@implementation LWCellBaseImageModel
@synthesize avatar  =   _avatar;            //头像

@synthesize viewShape = _viewShape;

@synthesize placeHolderImageStr = _placeHolderImageStr;
@end

#pragma mark 文本类模型************************************************************************
@implementation LWCellBaseTextModel

@synthesize maxNumber = _maxNumber;

@synthesize keyboardType = _keyboardType;           //文本类 text 键盘类型

@synthesize borderStyle  =_borderStyle;             //文本的边框类型

@synthesize secureTextEntry = _secureTextEntry;     //文本类 text密码键盘

@synthesize textFieldModel  =_textFieldModel;
@end

#pragma mark 自定义文本类模型************************************************************************
@implementation LWCellCustomTextModel

@synthesize titleColor = _titleColor;        //标题颜色

@synthesize subTitleColor = _subTitleColor;     //标题颜色

@synthesize titleFont = _titleFont;        //标题颜色

@synthesize subTitleFont = _subTitleFont;     //标题颜色

@end
