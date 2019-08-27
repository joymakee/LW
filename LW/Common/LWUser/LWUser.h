//
//  LWUser.h
//  LW
//
//  Created by joymake on 2017/4/25.
//  Copyright © 2017年 joymake. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LWUser : NSObject
+ (instancetype)shareInstance;
@property (nonatomic,copy)NSString *uid;

@property (nonatomic,copy)NSString *token;

@property (nonatomic,readonly)NSString *userName;

@property (nonatomic,readonly)NSString *password;

- (void)cacheUserInfo;

- (void)setValueWithCache;

- (void)loginOut;
@end
