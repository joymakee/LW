//
//  BasePresentor.h
//  LW
//
//  Created by joymake on 16/8/8.
//  Copyright © 2016年 joymake. All rights reserved.
//
#define HIDE_KEYBOARD [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];

#import <Foundation/Foundation.h>

@class JoyBaseVC;
@interface BasePresentor : NSObject
@property (nonatomic,strong)UIView *rootView;
- (instancetype)initWithView:(UIView *)view;
@property (nonatomic,strong) JoyBaseVC *currentVC;
#pragma mark 屏蔽右导航
- (void)disableRightNavItem;

#pragma mark 启用右导航
-(void)enableRightNavItem;

#pragma mark navitemClickAction
- (void)leftNavItemClickAction;

- (void)rightNavItemClickAction;

#pragma mark 返回
- (void)goBack;

#pragma MARk goVC
- (void)goVC:(UIViewController *)vc;

#pragma mark present vc
- (void)presentVC:(UIViewController *)vc;

#pragma mark gobackAction
- (void)popToVCWithVCName:(NSString *)vcName;

#pragma MARk goRoot
- (void)popToRootVC;

#pragma mark private method Action
- (void)performTapAction:(NSString *)tapActionStr;

#pragma mark view action
- (void)performAction:(NSString *)action :(NSIndexPath *)indexPath :(id)obj;

-(void)viewAction:(NSString *)action indexPath:(NSIndexPath *)indexPath object:(id)obj;
#pragma mark reloadData
- (void)reloadDataSource;

@end
