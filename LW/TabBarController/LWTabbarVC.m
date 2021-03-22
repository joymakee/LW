//
//  LWTabbarVC.m
//  LW
//
//  Created by joymake on 16/7/5.
//  Copyright © 2016年 joymake. All rights reserved.
//

#import "LWTabbarVC.h"
#import "LWMediaListVC.h"
#import "IntelligenceVC.h"
#import "LWNavigationController.h"
#import "LWChatListVC.h"
#import "MeVC.h"
#import <JoyKit/JoyRouter.h>
#import "CALayer+JoyLayer.h"

NSInteger messageCount = 0;
NSString  *KMESSAGE_COUNT_CHANGE = @"messageCountChange";

@interface LWTabbarVC ()<UITabBarControllerDelegate,JoyRouteProtocol>
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
    
    NSArray *tabbarList= @[@{@"title":@"消息",@"class":LWChatListVC.class,@"image":@"tabBar_message",@"badgeValue":[@(messageCount) stringValue]},
                           @{@"title":@"休闲",@"class":LWMediaListVC.class,@"image":@"tabBar_live"},
                           @{@"title":@"生活",@"class":IntelligenceVC.class,@"image":@"tabBar_intelligence",@"badgeValue":@"8"},
                           @{@"title":@"我的",@"class":MeVC.class,@"image":@"tabBar_me"}];
    
    NSMutableArray *vcList = [NSMutableArray arrayWithCapacity:4];
    [tabbarList enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        Class VCClass = obj[@"class"];
        JoyBaseVC *vc = [[VCClass alloc]init];
        vc.tabBarItem.badgeValue = obj[@"badgeValue"];
        vc.tabBarItem = [[UITabBarItem alloc]initWithTitle:obj[@"title"] image:[UIImage imageNamed:obj[@"image"]] tag:0];
        LWNavigationController *vcNav = [[LWNavigationController alloc]initWithRootViewController:vc];
        [vcNav.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        [vcNav.navigationBar setShadowImage:[UIImage new]];
        vcNav.navigationBar.translucent = YES;
        vcNav.edgesForExtendedLayout = UIRectEdgeAll;
        [vcList addObject:vcNav];
    }];
    
    self.viewControllers = [NSArray arrayWithArray:vcList];
    self.tabBar.unselectedItemTintColor = LW_RADOM_COLOR_NOALPHA;
    self.tabBar.tintColor = LW_RADOM_COLOR_NOALPHA;;
    self.tabBar.opaque = YES;
    self.tabBar.translucent = YES;
    [[UITabBar appearance] setBackgroundImage:[UIImage new]];
    [[UITabBar appearance] setShadowImage:[[UIImage alloc] init]];
}

- (void)messageCountChange:(NSNotification *)obj{
    
}

-(void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{

//    [tabBarController.viewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        if (obj == viewController) {
//            [viewController.tabBarItem setTitleTextAttributes:@{ NSForegroundColorAttributeName : [UIColor orangeColor],NSFontAttributeName:[UIFont boldSystemFontOfSize:14] } forState:UIControlStateNormal];
//        }else{
//            [obj.tabBarItem setTitleTextAttributes:@{ NSForegroundColorAttributeName : [UIColor grayColor],NSFontAttributeName:[UIFont boldSystemFontOfSize:12] } forState:UIControlStateNormal];
//        }
//    }];
}

@end
