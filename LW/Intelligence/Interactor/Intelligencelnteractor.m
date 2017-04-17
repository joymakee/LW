//
//  intelligenceViewModel.m
//  LW
//
//  Created by joymake on 16/7/6.
//  Copyright © 2016年 joymake. All rights reserved.
//

#import "Intelligencelnteractor.h"
#import "LWIntelligenceModel.h"

@implementation Intelligencelnteractor
-(void)getIntelligenceSource{
    [self.dataArrayM removeAllObjects];
    __block NSArray *titleSource = @[@"监控",
                             @"温控",
                             @"厨房",
                             @"灯",
                             @"车库",
                             @"水路",
                             @"电路",
                             @"门窗",
                             @"衣架",
                             @"玩具",
                             @"电视",
                             @"床",
                             @"吸尘器",
                             @"导航",
                             @"运动"];
    
    __weak __typeof (&*self)weakSelf = self;
    [titleSource enumerateObjectsUsingBlock:^(NSString *title, NSUInteger idx, BOOL * _Nonnull stop) {
        @autoreleasepool {
            LWIntelligenceModel *model = [[LWIntelligenceModel alloc]init];
            model.cellName = @"RadomLabelCollectionCell";
            model.title = title;
            model.igenceControlType = idx;
            model.tapAction = @"goControl";
            model.backgroundColor = JOY_colorList[idx%JOY_colorList.count];
            [weakSelf.dataArrayM addObject:model];
            
        }
    }];
}

-(NSMutableArray *)dataArrayM{
    _dataArrayM = _dataArrayM?:[NSMutableArray arrayWithCapacity:0];
    return _dataArrayM;
}

@end
