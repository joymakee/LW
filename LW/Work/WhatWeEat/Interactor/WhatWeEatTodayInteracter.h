//
//  WhatWeEatTodayInteracter.h
//  LW
//
//  Created by wangguopeng on 2016/11/18.
//  Copyright © 2016年 joymake. All rights reserved.
//

#import "BaseInteractor.h"

@interface WhatWeEatTodayInteracter : BaseInteractor
@property (nonatomic,assign)CGFloat totalRadious;
- (void)getMealDataSource;
@end
