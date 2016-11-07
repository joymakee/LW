//
//  LWIntelligenceModel.h
//  LW
//
//  Created by joymake on 16/7/6.
//  Copyright © 2016年 joymake. All rights reserved.
//

typedef NS_ENUM(NSInteger,EIntelligenceControlType) {
    EIntelligenceControlMonitoringType = 0,//监控
    EIntelligenceControlThermostType,//温控
    EIntelligenceControlKitchenType,//@"厨房"
    EIntelligenceControlLightType,//@"灯"
    EIntelligenceControlGarageType,//@"车库"
    EIntelligenceControlWaterType,//@"水路"
    EIntelligenceControlElectricType,//@"电路"
    EIntelligenceControlDoorType,//@"门窗"
    EIntelligenceControlRacksType,//@"衣架"
    EIntelligenceControlToysType,//@"玩具"
    EIntelligenceControlTVType,//@"电视"
    EIntelligenceControlBedType,//@"床"
    EIntelligenceControlCleanerType,//@"吸尘器"
    EIntelligenceControlNavigationType,//@"导航"
    EIntelligenceControlSportType//@"运动"
};
#import "LWCellBaseModel.h"

@interface LWIntelligenceModel : LWCellBaseModel
@property (nonatomic,assign)EIntelligenceControlType igenceControlType;
@end
