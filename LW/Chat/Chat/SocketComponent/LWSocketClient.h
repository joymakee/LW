//
//  LWSocketClient.h
//  LW
//
//  Created by wangguopeng on 2017/2/14.
//  Copyright © 2017年 joymake. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GCDAsyncSocket;
@interface LWSocketClient : NSObject

@property (nonatomic,copy)STRINGBLOCK receivedMessageBlock;
- (void)connectHost:(NSString *)host port:(uint16_t)port;

- (void)sendmessage:(NSString*)message;
@end
