//
//  LWUser.m
//  LW
//
//  Created by wangguopeng on 2017/4/25.
//  Copyright © 2017年 joymake. All rights reserved.
//

#import "LWUser.h"

@interface LWUser ()
@property (nonatomic,copy)NSString *userName;
@property (nonatomic,copy)NSString *password;
@end

@implementation LWUser
+ (instancetype)shareInstance{
    static id user = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        user = [[super alloc]init];
    });
    return user;
}

- (void)initUserName:(NSString *)userName{
    self.userName = userName;
}

- (void)initUserInfoWithKey:(NSString *)key value:(NSString *)value{
    if (!(key&&value)) {
        return;
    }
    if ([key isEqualToString:@"password"]) {
        [self initPassword:value];
    }else{
        [self setValue:value forKey:key];
    }
}

- (void)initPassword:(NSString *)password{
    self.password = password;
}

- (NSString *)encryptWithStr:(NSString *)str{
//    return <#expression#>
    return nil;
}
@end
