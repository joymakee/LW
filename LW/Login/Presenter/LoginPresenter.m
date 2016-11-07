//
//  LoginPresenter.m
//  LW
//
//  Created by joymake on 2016/10/25.
//  Copyright © 2016年 joymake. All rights reserved.
//

#import "LoginPresenter.h"
#import "LoginInteracter.h"
#import "LWTableAutoLayoutView.h"
#import "LWTableSectionBaseModel.h"
#import "LWCellBaseModel.h"
#import "LWShareManager.h"
#import "LWTabbarVC.h"
#import <LocalAuthentication/LocalAuthentication.h>

@implementation LoginPresenter
-(void)reloadDataSource{
    [self.interactor getLoginDataSource];
    self.loginView.dataArrayM = self.interactor.dataArrayM;
    [self.loginView reloadTableView];
}

-(void)setLoginView:(LWTableAutoLayoutView *)loginView{
    _loginView = loginView;
    __weak __typeof (&*self)weakSelf = self;
    _loginView.tableDidSelectBlock = ^(NSIndexPath *indexPath){
        [weakSelf tableVIewDidSelect:indexPath];
    };

    _loginView.tableCellActionBlock =^(NSString *action,NSIndexPath *indexPath,id obj){
        [super performAction:action :indexPath :obj];
    };
    
}

-(void)tableVIewDidSelect:(NSIndexPath *)indexPath{
    LWTableSectionBaseModel *sectionModel = [self.interactor.dataArrayM objectAtIndex:indexPath.section];
    LWCellBaseModel * selectModel  = sectionModel.rowArrayM[indexPath.row];
    [super performTapAction:selectModel.tapAction];
}

#pragma mark 指纹识别
- (void)loginAction{
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
                                  UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                                  message:@"There was a problem verifying your identity."
                                                                                 delegate:nil
                                                                        cancelButtonTitle:@"Ok"
                                                                        otherButtonTitles:nil];
                                  [alert show];
                              }
                              else
                              {
                              success?[UIApplication sharedApplication].keyWindow.rootViewController = [[LWTabbarVC alloc]init]:nil;
                              }
                              });
                          }];
    }
    else
    {
        [UIApplication sharedApplication].keyWindow.rootViewController = [[LWTabbarVC alloc]init];
    }
    

}

-(void)viewAction:(NSString *)action indexPath:(NSIndexPath *)indexPath object:(id)obj{
    [[LWShareManager shareInstance]loginWithPlatform:obj];
}

@end
