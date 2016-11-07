//
//  LoginViewModel.m
//  LW
//
//  Created by Joymake on 16/6/24.
//  Copyright © 2016年 joymake. All rights reserved.
//

#import "LoginInteracter.h"
#import "LWTableSectionBaseModel.h"
#import "LWCellBaseModel.h"
@implementation LoginInteracter

-(void)getLoginDataSource{
    [self.dataArrayM removeAllObjects];
    LWCellBaseModel *topicCellModel = [[LWCellBaseModel alloc]init];
    topicCellModel.cellName = @"LWSingleLabelCell";
    topicCellModel.title = @"only life and work to do for my life";
    
    LWTableSectionBaseModel *topicSectionModel = [LWTableSectionBaseModel sectionWithHeaderModel:nil footerModel:nil cellModels:@[topicCellModel] sectionH:50 sectionTitle:nil];
    
    LWCellBaseModel *headCellModel = [[LWCellBaseModel alloc]init];
    headCellModel.changeKey = @"account";
    headCellModel.cellName = @"LoginHeadCell";
    headCellModel.tapAction = @"loginAction";
    
    LWTableSectionBaseModel *loginHeadSectionModel = [LWTableSectionBaseModel sectionWithHeaderModel:nil footerModel:nil cellModels:@[headCellModel] sectionH:20 sectionTitle:nil];
    
    LWCellBaseTextModel *accountModel = [[LWCellBaseTextModel alloc]init];
    accountModel.placeHolder = @"邮箱/手机号";
    accountModel.textFieldModel = normalModel;
    accountModel.changeKey = @"account";
    accountModel.cellName = @"LWTextFieldCell";
    accountModel.borderStyle = UITextBorderStyleRoundedRect;
    accountModel.keyboardType = UIKeyboardTypeEmailAddress;
    
    LWCellBaseTextModel *passwordModel = [[LWCellBaseTextModel alloc]init];
    passwordModel.placeHolder = @"请输入密码";
    passwordModel.textFieldModel = normalModel;
    passwordModel.changeKey = @"password";
    passwordModel.cellName = @"LWTextFieldCell";
    passwordModel.borderStyle = UITextBorderStyleRoundedRect;
    passwordModel.keyboardType = UIKeyboardTypePhonePad;
    
    LWCellBaseTextModel *loginAuthCellModel = [[LWCellBaseTextModel alloc]init];
    loginAuthCellModel.cellName = @"LWLogin_wx&qqCell";
    
    LWTableSectionBaseModel *loginSectionModel = [LWTableSectionBaseModel sectionWithHeaderModel:nil footerModel:nil cellModels:@[accountModel,passwordModel,loginAuthCellModel] sectionH:30 sectionTitle:nil];
    [self.dataArrayM addObject:topicSectionModel];
    [self.dataArrayM addObject:loginHeadSectionModel];
    [self.dataArrayM addObject:loginSectionModel];
}
@end
