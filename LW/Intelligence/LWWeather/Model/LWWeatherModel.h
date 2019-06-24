//
//  LWWeatherModel.h
//  LW
//
//  Created by joymake on 2017/5/19.
//  Copyright © 2017年 joymake. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LWWeatherModel : NSObject
@property (nonatomic,copy)NSString *city_name;   //湿度
@property (nonatomic,copy)NSString *time;   //湿度
@property (nonatomic,copy)NSString *week;   //湿度
@property (nonatomic,copy)NSString *temperature;    //温度
@property (nonatomic,copy)NSString *img;        //？
@property (nonatomic,copy)NSString *info;       //白天天气
@property (nonatomic,copy)NSString *humidity;   //湿度
@property (nonatomic,copy)NSString *direct;     //风向
@property (nonatomic,copy)NSString *power;      //风级
@property (nonatomic,copy)NSString *windspeed;  //风速

@end
