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

+ (void)shareCompentInit;

- (void)shareActionWithVC:(UIViewController *)vc;

- (void)loginWithPlatform:(NSString *)snsName;
@end
