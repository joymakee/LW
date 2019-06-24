//
//  JoyDeviceNetTool.h
//  LW
//
//  Created by joymake on 2017/4/26.
//  Copyright © 2017年 joymake. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JoyDeviceNetTool : NSObject

#pragma mark 获取设备当前网络IP地址
+ (NSString *)getIPAddress:(BOOL)preferIPv4;

#pragma mark 获取所有相关IP信息
+ (NSDictionary *)getIPAddresses;
@end
