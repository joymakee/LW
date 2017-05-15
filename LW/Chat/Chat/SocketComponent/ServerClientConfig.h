//
//  ServerClientConfig.h
//  LW
//
//  Created by wangguopeng on 2017/4/27.
//  Copyright © 2017年 joymake. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ServerClientConfig : NSObject
@property (nonatomic,assign,readonly)BOOL isServer;

+ (instancetype)shareinstance;

- (void)showConfigAlertWithObj:(UIViewController *)vc;
@end
