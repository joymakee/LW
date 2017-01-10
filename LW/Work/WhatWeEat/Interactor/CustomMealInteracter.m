//
//  CustomMealInteracter.m
//  LW
//
//  Created by wangguopeng on 2016/11/21.
//  Copyright © 2016年 joymake. All rights reserved.
//

#import "CustomMealInteracter.h"
#import "LWTableSectionBaseModel.h"
#import "LWCellBaseModel.h"
#import "MealModel.h"

@implementation CustomMealInteracter
- (void)getViewDataSourceWithDataSource:(NSArray *)dataArrayM{
    [self.dataArrayM removeAllObjects];
    __block NSMutableArray *colorCellModelSource = [NSMutableArray array];
    
    [dataArrayM enumerateObjectsUsingBlock:^(MealModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        @autoreleasepool {
            LWCellBaseTextModel *colorModel = [[LWCellBaseTextModel alloc]init];
            colorModel.cellName =@"LWTextFieldCell";
            colorModel.placeHolder = @"请输入自定义名称";
            colorModel.maxNumber = 16;
            colorModel.title = obj.title;
            colorModel.cellH = 44;
            [colorCellModelSource addObject:colorModel];
        }
    }];
    
    //补够10个
    for (NSInteger i = 0; i<11-dataArrayM.count; i++) {
        @autoreleasepool {
            LWCellBaseTextModel *colorModel = [[LWCellBaseTextModel alloc]init];
            colorModel.cellName =@"LWTextFieldCell";
            colorModel.placeHolder = @"请输入自定义名称";
            colorModel.maxNumber = 16;
            colorModel.cellH = 44;
//            colorModel.title = ;
//            colorModel.backgroundColor = colorarray[i%colorarray.count];
            [colorCellModelSource addObject:colorModel];
        }
    }
    
    LWTableSectionBaseModel *colorSectionModel = [LWTableSectionBaseModel sectionWithHeaderModel:nil footerModel:nil cellModels:colorCellModelSource sectionH:KHeadSectionH sectionTitle:nil];
    
    [self.dataArrayM addObject:colorSectionModel];
}
@end
