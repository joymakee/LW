//
//  CustomMealInteracter.m
//  LW
//
//  Created by joymake on 2016/11/21.
//  Copyright © 2016年 joymake. All rights reserved.
//

#import "CustomMealInteracter.h"
#import <JoyKit/JoyKit.h>
#import <JoyKit/JoyKit.h>
#import "MealModel.h"
#import <JoyRequest/Joy_NetCacheTool.h>

extern const NSString *lw_meal_key;
extern const NSString *selectMealKey ;
extern const NSString *deSelectMealKey;

@implementation CustomMealInteracter


-(void)genrateDataSourceWithSelectedDataSource:(NSArray *)selectedDataSource{
    NSDictionary *mealDict = [Joy_NetCacheTool scbuDictCacheForKey:lw_meal_key];
    NSArray *deSelects = [mealDict objectForKey:deSelectMealKey];
    
    [self.dataArrayM removeAllObjects];
    JoySectionBaseModel *section = [[JoySectionBaseModel alloc]init];
    section.sectionHeadViewName = @"LWCollectionReusableView";
    section.sectionTitle = @"🧚‍♀️:等待开吃（至少1个菜） ";
    for (NSString *title in selectedDataSource) {
        JoyCellBaseModel *model = [[JoyCellBaseModel alloc]init];
        model.title = title;
        model.titleColor = @"#FFBB44";
        model.cellName = @"JoyCollectionTextCell";
        [section.rowArrayM addObject:model];
    }
    [self.dataArrayM addObject:section];

    JoySectionBaseModel *deSelectSection = [[JoySectionBaseModel alloc]init];
    deSelectSection.sectionHeadViewName = @"LWCollectionReusableView";
    deSelectSection.sectionTitle = @"🧚‍♀️:已收藏  ";

    for (NSString *title in deSelects) {
        JoyCellBaseModel *model = [[JoyCellBaseModel alloc]init];
        model.title = title;
        model.titleColor = @"#DDAAAA";
        model.cellName = @"JoyCollectionTextCell";
        [deSelectSection.rowArrayM addObject:model];
    }
    [self.dataArrayM addObject:deSelectSection];
}

-(NSMutableArray *)dataArrayM{
    return _dataArrayM = _dataArrayM?:[NSMutableArray array];
}
@end
