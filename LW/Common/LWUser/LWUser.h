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

@property (nonatomic,copy)NSString *phone;

@property (nonatomic,copy)NSString *email;

@property (nonatomic,copy)NSString *name;

@property (nonatomic,copy)NSString *userGender;

@property (nonatomic,copy)NSString *genderStr;

@property (nonatomic,copy)NSString *birthday;

@property (nonatomic,copy)NSString *address;

@property (nonatomic,copy)NSString *lang;

@property (nonatomic,copy)NSString *remark;

- (void)cacheUserInfo;

- (void)setValueWithCache;

- (void)loginOut;
@end
