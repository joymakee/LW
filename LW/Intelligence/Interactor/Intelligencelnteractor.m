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

    NSArray *inteligenceSource = @[@{@"title":@"灯",@"image":@"lw_inteligence_light",@"tapAction":@"lightControl"},
                                   @{@"title":@"温控",@"image":@"lw_inteligence_thermost",@"tapAction":@"temperatureControl"},
                                   @{@"title":@"厨房",@"image":@"lw_inteligence_kitchen",@"tapAction":@"kitchenControl"},
                                   @{@"title":@"监控",@"image":@"lw_inteligence_camera",@"tapAction":@"cameraControl"},
                                   @{@"title":@"车库",@"image":@"lw_inteligence_car",@"tapAction":@"carControl"},
                                   @{@"title":@"水路",@"image":@"lw_inteligence_water",@"tapAction":@"waterControl"},
                                   @{@"title":@"衣架",@"image":@"lw_inteligence_clothestree",@"tapAction":@"clothestreeControl"},
                                   @{@"title":@"电视",@"image":@"lw_inteligence_tv",@"tapAction":@"tvControl"},
                                   @{@"title":@"门窗",@"image":@"lw_inteligence_door",@"tapAction":@"doorControl"},
                                   @{@"title":@"吸尘器",@"image":@"lw_inteligence_cleaner",@"tapAction":@"cleanerControl"},
                                   @{@"title":@"导航",@"image":@"lw_inteligence_gps",@"tapAction":@"gpsControl"},
                                   @{@"title":@"运动",@"image":@"lw_inteligence_sport",@"tapAction":@"sportControl"},
                                   @{@"title":@"燃气",@"image":@"lw_inteligence_gas",@"tapAction":@"gasControl"},
                                   @{@"title":@"空气质量",@"image":@"lw_inteligence_air",@"tapAction":@"airControl"},
                                   @{@"title":@"盆栽",@"image":@"lw_inteligence_potting",@"tapAction":@"pottingControl"}];
    
    __weak __typeof (&*self)weakSelf = self;
    [inteligenceSource enumerateObjectsUsingBlock:^(NSDictionary *dict, NSUInteger idx, BOOL * _Nonnull stop) {
        @autoreleasepool {
            LWIntelligenceModel *model = [[LWIntelligenceModel alloc]init];
            model.cellName = @"RadomLabelCollectionCell";
//            model.title = dict[@"title"];
            model.igenceControlType = idx;
            model.tapAction = dict[@"tapAction"];
            model.avatar = dict[@"image"];
            model.title = dict[@"title"];
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
