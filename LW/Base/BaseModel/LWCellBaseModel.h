//
//  LWCellBaseModel
//  Toon
//
//  Created by Joymake on 16/3/16.
//  Copyright © 2016年 Joymake. All rights reserved.

//  禁止随意扩充此类⚠️
//  所有业务类字段和方法请在子类中实现⚠️


typedef void(^CellBlock)(id obj,ERefreshScheme refreshScheme);

#import <Foundation/Foundation.h>
#import "LWCellModelProtocol.h" //分散实现字段的set get method 以达到减少内存消耗的作用

@interface LWCellBaseModel : NSObject

@property (nonatomic,assign)  ECellType   cellType;           //cellType xib 或代码

@property (nonatomic,copy)    NSString    *cellName;            //cell的名字,复用标识.同时为cell的类名

@property (nonatomic,assign)  UITableViewCellAccessoryType    accessoryType;

@property (nonatomic,assign) UITableViewCellEditingStyle      editingStyle;     //cell的编辑类型

@property (nonatomic,assign)  CGFloat     cellH;                //cell的高度

@property (nonatomic,strong)  UIColor     *backgroundColor;   // 背景色

@property (nonatomic,copy)    NSString    *title;             //标题

@property (nonatomic,copy)    NSString    *subTitle;          //副标题

@property (nonatomic,copy)    NSString    *placeHolder;         //占位符

@property (nonatomic,copy)    NSString    *tapAction;           //点击事件的sel name 在子类中实现

@property (nonatomic,copy)    NSString    *changeKey;           //文本类cell text发生变化时传回的key值用于修改对象对应的值

@property (nonatomic,assign)  bool        disable;              //文本类 是否可屏蔽触摸事件

@property (nonatomic,copy)CellBlock       cellBlock;

- (void)didSelect;      //点击事件回调时实现model的回调函数，执行此函数

@end

@interface LWCellBaseImageModel:LWCellBaseModel<LWImageProtocol>  //遵循协议以便获得文本特有属性
@end

@interface LWCellBaseTextModel:LWCellBaseModel<LWTextProtocol>  //遵循协议以便获得文本特有属性
@end

@interface LWCellCustomTextModel:LWCellBaseModel<LWFontColorProtocol>  //遵循协议以便获得文本特有属性(自定义文本属性颜色字体)
@end



