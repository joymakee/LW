//
//  LWTempratureInteractor.m
//  LW
//
//  Created by joymake on 2017/5/23.
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
        for (NSString *title in sourceArray) {
            
            LWtempratureCellModel *model = [[LWtempratureCellModel alloc]init];
            model.title = title;
            model.cellName = @"LWThermostatCell";
            model.cellType = ECellXibType;
            model.on = YES;
            model.backgroundColor = @"#00000000";
            model.currentValue = (float)(arc4random()%50);
            model.targetValue = (float)(arc4random()%50);
            model?[rowsArray addObject:model]:nil;
            NSLog(@"%zu\n",(long)index);
        };
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
