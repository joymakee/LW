//
//  LWChatListPresenter.m
//  LW
//
//  Created by wangguopeng on 2017/2/14.
//  Copyright © 2017年 joymake. All rights reserved.
//

#import "LWChatListPresenter.h"
#import "LWChatListInteractor.h"
#import <JoyTableAutoLayoutView.h>
#import "LWChatVC.h"
#import "LWChatListCellModel.h"
#import <JoyTool.h>

@interface LWChatListPresenter ()<UITextFieldDelegate>
@property (nonatomic,weak)UITextField *hostAddressText;
@end

NSString *KHostAddressUserdefaultStr = @"hostAddressStr";

@implementation LWChatListPresenter
-(void)reloadDataSource{
    __weak typeof (&*self)weakSelf = self;
    [self.chatInteractor getChatListInfo:^{
        [weakSelf reloadTable];
    }];
}

-(void)setChatView:(JoyTableAutoLayoutView *)chatView{
    _chatView = chatView;
    __weak typeof (&*self)weakSelf = self;
    _chatView.tableDidSelectBlock = ^(NSIndexPath *indexPath,NSString *tapAction){
        [weakSelf tableVIewDidSelect:indexPath];
    };
}

-(void)tableVIewDidSelect:(NSIndexPath *)indexPath{
    JoySectionBaseModel *sectionModel = [self.chatInteractor.dataArrayM objectAtIndex:indexPath.section];
    LWChatListCellModel * selectModel  = sectionModel.rowArrayM[indexPath.row];
    [super performTapAction:selectModel.tapAction];
    if (selectModel.messageCount) {
        selectModel.messageCount = 0;
        [self.chatView reloadRow:indexPath];
    }
}

- (void)reloadTable{
    self.chatView.dataArrayM = self.chatInteractor.dataArrayM;
    [self.chatView reloadTableView];
}

- (void)goChatVC{
    LWChatVC *chatVC = [[LWChatVC alloc]init];
    [self goVC:chatVC];
}

-(void)leftNavItemClickAction{

    NSString *hostStr = [[NSUserDefaults standardUserDefaults] objectForKey:KHostAddressUserdefaultStr];
    NSString *messageStr = [NSString stringWithFormat:@"当前服务器地址为:%@",hostStr?:@"0.0.0.0"];
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"服务器设置" message:messageStr preferredStyle:UIAlertControllerStyleAlert];
    __weak typeof (&*self)weakSelf = self;
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.textColor = [UIColor purpleColor];
        textField.placeholder = @"ip地址(如0.0.0.0)";
        weakSelf.hostAddressText = textField;
    }];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:nil]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        HIDE_KEYBOARD
        if ([[weakSelf.hostAddressText.text componentsSeparatedByString:@"."] count]==4) {
            [[NSUserDefaults standardUserDefaults] setObject:weakSelf.hostAddressText.text forKey:KHostAddressUserdefaultStr];
        }else{
            
        }
    }]];
    [self.rootView.viewController presentViewController:alert animated:YES completion:nil];
}
@end
