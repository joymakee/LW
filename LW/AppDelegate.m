//
//  AppDelegate.m
//  LW
//
//  Created by Joymake on 2016/11/2.
//  Copyright © 2016年 joymake. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginVC.h"
#import <JoyRequest/Joy_NetCacheTool.h>
#import <GizWifiSDK/GizWifiSDK.h>
#import "LWUser.h"
#import <JoyKit/JoyRouter.h>
#import "LWTabbarVC.h"
#import <Availability.h>
//#undef  __AVAILABILITY_INTERNAL_WEAK_IMPORT
#define __AVAILABILITY_INTERNAL_WEAK_IMPORT \
__attribute__((weak_import,deprecated("API newer than Deployment Target.")))

extern  NSString * const lw_meal_key;
extern  NSString * const selectMealKey ;
extern  NSString * const deSelectMealKey;

@interface AppDelegate ()<GizWifiSDKDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window.backgroundColor = [UIColor whiteColor];
    [[JoyRouter sharedInstance]configScheme:@"joylw"];
    [GizWifiSDK sharedInstance].delegate = self;
    [GizWifiSDK startWithAppID:@"0fdee57c9dc24613b8f21000de4d29ec"];
    [GizWifiSDK setLogLevel:GizLogPrintI];
    [[LWUser shareInstance] setValueWithCache];
    [self.window makeKeyWindow];

    if([[LWUser shareInstance].password length]){
        [[JoyRouter sharedInstance] openNativeWithUrl:[NSURL URLWithString:@"joylw://tabBar/tabBar"]];
    }else{
        LoginVC *vc = [[LoginVC alloc]init];
        self.window.rootViewController = vc;
    }
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSDictionary *mealDict = [Joy_NetCacheTool scbuDictCacheForKey:lw_meal_key];
        if (!mealDict) {
            [Joy_NetCacheTool scbuCacheDict:@{selectMealKey:@[@"宫保鸡丁",@"西红柿炒鸡蛋",@"干锅菜花",@"鱼香肉丝",@"麻辣香锅",@"烩虾仁儿",@"炸子蟹",@"毛血旺",@"麻婆豆腐"],deSelectMealKey:@[@"铁板豆腐",@"黄焖鸡",@"红烧排骨",@"蚂蚁上树",@"沙拉",@"排骨汤"]} forKey:lw_meal_key];
        }
    });

    return YES;
}

// 实现系统事件通知回调
- (void)wifiSDK:(GizWifiSDK *)wifiSDK didNotifyEvent:(GizEventType)eventType eventSource:(id)eventSource eventID:(GizWifiErrorCode)eventID eventMessage: (NSString *)eventMessage {
    if(eventType == GizEventSDK) {
        // SDK发生异常的通知
        NSLog(@"SDK event happened: [%@] = %@", @(eventID), eventMessage);
    } else if(eventType == GizEventDevice) {
        // 设备连接断开时可能产生的通知
        GizWifiDevice* mDevice = (GizWifiDevice*)eventSource;
        NSLog(@"device mac %@ disconnect caused by %@", mDevice.macAddress, eventMessage);
    } else if(eventType == GizEventM2MService) {
        // M2M服务返回的异常通知
        NSLog(@"M2M domain %@ exception happened: [%@] = %@", (NSString*)eventSource, @(eventID), eventMessage);
    } else if(eventType == GizEventToken) {
        // token失效通知
        NSLog(@"token %@ expired: %@", (NSString*)eventSource, eventMessage);
    }
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    BOOL canOpenUrl = [[JoyRouter sharedInstance]openNativeWithUrl:url];
    return canOpenUrl;
}

-(BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
    BOOL canOpenUrl = [[JoyRouter sharedInstance]openNativeWithUrl:url];
    return canOpenUrl;
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options{
    BOOL canOpenUrl = [[JoyRouter sharedInstance]openNativeWithUrl:url];
    return canOpenUrl;

}
@end
