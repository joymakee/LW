//
//  LWUser.m
//  LW
//
//  Created by joymake on 2017/4/25.
//  Copyright © 2017年 joymake. All rights reserved.
//

#import "LWUser.h"
#import <JoyRequest/Joy_NetCacheTool.h>

@interface LWUser ()
@property (nonatomic,copy)NSString *userName;
@property (nonatomic,copy)NSString *password;
@end

@implementation LWUser

#define LW_USER_CACHE_KEY @"LW_USER_CACHE_KEY"
+ (instancetype)shareInstance{
    static id user = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        user = [[super alloc]init];
    });
    return user;
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

-(NSString *)genderStr{
    return [self.userGender integerValue]==0?@"\ue61f":[self.userGender integerValue]==1?@"\ue676":@"\ue676";
}

-(void)cacheUserInfo{
    NSDictionary *dict = self.mj_keyValues;
    [Joy_NetCacheTool scbuCacheDict:dict forKey:LW_USER_CACHE_KEY];
}

- (void)setValueWithCache{
    NSDictionary *dict = [Joy_NetCacheTool scbuDictCacheForKey:LW_USER_CACHE_KEY];
    [self setValuesForKeysWithDictionary:dict];
}

-(void)loginOut{
    self.password = nil;
    self.token = nil;
    [self cacheUserInfo];
}

- (NSString *)encryptWithStr:(NSString *)str{
    return nil;
}
@end
