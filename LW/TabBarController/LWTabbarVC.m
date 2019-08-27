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
#import "LWChatListVC.h"
#import "MeVC.h"
#import <JoyKit/JoyRouter.h>

NSInteger messageCount = 0;
NSString  *KMESSAGE_COUNT_CHANGE = @"messageCountChange";
@interface LWTabbarVC ()<UITabBarControllerDelegate>
@end

@interface LWTabbarVC ()<JoyRouteProtocol>
@property (nonatomic,assign)NSInteger selectItemIndex;
@end

@implementation LWTabbarVC

-(void)routeParam:(NSDictionary *)param block:(JoyRouteBlock)block{
    if([param objectForKey:@"select"]){
        self.selectedIndex = [[param objectForKey:@"select"] integerValue];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.delegate = self;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(messageCountChange:) name:KMESSAGE_COUNT_CHANGE object:nil];
    LWChatListVC *chatVC = [[LWChatListVC alloc]init];

    chatVC.tabBarItem.badgeValue = [NSString stringWithFormat:@"%ld",(long)messageCount];
    chatVC.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"消息" image:[UIImage imageNamed:@"tabBar_message"] tag:0];
    LWNavigationController *chatNav = [[LWNavigationController alloc]initWithRootViewController:chatVC];
//    [chatNav.navigationBar setBackgroundImage:[UIImage imageNamed:@"lw_tabbar.jpg"] forBarMetrics:UIBarMetricsDefault];
    [chatNav.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [chatNav.navigationBar setShadowImage:[UIImage new]];
    chatNav.navigationBar.translucent = YES;
    chatVC.edgesForExtendedLayout = UIRectEdgeAll;

    LWMediaListVC *mediaListVC = [[LWMediaListVC alloc]init];
    mediaListVC.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"休闲" image:[UIImage imageNamed:@"tabBar_live"] tag:1];
    LWNavigationController *mediaNav = [[LWNavigationController alloc]initWithRootViewController:mediaListVC];
//    [mediaNav.navigationBar setBackgroundImage:[UIImage imageNamed:@"lw_tabbar.jpg"] forBarMetrics:UIBarMetricsDefault];
    [mediaNav.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [mediaNav.navigationBar setShadowImage:[UIImage new]];
    mediaNav.navigationBar.translucent = YES;
    mediaListVC.edgesForExtendedLayout = UIRectEdgeAll;
 
    
    IntelligenceVC *intelligenceVC = [[IntelligenceVC alloc]init];
    intelligenceVC.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"生活" image:[UIImage imageNamed:@"tabBar_intelligence"] tag:3];
    intelligenceVC.tabBarItem.badgeValue = @"8";
    
    LWNavigationController *intelligenceNav = [[LWNavigationController alloc]initWithRootViewController:intelligenceVC];
    [intelligenceNav.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [intelligenceNav.navigationBar setShadowImage:[UIImage new]];
    intelligenceNav.navigationBar.translucent = YES;
    intelligenceVC.edgesForExtendedLayout = UIRectEdgeAll;
    
    MeVC *meVC = [[MeVC alloc]init];
    meVC.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"我的" image:[UIImage imageNamed:@"tabBar_me"] tag:3];
    
    LWNavigationController *meNav = [[LWNavigationController alloc]initWithRootViewController:meVC];
    [meNav.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [meNav.navigationBar setShadowImage:[UIImage new]];
    meNav.navigationBar.translucent = YES;
    meNav.edgesForExtendedLayout = UIRectEdgeAll;

    self.viewControllers = @[chatNav,mediaNav,intelligenceNav,meNav];

//    [intelligenceNav.navigationBar setBackgroundImage:[UIImage imageNamed:@"lw_tabbar.jpg"] forBarMetrics:UIBarMetricsCompactPrompt];

    self.tabBar.unselectedItemTintColor = LW_RADOM_COLOR_NOALPHA;

    self.tabBar.tintColor = LW_RADOM_COLOR_NOALPHA;
    
//    UIImageView *ima = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"lw_tabbar.jpg"]];
//    ima.frame = CGRectMake(0,0,self.view.frame.size.width, self.tabBar.height);
    self.tabBar.opaque = YES;
    self.tabBar.translucent = YES;
//    [self.tabBar insertSubview:ima atIndex:0];
    [[UITabBar appearance] setBackgroundImage:[UIImage new]];
    [[UITabBar appearance] setShadowImage:[[UIImage alloc] init]];
}

- (void)messageCountChange:(NSNotification *)obj{
    
}

//-(void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
//    [tabBarController.viewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        if (obj == viewController) {
//            [viewController.tabBarItem setTitleTextAttributes:@{ NSForegroundColorAttributeName : [UIColor orangeColor],NSFontAttributeName:[UIFont boldSystemFontOfSize:14] } forState:UIControlStateNormal];
//        }else{
//            [obj.tabBarItem setTitleTextAttributes:@{ NSForegroundColorAttributeName : [UIColor grayColor],NSFontAttributeName:[UIFont boldSystemFontOfSize:12] } forState:UIControlStateNormal];
//        }
//    }];
//}

@end
