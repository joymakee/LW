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
#import "ChatMessage.h"
#import "JoyRecorder.h"
#import "ChatCellModel.h"
#import "ServerClientConfig.h"

extern NSString *KHostAddressUserdefaultStr;

@interface LWChatPresenter ()<ScrollDelegate>

@end

@implementation LWChatPresenter

-(void)setChatView:(LWChatView *)chatView{
    _chatView = chatView;
    _chatView.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _chatView.tableView.backgroundColor = JOY_clearColor;
    _chatView.scrollDelegate = self;
    __weak typeof (&*self)weakSelf = self;
    _chatView.messageBlock = ^(ChatMessage *sendMessage){
        [weakSelf.chatInteractor sendmessage:sendMessage];
        [weakSelf receivedMessage];
    };
    
    _chatView.tableDidSelectBlock = ^(NSIndexPath *indexPath, NSString *tapAction) {
        [super performTapAction:tapAction];
    };

}

- (void)getChatInfoAndDisplay:(AlertBlock)alert{
    __weak typeof (&*self)weakSelf = self;
    [self.chatInteractor getChatInfo:^{
        [weakSelf reloadChatList];
    }];
    
    if ([ServerClientConfig shareinstance].isServer)
    {
//        [self.chatInteractor openSerVice];
    }
    else
    {
        NSString *hostStr = [[NSUserDefaults standardUserDefaults] objectForKey:KHostAddressUserdefaultStr];
        if (!hostStr.length) {
            [[JoyAlert shareAlert]showAlertViewWithTitle:nil message:@"你还没有设置服务器ip,配置ip后才能进行多人聊天哦" cancle:@"取消" confirm:@"设置" alertBlock:alert];
        }
        
        [self.chatInteractor connectHost:hostStr port:8088 receivedMessageBlock:^() {
            [weakSelf receivedMessage];
        }];
    }
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
        //播放未读的语音
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

-(void)scrollDidScroll:(UIScrollView *)scrollView{
    self.rootView.viewController.navigationController.navigationBar.alpha = scrollView.contentOffset.y>=64?0:(64-scrollView.contentOffset.y)/64;
}
@end
