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
#import "ServerClientConfig.h"
#import "JoyRecordView.h"
#import "JoyQRCodeScanPresenter.h"

extern NSInteger messageCount;
extern NSString  *KMESSAGE_COUNT_CHANGE;

@implementation LWChatListPresenter
-(void)reloadDataSource{
    __weak typeof (&*self)weakSelf = self;
    [self.chatInteractor getChatListInfo:^(){
        [weakSelf reloadTable];
        weakSelf.rootView.viewController.tabBarItem.badgeValue = messageCount>99?@"99+":[@(messageCount) stringValue];
    }];
}

-(void)tableVIewDidSelect:(NSIndexPath *)indexPath{
    JoySectionBaseModel *sectionModel = [self.chatInteractor.dataArrayM objectAtIndex:indexPath.section];
    LWChatListCellModel * selectModel  = sectionModel.rowArrayM[indexPath.row];
    if (selectModel.messageCount) {
        messageCount -= selectModel.messageCount;
        self.rootView.viewController.tabBarItem.badgeValue = messageCount>99?@"99+":(messageCount>0?[@(messageCount) stringValue]:nil);
        selectModel.messageCount = 0;
        [self.chatView reloadRow:indexPath];
    }

    [super performTapAction:selectModel.tapAction];
}

#pragma mark 左滑删除事件
- (void)deleteCellActionWithIndexPath:(NSIndexPath *)indexPath{
    __weak __typeof (&*self)weakSelf = self;
    JoySectionBaseModel *sectionModel = self.chatInteractor.dataArrayM[indexPath.section];
    LWChatListCellModel *cellModel = sectionModel.rowArrayM[indexPath.row];

    if (self.chatInteractor.dataArrayM.count>indexPath.row) {
        [self.chatInteractor.dataArrayM removeObjectAtIndex:indexPath.row];
    }
    if(sectionModel.rowArrayM.count>indexPath.row){
        [self.chatView beginUpdates];
        [sectionModel.rowArrayM removeObjectAtIndex:indexPath.row];
        [self.chatView.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [self.chatView endUpdates];
        messageCount -= cellModel.messageCount;
        self.rootView.viewController.tabBarItem.badgeValue = messageCount>99?@"99+":(messageCount>0?[@(messageCount) stringValue]:nil);
    }

}

- (void)reloadTable{
    __weak typeof (&*self)weakSelf = self;
    self.chatView.setDataSource(self.chatInteractor.dataArrayM).reloadTable().cellDidSelect(^(NSIndexPath *indexPath, NSString *tapAction) {
        [weakSelf tableVIewDidSelect:indexPath];
    }).cellEiditAction(^(UITableViewCellEditingStyle editingStyle,NSIndexPath *indexPath){
        [weakSelf deleteCellActionWithIndexPath:indexPath];
    });
}

- (void)goChatVC{
    LWChatVC *chatVC = [[LWChatVC alloc]init];
    __weak __typeof(&*self)weakSelf = self;
    chatVC.setSocketBlock = ^(){
        [weakSelf leftNavItemClickAction];
    };
    [self goVC:chatVC];
}

-(void)leftNavItemClickAction{
    [[ServerClientConfig shareinstance] showConfigAlertWithObj:self.rootView.viewController];
}


-(void)rightNavItemClickAction{
    [super rightNavItemClickAction];
        __weak __typeof(&*self)weakSelf = self;
    [[JoyQRCodeScanPresenter shareInstance] startScan:^(NSString *str) {
        [UIPasteboard generalPasteboard].string = str;
        [weakSelf scanResultHandler:str];
    }];
}

- (void)scanResultHandler:(NSString *)scanStr{
    if(scanStr.length){
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
        [[ServerClientConfig shareinstance] cacheServiceIP:scanStr]?[JoyAlert showWithMessage:[NSString stringWithFormat:@"设置服务器地址:%@成功",scanStr]]:[JoyAlert showWithMessage:[NSString stringWithFormat:@"%@",scanStr]];
    }else{
        //手动设置
        [self leftNavItemClickAction];
    }
    JoyRecordView *recoreView =objc_getAssociatedObject(self, @selector(rightNavItemClickAction));
    [recoreView removeFromSuperview];
}
@end
