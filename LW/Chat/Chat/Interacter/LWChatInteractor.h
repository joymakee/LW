//
//  LWChatInteractor.h
//  LW
//
//  Created by wangguopeng on 2017/2/13.
//  Copyright © 2017年 joymake. All rights reserved.
//

#import "BaseInteractor.h"

@interface LWChatInteractor : BaseInteractor
- (void)getChatInfo:(VOIDBLOCK)block;

- (void)connectHost:(NSString *)host port:(uint16_t)port receivedMessageBlock:(STRINGBLOCK)receivedMessage;

- (void)sendmessage:(NSString*)message;
@end
