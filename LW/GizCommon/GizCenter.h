//
//  GizCenter.h
//  LW
//
//  Created by Joymake on 2021/3/3.
//  Copyright © 2021 joymake. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GizWifiSDK/GizWifiSDK.h>
#import "LWUser.h"

NS_ASSUME_NONNULL_BEGIN

@class GizUserInfo;
@interface GizCenter : NSObject
+ (instancetype)shareInstance;

#pragma mark 初始化参数
- (void)configGizPara;

#pragma mark 登录
- (void)loginWithPhone:(NSString *)phone password:(NSString *)password success:(DICTBLOCK)success failure:(ERRORBLOCK)failure;

#pragma mark 获取手机验证码
/// @param phone 手机号码
- (void)requestSendPhoneSMSCodeWithPhone:(NSString *)phone success:(VOIDBLOCK)success failure:(ERRORBLOCK)failure;

#pragma mark 注册用户信息
-(void)registUserPhone:(NSString *)phone password:(NSString *)password verifyCode:(NSString *)verifyCode success:(VOIDBLOCK)success failure:(ERRORBLOCK)failure;

#pragma mark 重置密码
- (void)resetPasswordWithPassword:(NSString *)password verifyCode:(NSString *)verifyCode phone:(NSString *)phone success:(VOIDBLOCK)success failure:(ERRORBLOCK)failure;

#pragma mark 修改用户信息
-(void)changeUserInfoAdditionalInfo:(GizUserInfo *)additialInfo success:(VOIDBLOCK)success failure:(ERRORBLOCK)failure;
@end

NS_ASSUME_NONNULL_END
