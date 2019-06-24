//
//  WhatWeEatTodayInteracter.h
//  LW
//
//  Created by joymake on 2016/11/18.
//  Copyright © 2016年 joymake. All rights reserved.
//

#import "JoyInteractorBase.h"

@interface WhatWeEatTodayInteracter : JoyInteractorBase

@property (nonatomic,strong)NSMutableArray *dataArrayM;
@property (nonatomic,assign)CGFloat totalRadious;
- (void)getMealDataSourceWithDataSouce:(NSArray *)mealDicArray;
@end
