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
#import <GizWifiSDK/GizWifiSDK.h>

@interface UserInfoVC ()
@property (nonatomic,strong)JoyTableAutoLayoutView *meListView;
@property (nonatomic,strong)NSMutableArray *dataArrayM;
@end

@implementation UserInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"用户信息";
    [self setRectEdgeAll];
    [self setBackViewWithImageName:nil bundleName:nil];
    [self setDefaultConstraintWithView:self.meListView andTitle:nil];
    self.meListView.setDataSource(self.dataArrayM).reloadTable().cellDidSelect(^(NSIndexPath *indexPath, NSString *tapAction) {
        [super performTapAction:tapAction];
    }).cellTextEiditEnd(^(NSIndexPath *indexPath, NSString *content, NSString *key) {
    });
    
    
}

- (void)updateNickNameAction{
   
    GizUserInfo* additialInfo = GizUserInfo.new;
    additialInfo.name = @"LW";
    additialInfo.userGender = GizUserGenderMale;
    additialInfo.birthday = [NSDate getDateFormat:@"yyyy-MM-dd" dateStr:@"2000-01-01"];
    additialInfo.address = @"Beijing";
    additialInfo.remark = @"Life And Work";
    [GizWifiSDK sharedInstance].delegate = self;

    [[GizWifiSDK sharedInstance]changeUserInfo:[LWUser shareInstance].token username:nil SMSVerifyCode:nil accountType:GizUserNormal additionalInfo:additialInfo];
}
// 实现回调
- (void)wifiSDK:(GizWifiSDK *)wifiSDK didChangeUserInfo:(NSError *)result {
    if(result.code == GIZ_SDK_SUCCESS) {
        // 修改成功
    } else {
        // 修改失败
    }
}
-(void)updateBirthdayAction{
//    UIDatePicker *picker = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, self.view.bottom-400, self.view.width, 400)];
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

-(NSMutableArray *)dataArrayM{
    if (!_dataArrayM) {
        _dataArrayM = [NSMutableArray array];
        NSArray *userInfoList = @[
                                  @{@"title":[LWUser shareInstance].name?:@"昵称",@"icon":@"\ue7af",@"tapAction":@"updateNickNameAction"},
                                  @{@"title":[LWUser shareInstance].genderStr,@"icon":@"\ue632",@"tapAction":@"updateGenderAction"},
                                  @{@"title":[LWUser shareInstance].phone?:@"手机号",@"icon":@"\ue639",@"tapAction":@"updatePhoneAction"},
                                  @{@"title":[LWUser shareInstance].email?:@"邮箱",@"icon":@"\ue61e",@"tapAction":@"updateEmailAction"},
                                  @{@"title":[LWUser shareInstance].address?:@"住址",@"icon":@"\ue62c",@"tapAction":@"updateAddressAction"},
                                  @{@"title":[LWUser shareInstance].birthday?:@"生日",@"icon":@"\ue620",@"tapAction":@"updateBirthdayAction"},
                                  @{@"title":[LWUser shareInstance].remark?:@"备注",@"icon":@"\ue62b",@"tapAction":@"updateRemarkAction"}
        ];
        
        for (NSDictionary *dict in userInfoList) {
            JoyCellBaseModel *cellModel = [[JoyCellBaseModel alloc]init];
            cellModel.title = dict[@"title"];
            cellModel.subTitle = dict[@"icon"];
            cellModel.cellName =@"LWIconTextCell";
            cellModel.tapAction = dict[@"tapAction"];
            [_dataArrayM addObject:cellModel];
        }
    }
    return _dataArrayM;
}

@end
