//
//  LWWeatherModel.m
//  LW
//
//  Created by joymake on 2017/5/19.
//  Copyright © 2017年 joymake. All rights reserved.
//

#import "LWWeatherModel.h"

@implementation LWWeatherModel
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

-(NSString *)weatherStr{

    NSDictionary *weatherDict = @{
        @"00":@"\ue628",
        @"01":@"\ue64b",
        @"02":@"\ue64f",
        @"03":@"\ue637",
        @"04":@"\ue64a",
        @"05":@"\ue64a",
        @"06":@"\ue649",
        @"07":@"\ue68c",
        @"08":@"\ue654",
        @"09":@"\ue653",
        @"10":@"\ue652",
        @"11":@"\ue8b2",
        @"12":@"\ue646",
        @"13":@"\ue63d",
        @"14":@"\ue633",
        @"15":@"\ue62d",
        @"16":@"\ue64e",
        @"17":@"\ue648",
        @"18":@"\ue630",
        @"19":@"\ue64c",
        @"20":@"\ue69b",
        @"21":@"\ue8af",
        @"22":@"\ue640",
        @"23":@"\ue8ab",
        @"24":@"\ue8b2",
        @"25":@"\ue63f",
        @"26":@"\ue8ae",
        @"27":@"\ue8b1",
        @"28":@"\ue8b1",
        @"29":@"\ue62f",
        @"30":@"\ue645",
        @"31":@"\ue69b",
        @"53":@"\ue630"
    };
    return _weatherStr =_weatherStr?:[weatherDict objectForKey:[self.weather_id objectForKey:@"fa"]];
}






@end
