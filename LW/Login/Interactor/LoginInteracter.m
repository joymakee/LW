//
//  LoginViewModel.m
//  LW
//
//  Created by Joymake on 16/6/24.
//  Copyright © 2016年 joymake. All rights reserved.
//

#import "LoginInteracter.h"
#import <JoyTool.h>
#import <JoyTool.h>
@implementation LoginInteracter

-(void)getLoginDataSource{
    [self.dataArrayM removeAllObjects];
    JoyCellBaseModel *topicCellModel = [[JoyCellBaseModel alloc]init];
    topicCellModel.cellName = @"LWSingleLabelCell";
    topicCellModel.title = @"only life and work to do for my life";
    
    JoySectionBaseModel *topicSectionModel = [JoySectionBaseModel sectionWithHeaderModel:nil footerModel:nil cellModels:@[topicCellModel] sectionH:50 sectionTitle:nil];
    
    JoyCellBaseModel *headCellModel = [[JoyCellBaseModel alloc]init];
    headCellModel.changeKey = @"account";
    headCellModel.cellName = @"LoginHeadCell";
    headCellModel.tapAction = @"loginAction";
    
    JoySectionBaseModel *loginHeadSectionModel = [JoySectionBaseModel sectionWithHeaderModel:nil footerModel:nil cellModels:@[headCellModel] sectionH:20 sectionTitle:nil];
    
    JoyTextCellBaseModel *accountModel = [[JoyTextCellBaseModel alloc]init];
    accountModel.placeHolder = @"邮箱/手机号";
    accountModel.textFieldModel = normalModel;
    accountModel.changeKey = @"account";
    accountModel.cellName = @"LWTextFieldCell";
    accountModel.borderStyle = UITextBorderStyleRoundedRect;
    accountModel.keyboardType = UIKeyboardTypeEmailAddress;
    accountModel.changeKey = @"userName";
    
    JoyTextCellBaseModel *passwordModel = [[JoyTextCellBaseModel alloc]init];
    passwordModel.placeHolder = @"请输入密码";
    passwordModel.textFieldModel = normalModel;
    passwordModel.changeKey = @"password";
    passwordModel.cellName = @"LWTextFieldCell";
    passwordModel.borderStyle = UITextBorderStyleRoundedRect;
    passwordModel.keyboardType = UIKeyboardTypePhonePad;
    
    JoyTextCellBaseModel *loginAuthCellModel = [[JoyTextCellBaseModel alloc]init];
    loginAuthCellModel.cellName = @"LWLogin_wx&qqCell";
    
    JoySectionBaseModel *loginSectionModel = [JoySectionBaseModel sectionWithHeaderModel:nil footerModel:nil cellModels:@[accountModel,passwordModel,loginAuthCellModel] sectionH:30 sectionTitle:nil];
    [self.dataArrayM addObject:topicSectionModel];
    [self.dataArrayM addObject:loginHeadSectionModel];
    [self.dataArrayM addObject:loginSectionModel];
}

-(NSMutableArray *)dataArrayM{
    return _dataArrayM = _dataArrayM?:[NSMutableArray array];
}
@end
