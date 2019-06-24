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

@implementation CustomMealInteracter
- (void)getViewDataSourceWithDataSource:(NSArray *)dataArrayM{
    [self.dataArrayM removeAllObjects];
    __block NSMutableArray *colorCellModelSource = [NSMutableArray array];
    
    [dataArrayM enumerateObjectsUsingBlock:^(MealModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        @autoreleasepool {
            JoyTextCellBaseModel *colorModel = [[JoyTextCellBaseModel alloc]init];
            colorModel.cellName =@"LWTextFieldCell";
            colorModel.placeHolder = @"请输入自定义名称";
            colorModel.cellType = ECellXibType;
            colorModel.maxNumber = 16;
            colorModel.title = obj.title;
            colorModel.borderStyle = UITextBorderStyleRoundedRect;
            colorModel.editingStyle = UITableViewCellEditingStyleDelete;
            colorModel.titleColor = JOY_RandomColor;
            [colorCellModelSource addObject:colorModel];
        }
    }];
    
    //补够10个
    for (NSInteger i = 0; i<11-dataArrayM.count; i++) {
        @autoreleasepool {
            JoyTextCellBaseModel *colorModel = [[JoyTextCellBaseModel alloc]init];
            colorModel.cellName =@"LWTextFieldCell";
            colorModel.placeHolder = @"请输入自定义名称";
            colorModel.maxNumber = 16;
            colorModel.borderStyle = UITextBorderStyleRoundedRect;
            colorModel.editingStyle = UITableViewCellEditingStyleDelete;
            colorModel.titleColor = JOY_RandomColor;
//            colorModel.title = ;
//            colorModel.backgroundColor = colorarray[i%colorarray.count];
            [colorCellModelSource addObject:colorModel];
        }
    }
    
    JoySectionBaseModel *colorSectionModel = [JoySectionBaseModel sectionWithHeaderModel:nil footerModel:nil cellModels:colorCellModelSource sectionH:KHeadSectionH sectionTitle:nil];
    
    [self.dataArrayM addObject:colorSectionModel];
}

-(NSMutableArray *)dataArrayM{
    return _dataArrayM = _dataArrayM?:[NSMutableArray array];
}
@end
