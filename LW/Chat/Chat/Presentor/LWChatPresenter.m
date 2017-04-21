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
#import "ChatMessage.h"
#import "JoyRecorder.h"
#import "ChatCellModel.h"

extern NSString *KHostAddressUserdefaultStr;

@implementation LWChatPresenter

-(void)setChatView:(LWChatView *)chatView{
    _chatView = chatView;
    _chatView.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _chatView.tableView.backgroundColor = JOY_clearColor;
    __weak typeof (&*self)weakSelf = self;
    _chatView.messageBlock = ^(ChatMessage *sendMessage){
        [weakSelf.chatInteractor sendmessage:sendMessage];
        [weakSelf receivedMessage];
    };
    
    _chatView.tableDidSelectBlock = ^(NSIndexPath *indexPath, NSString *tapAction) {
        [super performTapAction:tapAction];
    };
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
    
    [self.chatInteractor connectHost:hostStr port:8088 receivedMessageBlock:^() {
        [weakSelf receivedMessage];
    }];
}

- (void)reloadChatList{
    self.chatView.dataArrayM = self.chatInteractor.dataArrayM;
    [self.chatView reloadTableView];
}

- (void)receivedMessage{
    dispatch_async(dispatch_get_main_queue(), ^{
        JoySectionBaseModel *sectionModel = self.chatInteractor.dataArrayM.firstObject;
        unsigned long count =sectionModel.rowArrayM.count;
        NSIndexPath *lastIndex = [NSIndexPath indexPathForRow:count-1 inSection:0];
        [self.chatView.tableView insertRowsAtIndexPaths:@[lastIndex] withRowAnimation:UITableViewRowAnimationNone];
        [self.chatView.tableView scrollToRowAtIndexPath:lastIndex atScrollPosition:UITableViewScrollPositionNone animated:NO];
    });
}

- (void)playAudio{
    JoySectionBaseModel *sectionModel = self.chatInteractor.dataArrayM[self.chatView.currentSelectIndexPath.section];
    
    [self playAudioWithIndex:self.chatView.currentSelectIndexPath.row andStopIndex:self.chatView.oldSelectIndexPath.row  sectionModel:sectionModel];
}

- (void)playAudioWithIndex:(NSInteger)playIndex andStopIndex:(NSInteger)willStopIndex sectionModel:(JoySectionBaseModel *)sectionModel{
    ChatCellModel *oldCellModel = sectionModel.rowArrayM[willStopIndex];
    if(oldCellModel.chatType == EChatAudioType)
    {
    [[JoyRecorder shareInstance] stopPlayAudio];
    //停止动画回调
    oldCellModel.aToBCellBlock?oldCellModel.aToBCellBlock(@(YES)):nil;
    }
    
    __block ChatCellModel *cellModel = sectionModel.rowArrayM[playIndex];
    [JoyRecorder shareInstance].playUrlStrPathFile = cellModel.urlPath;
    __weak __typeof (&*self)weakSelf = self;
    [JoyRecorder shareInstance].playFinishBlock = ^(NSString *str)
    {
        cellModel.aToBCellBlock?cellModel.aToBCellBlock(@(YES)):nil;
        cellModel.isReaded = YES;
        NSInteger newIndex = playIndex;
        while (++newIndex<sectionModel.rowArrayM.count) {
            cellModel = sectionModel.rowArrayM[newIndex];
            //语音且未读
            if((cellModel.chatType == EChatAudioType) && !cellModel.isReaded){
                [weakSelf playAudioWithIndex:newIndex andStopIndex:playIndex sectionModel:sectionModel];
                break;
            }
        }
    };
    [[JoyRecorder shareInstance] playAudio];
    //开启动画回调
    cellModel.aToBCellBlock?cellModel.aToBCellBlock(@(NO)):nil;

}


@end
