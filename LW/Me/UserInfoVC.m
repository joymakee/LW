//
//  UserInfoVC.m
//  LW
//
//  Created by Joymake on 2021/2/23.
//  Copyright © 2021 joymake. All rights reserved.
//

#import "UserInfoVC.h"
#import <JoyKit/JoyKit.h>
#import "JoyBaseVC+LWCategory.h"
#import "LWUser.h"
#import <JoyKit/JoyRouter.h>
#import <JoyKit/NSDate+JoyExtention.h>
#import "LWUser.h"
#import "UIView+Toast.h"
#import "GizCenter.h"
#import <GizWifiSDK/GizWifiSDK.h>

@interface UserInfoVC ()
@property (nonatomic,strong)JoyTableAutoLayoutView *meListView;
@property (nonatomic,strong)NSMutableArray *dataArrayM;
@property (nonatomic,strong)JoyDatePickView *dateView;
@property (nonatomic,strong)JoyPickerView *pickView;
@end

@implementation UserInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"用户信息";
    [self setRectEdgeAll];
    [self setBackViewWithImageName:nil bundleName:nil];
    [self setRightNavItemWithTitle:@"保存"];
    [self setDefaultConstraintWithView:self.meListView andTitle:nil];
    [self.view addSubview:self.dateView];
    [self.view addSubview:self.pickView];
    self.meListView.setDataSource(self.dataArrayM).reloadTable().cellDidSelect(^(NSIndexPath *indexPath, NSString *tapAction) {
        [super performTapAction:tapAction];
    }).cellTextEiditEnd(^(NSIndexPath *indexPath, NSString *content, NSString *key) {
    });
}

-(void)rightNavItemClickAction{
    GizUserInfo* additialInfo = GizUserInfo.new;
    additialInfo.name = [LWUser shareInstance].name;
    additialInfo.userGender = [[LWUser shareInstance].userGender integerValue];
    additialInfo.birthday = [NSDate getDateFormat:@"yyyy-MM-dd" dateStr:[LWUser shareInstance].birthday];
    additialInfo.address = [LWUser shareInstance].address;
    additialInfo.remark = [LWUser shareInstance].remark;
    @LwWeak(self);
    [[GizCenter shareInstance]changeUserInfoAdditionalInfo:additialInfo success:^{
        [self.view makeToast:@"修改成功"];
    } failure:^(NSError *error) {
        [self.view makeToast:@"修改失败"];
    }];
}

//修改昵称
- (void)updateNickNameAction{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"修改昵称" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.borderStyle = UITextBorderStyleNone;
        [textField setTextMaxNum:10];
        textField.textColor = JOY_RandomColor;
        textField.placeholder = @"请输入昵称";
    }];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:nil]];
    
    __weak __typeof(&*self)weakSelf = self;
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [LWUser shareInstance].name = alert.textFields.firstObject.text;
        JoySectionBaseModel *section = (JoySectionBaseModel *)weakSelf.dataArrayM.firstObject;
        JoyCellBaseModel *birthdayModel = [section.rowArrayM objectAtIndex:0];
        birthdayModel.title = alert.textFields.firstObject.text;
        [weakSelf.meListView reloadRow:[NSIndexPath indexPathForRow:0 inSection:0]];
    }]];

    [self presentViewController:alert animated:true completion:nil];
}

- (void)updateAddressAction{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"修改住址信息" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.borderStyle = UITextBorderStyleNone;
        [textField setTextMaxNum:60];
        textField.textColor = JOY_RandomColor;
        textField.placeholder = @"请输入住址信息";
    }];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:nil]];
    
    __weak __typeof(&*self)weakSelf = self;
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [LWUser shareInstance].address = alert.textFields.firstObject.text;
        JoySectionBaseModel *section = (JoySectionBaseModel *)weakSelf.dataArrayM.firstObject;
        JoyCellBaseModel *birthdayModel = [section.rowArrayM objectAtIndex:2];
        birthdayModel.title = alert.textFields.firstObject.text;
        [weakSelf.meListView reloadRow:[NSIndexPath indexPathForRow:2 inSection:0]];
    }]];

    [self presentViewController:alert animated:true completion:nil];
}

//修改备注
- (void)updateRemarkAction{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"修改备注" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.borderStyle = UITextBorderStyleNone;
        [textField setTextMaxNum:60];
        textField.textColor = JOY_RandomColor;
        textField.placeholder = @"请输入备注";
    }];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:nil]];
    
    __weak __typeof(&*self)weakSelf = self;
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [LWUser shareInstance].remark = alert.textFields.firstObject.text;
        JoySectionBaseModel *section = (JoySectionBaseModel *)weakSelf.dataArrayM.firstObject;
        JoyCellBaseModel *birthdayModel = [section.rowArrayM objectAtIndex:4];
        birthdayModel.title = alert.textFields.firstObject.text;
        [weakSelf.meListView reloadRow:[NSIndexPath indexPathForRow:4 inSection:0]];
    }]];

    [self presentViewController:alert animated:true completion:nil];
}


-(void)updateEmailAction{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"修改邮箱" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.borderStyle = UITextBorderStyleNone;
        [textField setTextMaxNum:60];
        textField.textColor = JOY_RandomColor;
        textField.placeholder = @"请输入邮箱";
    }];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:nil]];
    
    __weak __typeof(&*self)weakSelf = self;
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if([alert.textFields.firstObject.text isValidateEmail]){
            [LWUser shareInstance].email = alert.textFields.firstObject.text;
            JoySectionBaseModel *section = (JoySectionBaseModel *)weakSelf.dataArrayM.lastObject;
            JoyCellBaseModel *emailModel = [section.rowArrayM objectAtIndex:1];
            emailModel.title = alert.textFields.firstObject.text;
            [weakSelf.meListView reloadRow:[NSIndexPath indexPathForRow:1 inSection:1]];
        }
    }]];

    [self presentViewController:alert animated:true completion:nil];
}

-(void)updateBirthdayAction{
    [self.dateView showPickView];
//    UIDatePicker *picker = [[UIDatePicker alloc]initWithFrame:CGRectMake(100, self.view.bottom-600, self.view.width, 600)];
//    picker.datePickerMode = UIDatePickerModeDate;
//    [self.view addSubview:picker];
}

-(void)updateGenderAction{
    [self.pickView showPickView];
//    UIDatePicker *picker = [[UIDatePicker alloc]initWithFrame:CGRectMake(100, self.view.bottom-600, self.view.width, 600)];
//    picker.datePickerMode = UIDatePickerModeDate;
//    [self.view addSubview:picker];
}


-(JoyTableAutoLayoutView *)meListView{
    if (!_meListView) {
        _meListView = [[JoyTableAutoLayoutView alloc]init];
        _meListView.backgroundColor = _meListView.tableView.backgroundColor = [UIColor clearColor];
        _meListView.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _meListView;
}

-(JoyDatePickView *)dateView{
    if (!_dateView) {
        _dateView = [[JoyDatePickView alloc]init];
        [_dateView setToolbarLeftTitle:@"取消" textColor:UIColor.whiteColor];
        [_dateView setToolbarRightTitle:@"确定" textColor:UIColor.whiteColor];
        __weak __typeof(&*self)weakSelf = self;
        _dateView.entryClickBlock = ^(NSString *selectDate) {
            [LWUser shareInstance].birthday = selectDate;
            JoySectionBaseModel *section = (JoySectionBaseModel *)weakSelf.dataArrayM.firstObject;
            JoyCellBaseModel *birthdayModel = [section.rowArrayM objectAtIndex:3];
            birthdayModel.title = selectDate;
            [weakSelf.meListView reloadRow:[NSIndexPath indexPathForRow:3 inSection:0]];
        };
    }
    return _dateView;
}


-(JoyPickerView *)pickView{
    if (!_pickView) {
        _pickView = [[JoyPickerView alloc]init];
        [_pickView setToolbarLeftTitle:@"取消" textColor:UIColor.whiteColor];
        [_pickView setToolbarRightTitle:@"确定" textColor:UIColor.whiteColor];
        [_pickView reloadPickViewWithDataSource:@[@[@"男",@"女",@"其他"]]];
        __weak __typeof(&*self)weakSelf = self;
        _pickView.EntryBtnClickBlock = ^(NSMutableArray<JoyPickSelectedModel *> *selectedDataArrayM) {
            [LWUser shareInstance].userGender = [@(selectedDataArrayM.firstObject.row) stringValue];
            JoySectionBaseModel *section = (JoySectionBaseModel *)weakSelf.dataArrayM.firstObject;
            JoyCellBaseModel *birthdayModel = [section.rowArrayM objectAtIndex:1];
            birthdayModel.title = [LWUser shareInstance].genderStr;
            [weakSelf.meListView reloadRow:[NSIndexPath indexPathForRow:1 inSection:0]];
        };
    }
    return _pickView;
}


-(NSMutableArray *)dataArrayM{
    if (!_dataArrayM) {
        _dataArrayM = [NSMutableArray array];
        NSArray *userInfoList = @[
                @{@"title":[LWUser shareInstance].name?:@"昵称",@"icon":@"\ue7af",@"tapAction":@"updateNickNameAction"},
                @{@"title":[LWUser shareInstance].genderStr,@"icon":@"\ue632",@"tapAction":@"updateGenderAction"},
                @{@"title":[LWUser shareInstance].address?:@"住址",@"icon":@"\ue62c",@"tapAction":@"updateAddressAction"},
                @{@"title":[LWUser shareInstance].birthday?:@"生日",@"icon":@"\ue620",@"tapAction":@"updateBirthdayAction"},
                @{@"title":[LWUser shareInstance].remark?:@"备注",@"icon":@"\ue62b",@"tapAction":@"updateRemarkAction"}
        ];
        
        NSArray *accountInfoList = @[
                @{@"title":[LWUser shareInstance].phone?:@"手机号",@"icon":@"\ue639",@"tapAction":@"updatePhoneAction"},
                @{@"title":[LWUser shareInstance].email?:@"邮箱",@"icon":@"\ue61e",@"tapAction":@"updateEmailAction"},
        ];
        
        JoySectionBaseModel *userInfoSection = [[JoySectionBaseModel alloc]init];
        userInfoSection.sectionTitle = @"基本信息";
        for (NSDictionary *dict in userInfoList) {
            JoyCellBaseModel *cellModel = [[JoyCellBaseModel alloc]init];
            cellModel.title = dict[@"title"];
            cellModel.subTitle = dict[@"icon"];
            cellModel.cellName =@"LWIconTextCell";
            cellModel.tapAction = dict[@"tapAction"];
            [userInfoSection.rowArrayM addObject:cellModel];
        }
        
        JoySectionBaseModel *accountInfoSection = [[JoySectionBaseModel alloc]init];
        accountInfoSection.sectionTitle = @"账号信息";
        for (NSDictionary *dict in accountInfoList) {
            JoyCellBaseModel *cellModel = [[JoyCellBaseModel alloc]init];
            cellModel.title = dict[@"title"];
            cellModel.subTitle = dict[@"icon"];
            cellModel.cellName =@"LWIconTextCell";
            cellModel.tapAction = dict[@"tapAction"];
            [accountInfoSection.rowArrayM addObject:cellModel];
        }
        [_dataArrayM addObject:userInfoSection];
        [_dataArrayM addObject:accountInfoSection];
    }
    return _dataArrayM;
}

@end
