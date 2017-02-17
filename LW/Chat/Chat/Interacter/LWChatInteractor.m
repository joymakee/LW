//
//  LWChatInteractor.m
//  LW
//
//  Created by wangguopeng on 2017/2/13.
//  Copyright © 2017年 joymake. All rights reserved.
//

#import "LWChatInteractor.h"
#import "LWTableSectionBaseModel.h"
#import "LWCellBaseModel.h"
#import "LWSocketClient.h"

@interface LWChatInteractor ()
@property (nonatomic,strong)LWSocketClient *socketClient;
@end

@implementation LWChatInteractor
- (void)getChatInfo:(VOIDBLOCK)block{
    NSMutableArray *chatListDataArrayM = [NSMutableArray new];
    LWCellBaseModel *model = [[LWCellBaseModel alloc]init];
    model.title = @"🌟兆麟🌟";
    model.subTitle = @"@property (weak, nonatomic)IBOutlet UILabel*chatInfoLabel;";
    model.cellName = @"LWChatLeftIconLabelCell";

    LWCellBaseModel *rightCellModel = [[LWCellBaseModel alloc]init];
    rightCellModel.title = @"🌛Joymake🌛";
    rightCellModel.subTitle = @"本文旨以实例的方式，使用CocoaAsyncSocket这个框架进行数据封包和拆包。来解决频繁的数据发送下，导致的数据粘包、以及较大数据（例如图片、录音等等）的发送，导致的数据断包";
    rightCellModel.cellName = @"LWChatRightIconLabelCell";
    [chatListDataArrayM addObject:model];
    [chatListDataArrayM addObject:model];
    [chatListDataArrayM addObject:rightCellModel];
    [chatListDataArrayM addObject:rightCellModel];
    
    LWTableSectionBaseModel *sectionModel = [LWTableSectionBaseModel sectionWithHeaderModel:nil footerModel:nil cellModels:chatListDataArrayM sectionH:0 sectionTitle:nil];
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
    LWTableSectionBaseModel *sectionModel = self.dataArrayM.firstObject;
    LWCellBaseModel *model = [[LWCellBaseModel alloc]init];
    model.title = @"🌟兆麟🌟";
    model.subTitle = message;
    model.cellName = @"LWChatLeftIconLabelCell";
    [sectionModel.rowArrayM addObject:model];
}

-(LWSocketClient *)socketClient{
    return _socketClient= _socketClient?:[[LWSocketClient alloc]init];
}

- (void)sendmessage:(NSString*)message{
    [self.socketClient sendmessage:message];
    LWTableSectionBaseModel *sectionModel = self.dataArrayM.firstObject;
    LWCellBaseModel *model = [[LWCellBaseModel alloc]init];
    model.title = @"🌟Joymake🌟";
    model.subTitle = message;
    model.cellName = @"LWChatRightIconLabelCell";
    [sectionModel.rowArrayM addObject:model];
}
@end
