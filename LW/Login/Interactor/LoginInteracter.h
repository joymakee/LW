//
//  LoginViewModel.h
//  LW
//
//  Created by Joymake on 16/6/24.
//  Copyright © 2016年 joymake. All rights reserved.
//

#import "JoyInteractorBase.h"

@interface LoginInteracter : JoyInteractorBase
@property (nonatomic,strong)NSMutableArray *dataArrayM;

-(void)getLoginDataSource;

- (void)loginWithPhone:(NSString *)phone password:(NSString *)password success:(DICTBLOCK)success failure:(ERRORBLOCK)failure;

@end
