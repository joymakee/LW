//
//  LWTabbarVC.m
//  LW
//
//  Created by joymake on 16/7/5.
//  Copyright © 2016年 joymake. All rights reserved.
//

#import "LWTabbarVC.h"
#import "LWMediaListVC.h"
#import "LWCommentVC.h"
#import "IntelligenceVC.h"
#import "LWNavigationController.h"
#import "TNACompanyManageVC.h"
#import "LWChatListVC.h"

@interface LWTabbarVC ()<UITabBarControllerDelegate>

@end

@implementation LWTabbarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
    
    LWChatListVC *chatVC = [[LWChatListVC alloc]init];
    chatVC.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"聊天" image:[[UIImage imageNamed:@"tabBar_live_deselected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"tabBar_live_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    chatVC.tabBarItem.badgeValue = @"99+";
    LWNavigationController *chatNav = [[LWNavigationController alloc]initWithRootViewController:chatVC];
    


    LWMediaListVC *mediaListVC = [[LWMediaListVC alloc]init];
    mediaListVC.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"休闲" image:[[UIImage imageNamed:@"tabBar_live_deselected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"tabBar_live_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    LWNavigationController *mediaNav = [[LWNavigationController alloc]initWithRootViewController:mediaListVC];

    TNACompanyManageVC *workVC = [[TNACompanyManageVC alloc]init];
    workVC.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"工作"
                                                        image:[[UIImage imageNamed:@"tabBar_ intelligence_deselected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                                selectedImage:[[UIImage imageNamed:@"tabBar_ intelligence_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    LWNavigationController *workNav = [[LWNavigationController alloc]initWithRootViewController:workVC];

    
    IntelligenceVC *intelligenceVC = [[IntelligenceVC alloc]init];
    intelligenceVC.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"智能生活"
                                                        image:[[UIImage imageNamed:@"tabBar_ intelligence_deselected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                                selectedImage:[[UIImage imageNamed:@"tabBar_ intelligence_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    intelligenceVC.tabBarItem.badgeValue = @"8";
    
    LWNavigationController *intelligenceNav = [[LWNavigationController alloc]initWithRootViewController:intelligenceVC];
       self.viewControllers = @[chatNav,mediaNav,workNav,intelligenceNav];
    self.tabBar.tintColor = [UIColor orangeColor];
}

-(void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{

}
@end
