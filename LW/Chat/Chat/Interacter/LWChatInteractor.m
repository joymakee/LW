//
//  LWChatInteractor.m
//  LW
//
//  Created by wangguopeng on 2017/2/13.
//  Copyright © 2017年 joymake. All rights reserved.
//

#import "LWChatInteractor.h"
#import <JoyTool.h>
#import <JoyTool.h>
#import "LWSocketClient.h"

@interface LWChatInteractor ()
@property (nonatomic,strong)LWSocketClient *socketClient;
@end

@implementation LWChatInteractor
- (void)getChatInfo:(VOIDBLOCK)block{
    NSMutableArray *chatListDataArrayM = [NSMutableArray new];
    JoyCellBaseModel *model = [[JoyCellBaseModel alloc]init];
    model.title = @"🌟兆麟🌟";
    model.subTitle = @"@property (weak, nonatomic)IBOutlet UILabel*chatInfoLabel;";
    model.cellName = @"LWChatLeftIconLabelCell";
    model.backgroundColor = JOY_clearColor;

    JoyCellBaseModel *rightCellModel = [[JoyCellBaseModel alloc]init];
    rightCellModel.title = @"🌛Joymake🌛";
    rightCellModel.subTitle = @"本文旨以实例的方式，使用CocoaAsyncSocket这个框架进行数据封包和拆包。来解决频繁的数据发送下，导致的数据粘包、以及较大数据（例如图片、录音等等）的发送，导致的数据断包";
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

- (void)connectHost:(NSString *)host port:(uint16_t)port receivedMessageBlock:(STRINGBLOCK)receivedMessage{
    [self.socketClient connectHost:host port:port];
    __weak typeof (&*self)weakSelf = self;
    self.socketClient.receivedMessageBlock = ^(NSString *message){
        [weakSelf addMessage:message];
        receivedMessage?receivedMessage(message):nil;
    };
}

- (void)addMessage:(NSString *)message{
    JoySectionBaseModel *sectionModel = self.dataArrayM.firstObject;
    JoyCellBaseModel *model = [[JoyCellBaseModel alloc]init];
    model.title = @"🌟兆麟🌟";
    model.subTitle = message;
    model.cellName = @"LWChatLeftIconLabelCell";
    model.backgroundColor = JOY_clearColor;
    [sectionModel.rowArrayM addObject:model];
}

-(LWSocketClient *)socketClient{
    return _socketClient= _socketClient?:[[LWSocketClient alloc]init];
}

- (void)sendmessage:(NSString*)message{
    [self.socketClient sendmessage:message];
    JoySectionBaseModel *sectionModel = self.dataArrayM.firstObject;
    JoyCellBaseModel *model = [[JoyCellBaseModel alloc]init];
    model.title = @"🌟Joymake🌟";
    model.subTitle = message;
    model.cellName = @"LWChatRightIconLabelCell";
    model.backgroundColor = JOY_clearColor;
    [sectionModel.rowArrayM addObject:model];
}

-(NSMutableArray *)dataArrayM{
    return _dataArrayM = _dataArrayM?:[NSMutableArray array];
}
@end
