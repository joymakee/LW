//
//  LWChatInteractor.m
//  LW
//
//  Created by joymake on 2017/2/13.
//  Copyright © 2017年 joymake. All rights reserved.
//

#import "LWChatInteractor.h"
#import <JoyKit/JoyKit.h>
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
    JoySectionBaseModel *sectionModel = self.dataArrayM.firstObject;
    [sectionModel.rowArrayM addObject:[self tranvrtMessageToCellModel:message isSelf:NO]];
}

-(LWSocketClient *)socketClient{
    return _socketClient= _socketClient?:[[LWSocketClient alloc]init];
}

- (void)sendmessage:(ChatMessage*)message{
    message.userName = [LWUser shareInstance].userName;
    [self.socketClient sendmessage:message.mj_JSONString];
    JoySectionBaseModel *sectionModel = self.dataArrayM.firstObject;
    [sectionModel.rowArrayM addObject:[self tranvrtMessageToCellModel:message isSelf:YES]];
}

-(NSMutableArray *)dataArrayM{
    return _dataArrayM = _dataArrayM?:[NSMutableArray array];
}

- (ChatCellModel *)tranvrtMessageToCellModel:(ChatMessage *)message isSelf:(BOOL)isSend{
    ChatCellModel *model = [[ChatCellModel alloc]init];
    model.title = message.userName;
    model.subTitle = message.message;
    model.chatType = message.chatType;
    model.urlPath = message.urlPath;
    if (message.chatType == EChatAudioType && message.urlPath) {
        model.tapAction = @"playAudio";
    }
    model.playTotalTime = message.playTotalTime;
    model.cellName = isSend?@"LWChatRightIconLabelCell":@"LWChatLeftIconLabelCell";
    model.cellType = ECellXibType;
    model.backgroundColor = @"#00000000";
    return model;
}
@end
