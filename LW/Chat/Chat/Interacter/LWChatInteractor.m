//
//  LWChatInteractor.m
//  LW
//
//  Created by wangguopeng on 2017/2/13.
//  Copyright © 2017年 joymake. All rights reserved.
//

#import "LWChatInteractor.h"
#import <JoyTool.h>
#import "LWSocketClient.h"
#import "ChatCellModel.h"
#import "ChatMessage.h"
#import "NSString+JoyCategory.h"

@interface LWChatInteractor ()
@property (nonatomic,strong)LWSocketClient *socketClient;
@end

@implementation LWChatInteractor
- (void)getChatInfo:(VOIDBLOCK)block{
    NSMutableArray *chatListDataArrayM = [NSMutableArray new];
    ChatCellModel *model = [[ChatCellModel alloc]init];
    model.title = @"🌟兆麟🌟";
    model.subTitle = @"@property (weak, nonatomic)IBOutlet UILabel*chatInfoLabel;";
    model.cellName = @"LWChatLeftIconLabelCell";
    model.backgroundColor = JOY_clearColor;

    ChatCellModel *rightCellModel = [[ChatCellModel alloc]init];
    rightCellModel.title = @"🌛Joymake🌛";
    rightCellModel.subTitle = @"本文旨以实例的方式，使用CocoaAsyncSocket这个框架进行数据封包和拆包。来解决频繁的数据发送下，导致的数据粘包、以及较大数据（例如图片、录音等等）的发送，导致的数据断包";
//    rightCellModel.chatType = EChatAudioType;
    
    rightCellModel.cellName = @"LWChatRightIconLabelCell";
    rightCellModel.backgroundColor = JOY_clearColor;
    [chatListDataArrayM addObject:model];
    [chatListDataArrayM addObject:model];
    [chatListDataArrayM addObject:rightCellModel];
    [chatListDataArrayM addObject:rightCellModel];
    
    JoySectionBaseModel *sectionModel = [JoySectionBaseModel sectionWithHeaderModel:nil footerModel:nil cellModels:chatListDataArrayM sectionH:64 sectionTitle:nil];
    sectionModel.sectionFootH = 60;
    [self.dataArrayM addObject:sectionModel];
    block?block():nil;
}

- (void)connectHost:(NSString *)host port:(uint16_t)port receivedMessageBlock:(VOIDBLOCK)receivedMessage{
    [self.socketClient connectHost:host port:port];
    __weak typeof (&*self)weakSelf = self;
    self.socketClient.receivedMessageBlock = ^(NSString *message){
        ChatMessage *messageObj = [ChatMessage mj_objectWithKeyValues:message.mj_JSONObject];
        [weakSelf addMessage:messageObj];
        receivedMessage?receivedMessage():nil;
    };
}

- (void)addMessage:(ChatMessage *)message{
    
//    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingString:[NSString stringWithFormat:@"\%@",message.urlPath]];
//    message.data = [NSData dataWithContentsOfFile:path];
//    NSFileHandle * fh = [NSFileHandle fileHandleForWritingAtPath:path]; //以只写方式打开文件生成句柄
//    [fh writeData:message.data];//直
    
    JoySectionBaseModel *sectionModel = self.dataArrayM.firstObject;
    ChatCellModel *model = [[ChatCellModel alloc]init];
    model.title = @"🌟兆麟🌟";
    model.subTitle = message.message;
    model.cellName = @"LWChatLeftIconLabelCell";
    model.chatType = message.chatType;
    model.urlPath = message.urlPath;
    model.playTotalTime = message.playTotalTime;

    if (message.chatType == EChatAudioType && message.urlPath) {
        model.tapAction = @"playAudio";
    }
    model.backgroundColor = JOY_clearColor;
    [sectionModel.rowArrayM addObject:model];
}

-(LWSocketClient *)socketClient{
    return _socketClient= _socketClient?:[[LWSocketClient alloc]init];
}

- (void)sendmessage:(ChatMessage*)message{
//    if (message.chatType == EChatAudioType && message.urlPath) {
//    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingString:[NSString stringWithFormat:@"\%@",message.urlPath]];
//    message.data = [NSData dataWithContentsOfFile:path];
//    }
    
    [self.socketClient sendmessage:message.mj_JSONString];
    JoySectionBaseModel *sectionModel = self.dataArrayM.firstObject;
    ChatCellModel *model = [[ChatCellModel alloc]init];
    model.title = @"🌟Joymake🌟";
    model.subTitle = message.message;
    model.chatType = message.chatType;
    model.urlPath = message.urlPath;
    if (message.chatType == EChatAudioType && message.urlPath) {
        model.tapAction = @"playAudio";
    }
    model.playTotalTime = message.playTotalTime;
    model.cellName = @"LWChatRightIconLabelCell";
    model.backgroundColor = JOY_clearColor;
    [sectionModel.rowArrayM addObject:model];
}

-(NSMutableArray *)dataArrayM{
    return _dataArrayM = _dataArrayM?:[NSMutableArray array];
}
@end
