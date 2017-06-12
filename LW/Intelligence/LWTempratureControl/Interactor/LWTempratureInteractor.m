//
//  LWTempratureInteractor.m
//  LW
//
//  Created by wangguopeng on 2017/5/23.
//  Copyright © 2017年 joymake. All rights reserved.
//

#import "LWTempratureInteractor.h"
#import "LWtempratureCellModel.h"

@implementation LWTempratureInteractor


- (void)getTempratureDataSource:(VOIDBLOCK)success{
    
    __block NSArray *sourceArray = @[@"客厅",@"主卧",@"次卧",@"客房",@"洗手间",@"书房",@"娱乐间",@"厨房",];
    __weak __typeof (&*self)weakSelf = self;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        __block NSMutableArray *rowsArray = [NSMutableArray array];
        dispatch_apply(sourceArray.count, queue, ^(size_t index) {
            LWtempratureCellModel *model = [[LWtempratureCellModel alloc]init];
            model.title = sourceArray[index];
            model.cellName = @"LWThermostatCell";
            model.on = YES;
            model.backgroundColor = JOY_clearColor;
            model.currentValue = (float)(arc4random()%50);
            model.targetValue = (float)(arc4random()%50);
            [rowsArray addObject:model];
            NSLog(@"%zu\n",(long)index);
        });
        JoySectionBaseModel *topicSectionModel = [JoySectionBaseModel sectionWithHeaderModel:nil footerModel:nil cellModels:rowsArray sectionH:15 sectionTitle:nil];
        [weakSelf.dataArrayM addObject:topicSectionModel];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            success?success():nil;
        });
    });
}

-(NSMutableArray *)dataArrayM{
    return _dataArrayM = _dataArrayM?:[NSMutableArray array];
}
@end
