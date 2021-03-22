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
#import <JoyKit/JoyKit.h>
#import "LWShareManager.h"
#import "LWTabbarVC.h"
#import <LocalAuthentication/LocalAuthentication.h>
#import "UIView+Toast.h"
#import "GizCenter.h"

@interface LoginPresenter ()

@end

@implementation LoginPresenter
-(void)reloadDataSource{
    [self.interactor getLoginDataSource];
    __weak __typeof (&*self)weakSelf = self;
    self.loginView.setDataSource(self.interactor.dataArrayM).reloadTable().cellDidSelect(^(NSIndexPath *indexPath, NSString *tapAction) {
        [weakSelf performTapAction:tapAction];
    }).cellTextEiditEnd(^(NSIndexPath *indexPath, NSString *content, NSString *key) {
        [[LWUser shareInstance] setValue:content forKey:key];
    });
    if ([LWUser shareInstance].token) {
        [self deviceLogin];
    }
}

#pragma mark  登录
- (void)loginAction{
    if([LWUser shareInstance].userName.length && [LWUser shareInstance].password.length){
        @LwWeak(self);
        [[GizCenter shareInstance] loginWithPhone:[LWUser shareInstance].userName password:[LWUser shareInstance].password success:^(NSDictionary *dict) {
            [self.rootView makeToast:@"Login Success"];
            [UIApplication sharedApplication].keyWindow.rootViewController = [[LWTabbarVC alloc]init];
        } failure:^(NSError *error) {
            [self.rootView makeToast:error.description];
        }];
    }else{
        [self.rootView makeToast:@"请输入手机号和密码"];
    }
}

- (void)registAction{
    if([LWUser shareInstance].userName.length ==11 && [LWUser shareInstance].password.length>=6){
        @LwWeak(self);
        [[GizCenter shareInstance] requestSendPhoneSMSCodeWithPhone:[LWUser shareInstance].userName success:^{
            [self registPhone];
        } failure:^(NSError *error) {
            [self registPhone];
        }];
    }else{
        [self.rootView makeToast:@"请输入注册手机号和密码"];
    }
}

-(void)registPhone{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"注册账号" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.borderStyle = UITextBorderStyleNone;
        [textField setTextMaxNum:6];
        textField.textColor = JOY_RandomColor;
        textField.placeholder = @"请输入验证码";
    }];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:nil]];
    
    @LwWeak(self);
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if(alert.textFields.firstObject.text.length>=4){
            [[GizCenter shareInstance] registUserPhone:[LWUser shareInstance].userName password:[LWUser shareInstance].password verifyCode:alert.textFields.firstObject.text success:^{
                [self.rootView makeToast:@"注册成功"];
                [self loginAction];
            } failure:^(NSError *error) {
                [self.rootView makeToast:error.description];
            }];
        }
    }]];

    [self.currentVC presentViewController:alert animated:true completion:nil];
}

- (void)registPasswordAction{
    if([LWUser shareInstance].userName.length ==11 && [LWUser shareInstance].password.length>=6){
        @LwWeak(self);
        [[GizCenter shareInstance] requestSendPhoneSMSCodeWithPhone:[LWUser shareInstance].userName success:^{
            [self reSetPasswordAction];
        } failure:^(NSError *error) {
            [self reSetPasswordAction];
        }];
    }else{
        [self.rootView makeToast:@"重置密码请输入手机号和新密码"];
    }
}

-(void)reSetPasswordAction{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"重置密码" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.borderStyle = UITextBorderStyleNone;
        [textField setTextMaxNum:6];
        textField.textColor = JOY_RandomColor;
        textField.placeholder = @"请输入验证码";
    }];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:nil]];
    
    @LwWeak(self);
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if(alert.textFields.firstObject.text.length>=4){
            [[GizCenter shareInstance] resetPasswordWithPassword:[LWUser shareInstance].password verifyCode:alert.textFields.firstObject.text phone:[LWUser shareInstance].userName success:^{
                [self.rootView makeToast:@"修改成功"];
                [self loginAction];
            } failure:^(NSError *error) {
                [self.rootView makeToast:error.description];
            }];
        }
    }]];

    [self.currentVC presentViewController:alert animated:true completion:nil];
}

#pragma mark 指纹识别
- (void)deviceLogin{
    LAContext *context = [[LAContext alloc] init];
    NSError *error = nil;
    if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
        [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:@"Are you the device owner?" reply:^(BOOL success, NSError *error) {
          dispatch_async(dispatch_get_main_queue(), ^{
              if (error){
                  if (error.code == -2)
                      return;
                  [[JoyAlert shareAlert]showAlertViewWithTitle:@"Error" message:@"There was a problem verifying your identity." cancle:@"OK" confirm:nil alertBlock:nil];
              }else{
                  success?[self loginAction]:nil;
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
