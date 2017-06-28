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

NSInteger messageCount = 0;
NSString  *KMESSAGE_COUNT_CHANGE = @"messageCountChange";
@interface LWTabbarVC ()<UITabBarControllerDelegate>

@end

@implementation LWTabbarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(messageCountChange:) name:KMESSAGE_COUNT_CHANGE object:nil];
    LWChatListVC *chatVC = [[LWChatListVC alloc]init];
    chatVC.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"聊天" image:[[UIImage imageNamed:@"tabBar_live_deselected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"tabBar_live_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    chatVC.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d",messageCount];
    
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

- (void)messageCountChange:(NSNotification *)obj{
    
}

-(void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    [tabBarController.viewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj == viewController) {
            [viewController.tabBarItem setTitleTextAttributes:@{ NSForegroundColorAttributeName : [UIColor orangeColor],NSFontAttributeName:[UIFont boldSystemFontOfSize:14] } forState:UIControlStateNormal];
        }else{
            [obj.tabBarItem setTitleTextAttributes:@{ NSForegroundColorAttributeName : [UIColor grayColor],NSFontAttributeName:[UIFont boldSystemFontOfSize:12] } forState:UIControlStateNormal];
        }
    }];
}
@end
