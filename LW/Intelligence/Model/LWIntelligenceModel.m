//
//  LWIntelligenceModel.m
//  LW
//
//  Created by joymake on 16/7/6.
//  Copyright © 2016年 joymake. All rights reserved.
//

#import "LWIntelligenceModel.h"

@implementation LWIntelligenceModel
- (void)goControl{
    switch (self.igenceControlType) {
        case EIntelligenceControlMonitoringType://监控
            [self goMonitoring];
            break;
        case EIntelligenceControlThermostType://温控
            [self goThermost];
            break;
        case EIntelligenceControlKitchenType://@"厨房"
            [self goKitchen];
            break;
        case EIntelligenceControlLightType://@"灯"
            [self goLight];
            break;
        case EIntelligenceControlGarageType://@"车库"
            [self goGarage];
            break;
        case EIntelligenceControlWaterType://@"水路"
            [self goWater];
            break;
        case EIntelligenceControlElectricType://@"电路"
            [self goElectric];
            break;
        case EIntelligenceControlDoorType://@"门窗"
            [self goDoor];
            break;
        case EIntelligenceControlRacksType://@"衣架"
            [self goRacks];
            break;
        case EIntelligenceControlToysType://@"玩具"
            [self goToys];
            break;
        case EIntelligenceControlTVType://@"电视"
            [self goTV];
            break;
        case EIntelligenceControlBedType://@"床"
            [self goBed];
            break;
        case EIntelligenceControlCleanerType://@"吸尘器"
            [self goCleaner];
            break;
        case EIntelligenceControlNavigationType://@"导航"
            [self goNavigation];
            break;
        case EIntelligenceControlSportType://@"运动"
            [self goSport];
            break;
            default:
            break;
    }
}

- (void)goMonitoring{
    
}

- (void)goThermost{
    
}

- (void)goKitchen{
    
}

- (void)goLight{
    
}

- (void)goGarage{
    
}

- (void)goWater{
    
}

- (void)goElectric{
    
}

- (void)goDoor{
    
}

- (void)goRacks{
    
}

- (void)goToys{
    
}

- (void)goTV{
    
}

- (void)goBed{
    
}

- (void)goCleaner{
    
}

- (void)goNavigation{
    
}

- (void)goSport{
    
}
@end
