//
//  LWWeatherModel.h
//  LW
//
//  Created by joymake on 2017/5/19.
//  Copyright © 2017年 joymake. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LWWeatherModel : NSObject
@property (nonatomic,copy)NSString *city;           //城市
@property (nonatomic,copy)NSString *temperature;    //温度
@property (nonatomic,copy)NSString *weather;        //白天天气
@property (nonatomic,copy)NSString *wind;           //风级

@property (nonatomic,copy)NSString *weatherStr;            //？
@property (nonatomic,strong)NSDictionary *weather_id;//天气

@property (nonatomic,copy)NSString *humidity;       //湿度
@property (nonatomic,copy)NSString *wind_direction;     //风向
@property (nonatomic,copy)NSString *wind_strength;  //风速

@end
