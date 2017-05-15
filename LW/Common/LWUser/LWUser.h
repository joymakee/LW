//
//  LWUser.h
//  LW
//
//  Created by wangguopeng on 2017/4/25.
//  Copyright © 2017年 joymake. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LWUser : NSObject
+ (instancetype)shareInstance;
@property (nonatomic,assign)NSUInteger userId;

@property (nonatomic,copy)NSString *token;

@property (nonatomic,copy)NSString *deviceInfo;

@property (nonatomic,readonly)NSString *userName;

@property (nonatomic,readonly)NSString *password;

- (void)initUserName:(NSString *)userName;

- (void)initPassword:(NSString *)password;

-(void)initUserInfoWithKey:(NSString *)key value:(NSString *)value;
@end
