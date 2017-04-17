//
//  LoginPresenter.h
//  LW
//
//  Created by joymake on 2016/10/25.
//  Copyright © 2016年 joymake. All rights reserved.
//

#import "BasePresentor.h"

@class LoginInteracter;
@class JoyTableAutoLayoutView;
@interface LoginPresenter : BasePresentor
@property (nonatomic,strong)LoginInteracter *interactor;
@property (nonatomic,strong)JoyTableAutoLayoutView *loginView;

@end
