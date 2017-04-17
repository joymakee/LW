//
//  BasePresentor.m
//  LW
//
//  Created by joymake on 16/8/8.
//  Copyright © 2016年 joymake. All rights reserved.
//

#import "BasePresentor.h"
#import "JoyBaseVC.h"
#import "LWTabbarVC.h"
@implementation BasePresentor
-(instancetype)initWithView:(UIView *)view{
    if (self = [super init]) {
        self.rootView = view;
    }
    return self;
}
-(JoyBaseVC *)currentVC{
    return _currentVC?:(JoyBaseVC *)[self rootVC].viewControllers.lastObject;
}

#pragma mark 返回
- (void)goBack{
    HIDE_KEYBOARD;
    [[self rootVC] presentingViewController]?[[self rootVC] dismissViewControllerAnimated:YES completion:NULL]:
    [[self rootVC] popViewControllerAnimated:YES];
}

#pragma mark 屏蔽右导航
- (void)disableRightNavItem{
    [[self rootVC].navigationItem.rightBarButtonItems enumerateObjectsUsingBlock:^(UIBarButtonItem * obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.enabled = NO;
    }];
}
#pragma mark 启用右导航
-(void)enableRightNavItem{
    [[self rootVC].navigationItem.rightBarButtonItems enumerateObjectsUsingBlock:^(UIBarButtonItem * obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.enabled = YES;
    }];
}

#pragma mark navitemClickAction
- (void)leftNavItemClickAction{
    HIDE_KEYBOARD;
    [self goBack];
}

- (void)rightNavItemClickAction{
    HIDE_KEYBOARD;
}

#pragma MARk goVC
- (void)goVC:(UIViewController *)vc{
    self.rootView.viewController.hidesBottomBarWhenPushed=YES;
    [self.rootView.viewController.navigationController pushViewController:vc animated:YES];
    self.rootView.viewController.hidesBottomBarWhenPushed=NO;
}

#pragma mark present vc
- (void)presentVC:(UIViewController *)vc{
    self.rootView.viewController.hidesBottomBarWhenPushed=YES;
    [self.currentVC presentViewController:vc animated:YES completion:nil];
    self.rootView.viewController.hidesBottomBarWhenPushed=NO;
}

#pragma mark gobackAction
- (void)popToVCWithVCName:(NSString *)vcName{
    __block Class popVCClass = NSClassFromString(vcName);
    __weak __typeof (&*self)weakSelf = self;
    [[self rootVC].viewControllers enumerateObjectsUsingBlock:^( UIViewController *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:popVCClass])
        {
            [[weakSelf rootVC] popToViewController:obj animated:YES];
            *stop = YES;
        }
    }];
}

#pragma mark private method Action
- (void)performTapAction:(NSString *)tapActionStr{
    if (tapActionStr) {
        SEL selector = NSSelectorFromString(tapActionStr);
        IMP imp = [self methodForSelector:selector];
        void (*func)(id, SEL) = (void *)imp;
        if ([self respondsToSelector:selector]) {
            func(self, selector);
            NSLog(@"\n *********************************************************\n You has performed the Method \"%@\"  in the class \"%@\" \n *********************************************************\n ",tapActionStr,NSStringFromClass([self class]));
        }else{
            NSLog(@"\n *********************************************************\n Oh my God ,I hasn't Found the Method \"%@\" in implementation,Please Sure it's in the class \"%@\"\n *********************************************************\n ",tapActionStr,NSStringFromClass([self class]));
        }
    }else{
        NSLog( @"\n *********************************************************\n You had do nothing,if you want to do something please tell you cellModel and Realize it  in the class \"%@\"  \n *********************************************************\n ",NSStringFromClass([self class]));
    }
}

#pragma mark viewaction
- (void)performAction:(NSString *)action :(NSIndexPath *)indexPath :(id)obj{
    if ([self respondsToSelector:@selector(viewAction:indexPath:object:)]) {
        [self viewAction:action indexPath:indexPath object:obj];
    }
}

-(void)viewAction:(NSString *)action indexPath:(NSIndexPath *)indexPath object:(id)obj;{
    
}

#pragma MARk goRoot
- (void)popToRootVC{
    [[self rootVC].navigationController popToRootViewControllerAnimated:YES];
}

-(void)reloadDataSource{
    
}

- (UINavigationController *)rootVC{
    LWTabbarVC *vc = nil;
    if ([[UIApplication sharedApplication].keyWindow.rootViewController isKindOfClass:[UITabBarController class]])
    {
    return [(UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController selectedViewController];
    }
    else
    {
    vc = [[LWTabbarVC alloc] init];
    [UIApplication sharedApplication].keyWindow.rootViewController = vc;
    return vc.selectedViewController;
    }
}
@end
