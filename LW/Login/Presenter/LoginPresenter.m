//
//  LoginPresenter.m
//  LW
//
//  Created by joymake on 2016/10/25.
//  Copyright © 2016年 joymake. All rights reserved.
//

#import "LoginPresenter.h"
#import "LoginInteracter.h"
#import <JoyTableAutoLayoutView.h>
#import <JoyTool.h>
#import "LWShareManager.h"
#import "LWTabbarVC.h"
#import <LocalAuthentication/LocalAuthentication.h>

@implementation LoginPresenter
-(void)reloadDataSource{
    [self.interactor getLoginDataSource];
    __weak __typeof (&*self)weakSelf = self;
    self.loginView.setDataSource(self.interactor.dataArrayM).reloadTable().cellDidSelect(^(NSIndexPath *indexPath, NSString *tapAction) {
        [weakSelf performTapAction:tapAction];
    }).cellTextEiditEnd(^(NSIndexPath *indexPath, NSString *content, NSString *key) {
        [[LWUser shareInstance]initUserInfoWithKey:key value:content];
    });
    [self deviceLogin];
}

#pragma mark  登录
- (void)loginAction{
    [UIApplication sharedApplication].keyWindow.rootViewController = [[LWTabbarVC alloc]init];
}

#pragma mark 指纹识别
- (void)deviceLogin{
    LAContext *context = [[LAContext alloc] init];
    NSError *error = nil;
    if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
        [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics
                localizedReason:@"Are you the device owner?"
                          reply:^(BOOL success, NSError *error) {
                              dispatch_async(dispatch_get_main_queue(), ^{
                                  if (error)
                                  {
                                      if (error.code == -2) return;
                                      [[JoyAlert shareAlert]showAlertViewWithTitle:@"Error" message:@"There was a problem verifying your identity." cancle:@"OK" confirm:nil alertBlock:nil];
                                  }
                                  else
                                  {
                                      success?[UIApplication sharedApplication].keyWindow.rootViewController = [[LWTabbarVC alloc]init]:nil;
                                  }
                              });
                          }];
    }
}

- (void)qqLogin{
 
    [LWShareManager shareInstance].qqLogin().loginSuccess(^{
        [UIApplication sharedApplication].keyWindow.rootViewController = [[LWTabbarVC alloc]init];
    }).loginCancle(^{
        
    }).loginWithoutNet(^{
        
    }).loginOut(^{
        
    }).loginFailure(^{
        
    });
}
@end
