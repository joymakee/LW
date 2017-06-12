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

@interface LoginPresenter ()<TextChangedDelegete>

@end

@implementation LoginPresenter
-(void)reloadDataSource{
    [self.interactor getLoginDataSource];
    self.loginView.dataArrayM = self.interactor.dataArrayM;
    [self.loginView reloadTableView];
    [self deviceLogin];
}

-(void)setLoginView:(JoyTableAutoLayoutView *)loginView{
    _loginView = loginView;
    _loginView.delegate = self;
    __weak __typeof (&*self)weakSelf = self;
    _loginView.tableDidSelectBlock = ^(NSIndexPath *indexPath,NSString *tapAction){
        [super performTapAction:tapAction];
    };
}

#pragma mark  登录
- (void)loginAction{
    {
        [UIApplication sharedApplication].keyWindow.rootViewController = [[LWTabbarVC alloc]init];
    }
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

-(void)viewAction:(NSString *)action indexPath:(NSIndexPath *)indexPath object:(id)obj{
//    [[LWShareManager shareInstance]loginWithPlatform:obj];
    [[LWShareManager shareInstance]tencentLogin];

}

-(void)textFieldChangedWithIndexPath:(NSIndexPath *)indexPath andChangedText:(NSString *)content andChangedKey:(NSString *)key{
    [[LWUser shareInstance]initUserInfoWithKey:key value:content];
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
