//
//  LWShareManager.h
//  LW
//
//  Created by joymake on 16/7/1.
//  Copyright © 2016年 joymake. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LWShareManager : NSObject

+(instancetype)shareInstance;


@property (nonatomic,readonly)LWShareManager        *(^qqLogin)();

@property (nonatomic,readonly)LWShareManager        *(^loginSuccess)(VOIDBLOCK voidBlock);
@property (nonatomic,readonly)LWShareManager        *(^loginFailure)(VOIDBLOCK voidBlock);
@property (nonatomic,readonly)LWShareManager        *(^loginOut)(VOIDBLOCK voidBlock);
@property (nonatomic,readonly)LWShareManager        *(^loginCancle)(VOIDBLOCK voidBlock);
@property (nonatomic,readonly)LWShareManager        *(^loginWithoutNet)(VOIDBLOCK voidBlock);

- (void)tencentLogin;

+ (void)shareCompentInit;

- (void)shareActionWithVC:(UIViewController *)vc;

- (void)loginWithPlatform:(NSString *)snsName;
@end
