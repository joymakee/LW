//
//  GizCenter.m
//  LW
//
//  Created by Joymake on 2021/3/3.
//  Copyright © 2021 joymake. All rights reserved.
//

#import "GizCenter.h"
#import <JoyKit/NSDate+JoyExtention.h>
#import "GizCenter+Device.h"

@interface GizCenter ()<GizWifiSDKDelegate>

@end

NSString * const gizYunAppSecret = @"cafa0b57b6474465bac366cfd048338d";
NSString * const gizYunAppId     = @"0a9a96023f5d4d19ac32112a2dd74984";
NSString * const productKey   = @"f9d5a30a0d564e719b45352a557bb430";

@implementation GizCenter
+ (instancetype)shareInstance{
    static id giz = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        giz = [[super alloc]init];
    });
    return giz;
}

#pragma mark 初始化参数
- (void)configGizPara{
    [GizWifiSDK sharedInstance].delegate = self;
    [GizWifiSDK startWithAppID:gizYunAppId];
    [GizWifiSDK setLogLevel:GizLogPrintI];
}

#pragma mark 登录接口
static NSString *KLoginSuccesskey = @"KLoginSuccesskey";
static NSString *KLoginFailurekey = @"KLoginFailurekey";
- (void)loginWithPhone:(NSString *)phone password:(NSString *)password success:(DICTBLOCK)success failure:(ERRORBLOCK)failure{
    objc_setAssociatedObject(self, &KLoginSuccesskey, success, OBJC_ASSOCIATION_COPY);
    objc_setAssociatedObject(self, &KLoginFailurekey, failure, OBJC_ASSOCIATION_COPY);
    [[GizWifiSDK sharedInstance] userLogin:phone password:password];
}

#pragma mark 登录回调
- (void)wifiSDK:(GizWifiSDK *)wifiSDK didUserLogin:(NSError *)result uid:(NSString *)uid token:(NSString *)token {
    if(result.code == GIZ_SDK_SUCCESS) {
        [LWUser shareInstance].uid = uid;
        [LWUser shareInstance].token = token;
        [[GizWifiSDK sharedInstance] getUserInfo:token];//获取用户信息
    } else {
        ERRORBLOCK failureBlock = objc_getAssociatedObject(self, &KLoginFailurekey);
        failureBlock?failureBlock(result):nil;
    }
}

#pragma mark 获取用户信息回调
- (void)wifiSDK:(GizWifiSDK *)wifiSDK didGetUserInfo:(NSError *)result userInfo:(GizUserInfo*)userInfo{
    if(result.code == GIZ_SDK_SUCCESS) {
        [[LWUser shareInstance] setValuesForKeysWithDictionary:userInfo.mj_keyValues];
        if (userInfo.birthday){
            [LWUser shareInstance].birthday = [userInfo.birthday timeStringformat:@"yyyy-MM-dd"];
        }
        [[LWUser shareInstance] cacheUserInfo];
        DICTBLOCK successBlock = objc_getAssociatedObject(self, &KLoginSuccesskey);
        successBlock?successBlock(@{}):nil;
    }else{
        ERRORBLOCK failureBlock = objc_getAssociatedObject(self, &KLoginFailurekey);
        failureBlock?failureBlock(result):nil;
    }
}

#pragma mark 获取手机验证码
static NSString *KgetSMSCodeSuccesskey = @"KgetSMSCodeSuccesskey";
static NSString *KgetSMSCodeFailurekey = @"KgetSMSCodeFailurekey";
- (void)requestSendPhoneSMSCodeWithPhone:(NSString *)phone success:(VOIDBLOCK)success failure:(ERRORBLOCK)failure{
    [[GizWifiSDK sharedInstance] requestSendPhoneSMSCode:gizYunAppSecret phone:phone];
    objc_setAssociatedObject(self, &KgetSMSCodeSuccesskey, success, OBJC_ASSOCIATION_COPY);
    objc_setAssociatedObject(self, &KgetSMSCodeFailurekey, failure, OBJC_ASSOCIATION_COPY);
}
#pragma mark 获取验证码回调
- (void)wifiSDK:(GizWifiSDK *)wifiSDK didRequestSendPhoneSMSCode:(NSError *)result token:(NSString *)token {
    if(result.code == GIZ_SDK_SUCCESS) {
        VOIDBLOCK successBlock = objc_getAssociatedObject(self, &KgetSMSCodeSuccesskey);
        successBlock?successBlock():nil;
    } else {
        ERRORBLOCK failureBlock = objc_getAssociatedObject(self, &KgetSMSCodeFailurekey);
        failureBlock?failureBlock(result):nil;
    }
}

static NSString *KregistSuccesskey = @"KregistSuccesskey";
static NSString *KregistFailurekey = @"KregistFailurekey";
#pragma mark 注册用户信息
-(void)registUserPhone:(NSString *)phone password:(NSString *)password verifyCode:(NSString *)verifyCode success:(VOIDBLOCK)success failure:(ERRORBLOCK)failure{
    objc_setAssociatedObject(self, &KregistSuccesskey, success, OBJC_ASSOCIATION_COPY);
    objc_setAssociatedObject(self, &KregistFailurekey, failure, OBJC_ASSOCIATION_COPY);
    [[GizWifiSDK sharedInstance] registerUser:phone password:password verifyCode:verifyCode accountType:GizUserPhone];
}

#pragma mark 实现注册用户回调
- (void)wifiSDK:(GizWifiSDK *)wifiSDK didRegisterUser:(NSError *)result uid:(NSString *)uid token:(NSString *)token{
    if(result.code == GIZ_SDK_SUCCESS) {
        VOIDBLOCK successBlock = objc_getAssociatedObject(self, &KregistSuccesskey);
        successBlock?successBlock():nil;
    } else {
        ERRORBLOCK failureBlock = objc_getAssociatedObject(self, &KregistFailurekey);
        failureBlock?failureBlock(result):nil;
    }
}

static NSString *KUpdateUserInfoSuccesskey = @"KUpdateUserInfoSuccesskey";
static NSString *KUpdateUserInfoFailurekey = @"KUpdateUserInfoFailurekey";
#pragma mark 修改用户信息
-(void)changeUserInfoAdditionalInfo:(GizUserInfo *)additialInfo success:(VOIDBLOCK)success failure:(ERRORBLOCK)failure{
    objc_setAssociatedObject(self, &KUpdateUserInfoSuccesskey, success, OBJC_ASSOCIATION_COPY);
    objc_setAssociatedObject(self, &KUpdateUserInfoFailurekey, failure, OBJC_ASSOCIATION_COPY);
    [[GizWifiSDK sharedInstance]changeUserInfo:[LWUser shareInstance].token username:[LWUser shareInstance].email?:nil SMSVerifyCode:nil accountType:GizUserNormal additionalInfo:additialInfo];
}

#pragma mark 获取用户信息成功回调
- (void)wifiSDK:(GizWifiSDK *)wifiSDK didChangeUserInfo:(NSError *)result {
    if(result.code == GIZ_SDK_SUCCESS) {
        VOIDBLOCK successBlock = objc_getAssociatedObject(self, &KUpdateUserInfoSuccesskey);
        successBlock?successBlock():nil;
        [[LWUser shareInstance]cacheUserInfo];
    } else {
        ERRORBLOCK failureBlock = objc_getAssociatedObject(self, &KUpdateUserInfoFailurekey);
        failureBlock?failureBlock(result):nil;
    }
}

#pragma mark 重置密码
static NSString *KresetPasswordSuccesskey = @"KresetPasswordSuccesskey";
static NSString *KresetPasswordFailurekey = @"KresetPasswordFailurekey";
- (void)resetPasswordWithPassword:(NSString *)password verifyCode:(NSString *)verifyCode phone:(NSString *)phone success:(VOIDBLOCK)success failure:(ERRORBLOCK)failure{
    [[GizWifiSDK sharedInstance] resetPassword:phone verifyCode:verifyCode newPassword:password accountType:GizUserPhone];
    objc_setAssociatedObject(self, &KresetPasswordSuccesskey, success, OBJC_ASSOCIATION_COPY);
    objc_setAssociatedObject(self, &KresetPasswordFailurekey, success, OBJC_ASSOCIATION_COPY);
}

#pragma mark 重置密码实现回调
- (void)wifiSDK:(GizWifiSDK *)wifiSDK didChangeUserPassword:(NSError *)result {
    if(result.code == GIZ_SDK_SUCCESS) {
        VOIDBLOCK successBlock = objc_getAssociatedObject(self, &KresetPasswordSuccesskey);
        successBlock?successBlock():nil;
    } else {
        ERRORBLOCK failureBlock = objc_getAssociatedObject(self, &KresetPasswordFailurekey);
        failureBlock?failureBlock(result):nil;
    }
}


#pragma mark 实现系统事件通知回调
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
@end
