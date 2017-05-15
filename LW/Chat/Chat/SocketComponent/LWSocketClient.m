//
//  LWSocketClient.m
//  LW
//
//  Created by wangguopeng on 2017/2/14.
//  Copyright © 2017年 joymake. All rights reserved.
//

#import "LWSocketClient.h"
#import "GCDAsyncSocket.h"

@interface LWSocketClient ()<GCDAsyncSocketDelegate>{
    BOOL _isServer;
}
@property(nonatomic,strong)GCDAsyncSocket *socket;
@property (nonatomic, strong)NSThread *thread;

@end
@implementation LWSocketClient

-(void)becoMeServer{
    _isServer = YES;
    [self.thread start];
}

-(GCDAsyncSocket *)socket{
    return _socket = _socket?:[[GCDAsyncSocket alloc]initWithDelegate:self delegateQueue:dispatch_get_global_queue(0, 0)];
}

- (void)connectHost:(NSString *)host port:(uint16_t)port{
    [self.socket connectToHost:host onPort:port error:nil];
}

#pragma mark 连接成功
- (void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(uint16_t)port {
    NSLog(@"连接成功");
    [self.socket readDataWithTimeout:-1 tag:0];
    //开启线程发送心跳
    [self.thread start];
}

- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag{
    NSString *dataStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"\n收到消息:%@",dataStr);
    self.receivedMessageBlock?self.receivedMessageBlock(dataStr):nil;
    [sock readDataWithTimeout:-1 tag:0];
}

#pragma mark 断开连接
-(void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(NSError *)err{
    NSLog(@"断开连接 %@",err);
    //再次可以重连
    if (err) {
        [self connectHost:sock.connectedHost port:sock.connectedPort];
    }
    else{//正常断开
    }
}

- (void)sendmessage:(NSString*)message{
    if(self.socket.isDisconnected){
        [self connectHost:self.socket.connectedHost port:self.socket.connectedPort];
    }
    [self.socket writeData:[message dataUsingEncoding:NSUTF8StringEncoding ] withTimeout:-1 tag:0];
}


- (void)threadStart{
    @autoreleasepool {
        [NSTimer scheduledTimerWithTimeInterval:25 target:self selector:@selector(heartBeat) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop]run];
    }
}

- (void)heartBeat{
    [self sendmessage:@"heart"];
}

- (NSThread*)thread{
    if (!_thread) {
        _thread = [[NSThread alloc]initWithTarget:self selector:@selector(threadStart) object:nil];
    }
    return _thread;
}

@end

