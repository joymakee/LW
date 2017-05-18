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
    _chatView.tableEditingBlock = ^(UITableViewCellEditingStyle editingStyle,NSIndexPath *indexPath){
        [weakSelf deleteCellActionWithIndexPath:indexPath];
    };
}

-(void)tableVIewDidSelect:(NSIndexPath *)indexPath{
    JoySectionBaseModel *sectionModel = [self.chatInteractor.dataArrayM objectAtIndex:indexPath.section];
    LWChatListCellModel * selectModel  = sectionModel.rowArrayM[indexPath.row];
    if (selectModel.messageCount) {
        selectModel.messageCount = 0;
        [self.chatView reloadRow:indexPath];
    }

    [super performTapAction:selectModel.tapAction];
}

#pragma mark 左滑删除事件
- (void)deleteCellActionWithIndexPath:(NSIndexPath *)indexPath{
    __weak __typeof (&*self)weakSelf = self;
    JoySectionBaseModel *sectionModel = self.chatInteractor.dataArrayM[indexPath.section];
    if (self.chatInteractor.dataArrayM.count>indexPath.row) {
        [self.chatInteractor.dataArrayM removeObjectAtIndex:indexPath.row];
    }
    if(sectionModel.rowArrayM.count>indexPath.row){
        [self.chatView beginUpdates];
        [sectionModel.rowArrayM removeObjectAtIndex:indexPath.row];
        [self.chatView.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [self.chatView endUpdates];
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
    [[ServerClientConfig shareinstance] showConfigAlertWithObj:self.rootView.viewController];
}
@end
