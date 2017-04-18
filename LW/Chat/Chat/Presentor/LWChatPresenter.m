//
//  LWChatPresenter.m
//  LW
//
//  Created by wangguopeng on 2017/2/13.
//  Copyright © 2017年 joymake. All rights reserved.
//

#import "LWChatPresenter.h"
#import "LWChatInteractor.h"
#import "LWChatView.h"
#import <JoyTool.h>
#import "BackGroundBlurView.h"

extern NSString *KHostAddressUserdefaultStr;

@implementation LWChatPresenter

-(void)setChatView:(LWChatView *)chatView{
    _chatView = chatView;
    _chatView.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _chatView.tableView.backgroundColor = JOY_clearColor;
    BackGroundBlurView *backView = [[BackGroundBlurView alloc]init];
    [backView setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"shuye" ofType:@"jpg"]] andBlur:1];
    _chatView.backView = backView;

}

- (void)getChatInfoAndDisplay{
    __weak typeof (&*self)weakSelf = self;

    [self.chatInteractor getChatInfo:^{
        [weakSelf reloadChatList];
    }];
    
    NSString *hostStr = [[NSUserDefaults standardUserDefaults] objectForKey:KHostAddressUserdefaultStr];
    if (!hostStr.length) {
        return;
    }
    
    [self.chatInteractor connectHost:hostStr port:8088 receivedMessageBlock:^(NSString *str) {
        [weakSelf receivedMessage:str];
    }];
    
    self.chatView.messageSendAction = ^(NSString *sendMessage){
        [weakSelf.chatInteractor sendmessage:sendMessage];
        [weakSelf receivedMessage:sendMessage];
    };
}

- (void)reloadChatList{
    self.chatView.dataArrayM = self.chatInteractor.dataArrayM;
    [self.chatView reloadTableView];
}

- (void)receivedMessage:(NSString *)message{
    JoySectionBaseModel *sectionModel = self.chatInteractor.dataArrayM.firstObject;
    unsigned long count =sectionModel.rowArrayM.count;
    NSIndexPath *lastIndex = [NSIndexPath indexPathForRow:count-1 inSection:0];
    dispatch_group_t downloadGroup = dispatch_group_create();
    
    dispatch_group_enter(downloadGroup);
    __weak typeof (&*self)weakSelf = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [weakSelf.chatView.tableView insertRowsAtIndexPaths:@[lastIndex] withRowAnimation:UITableViewRowAnimationNone];
        dispatch_group_leave(downloadGroup);
    });
    
    dispatch_group_notify(downloadGroup, dispatch_get_main_queue(), ^{
        [weakSelf.chatView.tableView scrollToRowAtIndexPath:lastIndex atScrollPosition:UITableViewScrollPositionNone animated:YES];
    });
}

@end
