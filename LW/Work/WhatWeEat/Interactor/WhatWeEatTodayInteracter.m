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
- (void)getMealDataSource{
    NSArray *mealDicArray =@[@{@"宫保鸡丁":@1},@{@"西红柿炒鸡蛋":@1},@{@"干锅菜花":@1},@{@"鱼香肉丝":@1},@{@"麻辣香锅":@1},@{@"烩虾仁儿":@1},@{@"炸子蟹":@2},@{@"毛血旺":@1},@{@"麻婆豆腐":@1}];
    
    self.totalRadious = 0.0;
    [self.dataArrayM removeAllObjects];
    [mealDicArray enumerateObjectsUsingBlock:^(NSDictionary *dict, NSUInteger idx, BOOL * _Nonnull stop) {
        @autoreleasepool {
            MealModel *model = [[MealModel alloc]init];
            model.title = [dict allKeys][0];
            model.mealRadius = [[dict allValues][0] floatValue];
            [self.dataArrayM addObject:model];
            _totalRadious +=model.mealRadius;
        }
    }];
}
@end
