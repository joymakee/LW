//
//  LWCellModelProtocol.h
//  LW
//
//  Created by Joymake on 2016/11/1.
//  Copyright © 2016年 joymake. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol LWTextProtocol <NSObject>

@optional

@property (nonatomic,assign)  NSInteger   maxNumber;            //文本类cell text max字符数量

@property (nonatomic,assign)  UIKeyboardType keyboardType;      //文本类 text 键盘类型

@property (nonatomic,assign) UITextBorderStyle borderStyle;     //文本的边框类型

@property (nonatomic,assign) BOOL             secureTextEntry;  //文本类 text密码键盘

@property (nonatomic,assign)  ETextCellType   textFieldModel;

@end

@protocol LWImageProtocol <NSObject>

@optional
@property (nonatomic,copy)    NSString      *avatar;            //头像

@property (nonatomic,assign)  EImageType    viewShape;

@property (nonatomic,copy)    NSString      *placeHolderImageStr;

@end

@protocol LWFontColorProtocol <NSObject>

@property (nonatomic,strong)  UIColor     *titleColor;        //标题颜色

@property (nonatomic,strong)  UIColor     *subTitleColor;     //标题颜色

@property (nonatomic,strong)  UIFont      *titleFont;        //标题颜色

@property (nonatomic,strong)  UIFont      *subTitleFont;     //标题颜色


@end
