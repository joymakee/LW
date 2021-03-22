//
//  GizCenter+Device.m
//  LW
//
//  Created by Joymake on 2021/3/4.
//  Copyright © 2021 joymake. All rights reserved.
//

#import "GizCenter+Device.h"


@interface GizCenter (Device)<GizWifiSDKDelegate,GizWifiDeviceDelegate>
@end
@implementation GizCenter (Device)


#pragma mark 接收设备列表变化上报，刷新UI
-(void)wifiSDK:(GizWifiSDK *)wifiSDK didDiscovered:(NSError *)result deviceList:(NSArray *)deviceList{
    // 提示错误原因
          if(result.code != GIZ_SDK_SUCCESS) {
              NSLog(@"result: %@", result.localizedDescription);
          }else{
              // 显示变化后的设备列表
              NSLog(@"discovered deviceList: %@", deviceList);
//              devices = deviceList;
              for (GizWifiDevice *device in deviceList) {
                  device.delegate = self;
                  [device setSubscribe:YES];
              }

          }
}

#pragma mark 订阅设备回调
- (void)device:(GizWifiDevice *)device didSetSubscribe:(NSError *)result isSubscribed:(BOOL)isSubscribed {
    if(result.code == GIZ_SDK_SUCCESS) {
        // 订阅或取消订阅成功
    }
}

/*
 绑定远端设备到服务器
 @param productKey 待绑定设备的productKey
 @param productSecret 待绑定设备的productSecret
 */
- (void)bindRemoteDeviceProductKey:(NSString *)productKey productSecret:(NSString *)productSecret{
    [[GizWifiSDK sharedInstance]bindRemoteDevice: [LWUser shareInstance].uid token:[LWUser shareInstance].token mac:@"" productKey:productKey productSecret:productSecret];
}

/*
 根据二维码绑定设备到服务器（此接口待发布）
 @param uid 用户登录或注册时得到的 uid
 @param token 用户登录或注册时得到的 token
 @param QRContent 二维码内容
 @see 对应的回调接口：[GizWifiSDKDelegate wifiSDK:didBindDevice:did:]
 */
- (void)bindDeviceByQRContent:(NSString *)QRContent{
//    [[GizWifiSDK sharedInstance] bindDeviceByQRCode:[LWUser shareInstance].uid token:[LWUser shareInstance].token QRContent:QRContent];
    [[GizWifiSDK sharedInstance] bindDeviceWithUid:[LWUser shareInstance].uid token:[LWUser shareInstance].token did:@"gcUY6SnicooEFbwtoXiQPA" passCode:@"123456" remark:nil];
    
}

-(void)wifiSDK:(GizWifiSDK *)wifiSDK didBindDevice:(NSError *)result did:(NSString *)did{
    if(result.code == GIZ_SDK_SUCCESS) {
        // 订阅或取消订阅成功
        NSLog(@"success");
    }else{
        NSLog(@"failure");
    }

}


/*
 从服务器解绑设备
 @param 用户登录或注册时得到的uid
 @param 用户登录或注册时得到的token
 @param 待解绑设备的did
 @see 对应的回调接口：[GizWifiSDKDelegate wifiSDK:didUnbindDevice:did:]
 */
- (void)unbindDevice:(NSString *)uid token:(NSString *)token did:(NSString *)did{
    
}

@end
