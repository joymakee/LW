//
//  TNAOrgBaseVC.h
//  Toon
//
//  Created by Joymake on 16/3/16.
//  Copyright © 2016年 Joyamke. All rights reserved.
//  vc基类
/*
 1.自定义导航,自偏移
 2.提示语          KTOPICINfO(topic)
 3.错误码提示       KTOPICERRORCODE(errorCode)/KTOPICCODESTRING(topic)
 4.键盘隐藏         HIDE_KEYBOARD
 5.无数据背景图
 6.指定view全屏约束
 7.vc跳转(带键盘隐藏) goBack
 8.vc返回(present／push内部已判断,带键盘隐藏)
 9.指定vc返回
 10.打印当前vc name，以便调试
 11.图片选择  只针对组织路径做了存储
*/

#define HIDE_KEYBOARD [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];

#import <UIKIT/UIKit.h>
#import "Masonry.h"

typedef void (^writePicBlock)();
@interface LWBaseVC : UIViewController

/**
 *  每个子controller的标题,按需所传
 */
@property(nonatomic,copy)NSString *titleStr;

#pragma mark 设置导航 默认返回图片是 nav_back 所有参数均可不传 action 默认rightNavItemClickAction
- (void)setRightNavItemWithTitle:(NSString *)rightNavItemTitle  andImageStr:(NSString *)normalImageStr andHighLightImageStr:(NSString *)highLightImageStr action:(SEL)action;

#pragma mark 设置导航 默认返回图片是 nav_back 所有参数均可不传 action 默认leftNavItemClickAction
- (void)setLeftNavItemWithTitle:(NSString *)leftNavItemTitle andImageStr:(NSString *)normalImageStr andHighLightImageStr:(NSString *)highLightImageStr action:(SEL)action;

/**
 *  @author 王培荣
 *
 *  添加俩种常用的,默认的样式:左上角返回按钮,默认显示 < 无文字;右上角默认无图片,只显示文字
 */
- (void)setLeftNaviItemWithTitle:(NSString *)leftTitle;

- (void)setRightNavItemWithTitle:(NSString *)rightTitle;

- (void)setLeftNavWithGifStr:(NSString *)gifStr;

- (void)setRightNavWithGifStr:(NSString *)gifStr;

- (UIImage *)getGifImageWithStr:(NSString *)gifStr;

#pragma mark设置view的默认约束为全屏
- (void)setDefaultConstraintWithView:(UIView *)view andTitle:(NSString *)title;

#pragma mark显示默认提示图
- (void)showRemindViewWithTitle:(NSString *)title;

#pragma mark显示默认提示图
- (void)showRemindViewWithTitle:(NSString *)title andDefaultImageStr:(NSString *)imageStr;

- (void)showRemindViewWithTitle:(NSString *)title andDefaultImageStr:(NSString *)imageStr andBtnStr:(NSString *)btnTitle;

- (void)hideRemindView;

#pragma mark左导航事件 内置隐藏键盘
- (void)leftNavItemClickAction;

#pragma mark右导航事件 内置隐藏键盘
- (void)rightNavItemClickAction;

#pragma mark返回事件
- (void)goBack;

#pragma markgo某个vc
- (void)goVC:(LWBaseVC *)vc;

#pragma mark根据vc的name返回到某个vc
- (void)popToVCWithVCName:(NSString *)vcName;

@end
