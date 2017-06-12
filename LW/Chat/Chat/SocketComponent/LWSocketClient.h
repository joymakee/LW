//
//  LWSocketClient.h
//  LW
//
//  Created by wangguopeng on 2017/2/14.
//  Copyright © 2017年 joymake. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^STRINGBLOCK)(NSString *str);

@class GCDAsyncSocket;
@interface LWSocketClient : NSObject

//接收消息block
@property (nonatomic,copy)STRINGBLOCK receivedMessageBlock;

//设置主机ip和port
- (void)connectHost:(NSString *)host port:(uint16_t)port;
//发送消息
- (void)sendmessage:(NSString*)message;
@end


