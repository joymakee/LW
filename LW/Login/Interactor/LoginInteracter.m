//
//  LoginViewModel.m
//  LW
//
//  Created by Joymake on 16/6/24.
//  Copyright © 2016年 joymake. All rights reserved.
//

#import "LoginInteracter.h"
#import <JoyKit/JoyKit.h>
#import <JoyKit/JoyKit.h>
#import <GizWifiSDK/GizWifiSDK.h>
#import "LWUser.h"
@interface LoginInteracter ()<GizWifiSDKDelegate>
@property (nonatomic,copy)DICTBLOCK successBlock;
@property (nonatomic,copy)ERRORBLOCK failureBlock;

@end

@implementation LoginInteracter

-(void)getLoginDataSource{
    [self.dataArrayM removeAllObjects];
    JoyCellBaseModel *topicCellModel = [[JoyCellBaseModel alloc]init];
    topicCellModel.cellName = @"LWSingleLabelCell";
    topicCellModel.title = @"only life and work to do for my life";
    topicCellModel.cellType = ECellXibType;
    
    JoySectionBaseModel *topicSectionModel = [JoySectionBaseModel sectionWithHeaderModel:nil footerModel:nil cellModels:@[topicCellModel] sectionH:50 sectionTitle:nil];
    
    JoyCellBaseModel *headCellModel = [[JoyCellBaseModel alloc]init];
    headCellModel.changeKey = @"account";
    headCellModel.cellName = @"LoginHeadCell";
    headCellModel.tapAction = @"loginAction";
    headCellModel.cellType = ECellXibType;

    JoySectionBaseModel *loginHeadSectionModel = [JoySectionBaseModel sectionWithHeaderModel:nil footerModel:nil cellModels:@[headCellModel] sectionH:20 sectionTitle:nil];
    
    JoyTextCellBaseModel *accountModel = [[JoyTextCellBaseModel alloc]init];
    accountModel.placeHolder = @"邮箱/手机号";
    accountModel.title = [LWUser shareInstance].userName;
    accountModel.textFieldModel = normalModel;
    accountModel.changeKey = @"account";
    accountModel.cellName = @"LWTextFieldCell";
    accountModel.borderStyle = UITextBorderStyleRoundedRect;
    accountModel.keyboardType = UIKeyboardTypeEmailAddress;
    accountModel.changeKey = @"userName";
    accountModel.cellType = ECellXibType;
    
    JoyTextCellBaseModel *passwordModel = [[JoyTextCellBaseModel alloc]init];
    passwordModel.placeHolder = @"请输入密码";
    passwordModel.textFieldModel = normalModel;
    passwordModel.changeKey = @"password";
    passwordModel.cellName = @"LWTextFieldCell";
    passwordModel.borderStyle = UITextBorderStyleRoundedRect;
    passwordModel.keyboardType = UIKeyboardTypePhonePad;
    passwordModel.cellType = ECellXibType;
    
    JoyTextCellBaseModel *loginAuthCellModel = [[JoyTextCellBaseModel alloc]init];
    loginAuthCellModel.cellName = @"LWLogin_wx&qqCell";
    loginAuthCellModel.cellType = ECellXibType;
    
    JoySectionBaseModel *loginSectionModel = [JoySectionBaseModel sectionWithHeaderModel:nil footerModel:nil cellModels:@[accountModel,passwordModel,loginAuthCellModel] sectionH:30 sectionTitle:nil];
    [self.dataArrayM addObject:topicSectionModel];
    [self.dataArrayM addObject:loginHeadSectionModel];
    [self.dataArrayM addObject:loginSectionModel];
}

- (void)loginWithPhone:(NSString *)phone password:(NSString *)password success:(DICTBLOCK)success failure:(ERRORBLOCK)failure{
    [GizWifiSDK sharedInstance].delegate = self;
    self.successBlock = success;
    self.failureBlock = failure;
    [[GizWifiSDK sharedInstance] userLogin:phone password:password];
}

// 实现回调
- (void)wifiSDK:(GizWifiSDK *)wifiSDK didUserLogin:(NSError *)result uid:(NSString *)uid token:(NSString *)token {
    if(result.code == GIZ_SDK_SUCCESS) {
        [LWUser shareInstance].uid = uid;
        [LWUser shareInstance].token = token;
        [[LWUser shareInstance] cacheUserInfo];
        self.successBlock?self.successBlock(@{@"uid":uid,@"token":token}):nil;
    } else {
        self.failureBlock?self.failureBlock(result):nil;
    }
}

-(NSMutableArray *)dataArrayM{
    return _dataArrayM = _dataArrayM?:[NSMutableArray array];
}
@end
