//
//  WhatWeEatTodayInteracter.m
//  LW
//
//  Created by wangguopeng on 2016/11/18.
//  Copyright © 2016年 joymake. All rights reserved.
//

#import "WhatWeEatTodayInteracter.h"
#import "MealModel.h"

@implementation WhatWeEatTodayInteracter
- (void)getMealDataSourceWithDataSouce:(NSArray *)mealDicArray{
    
    self.totalRadious = 0.0;
    [self.dataArrayM removeAllObjects];
    __weak __typeof (&*self)weakSelf = self;

    [mealDicArray enumerateObjectsUsingBlock:^(NSDictionary *dict, NSUInteger idx, BOOL * _Nonnull stop) {
        @autoreleasepool {
            MealModel *model = [[MealModel alloc]init];
            model.title = [dict allKeys][0];
            model.mealRadius = [[dict allValues][0] floatValue];
            [weakSelf.dataArrayM addObject:model];
            weakSelf.totalRadious +=model.mealRadius;
        }
    }];
}

-(NSMutableArray *)dataArrayM{
    return _dataArrayM = _dataArrayM?:[NSMutableArray arrayWithCapacity:0];
}
@end
