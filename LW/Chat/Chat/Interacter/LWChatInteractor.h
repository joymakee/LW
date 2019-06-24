//
//  LWChatInteractor.h
//  LW
//
//  Created by joymake on 2017/2/13.
//  Copyright © 2017年 joymake. All rights reserved.
//

#import "JoyInteractorBase.h"

@class ChatMessage;
@interface LWChatInteractor : JoyInteractorBase
@property (nonatomic,strong)NSMutableArray *dataArrayM;

- (void)getChatInfo:(VOIDBLOCK)block;

- (void)connectHost:(NSString *)host port:(uint16_t)port receivedMessageBlock:(VOIDBLOCK)receivedMessage;

- (void)sendmessage:(ChatMessage*)message;
@end
