//
//  intelligenceViewModel.m
//  LW
//
//  Created by joymake on 16/7/6.
//  Copyright © 2016年 joymake. All rights reserved.
//

#import "Intelligencelnteractor.h"
#import "LWIntelligenceModel.h"
#import "AFNetworking.h"
#import "LWWeatherModel.h"
#import <MJProperty.h>

static const NSString *weahTherAppKey = @"06423a901d5349ffa9dc23031e460f00";

#define KgetAvatarWeather(cityName) [NSString stringWithFormat:@"http://api.avatardata.cn/Weather/Query?key=%@&cityname=%@",weahTherAppKey,cityName]



@interface Intelligencelnteractor ()
@property (nonatomic,strong)AFHTTPSessionManager *netManager;
@end

@implementation Intelligencelnteractor
-(void)getIntelligenceSource{
    
    [self.dataArrayM removeAllObjects];
    NSArray *inteligenceSource = @[@{@"title":@"灯",@"image":@"lw_inteligence_light",@"tapAction":@"lightControl"},
                                   @{@"title":@"温控",@"image":@"lw_inteligence_thermost",@"tapAction":@"temperatureControl"},
                                   @{@"title":@"煮粥",@"image":@"lw_inteligence_kitchen",@"tapAction":@"kitchenControl"},
                                   @{@"title":@"监控",@"image":@"lw_inteligence_camera",@"tapAction":@"cameraControl"},
                                   @{@"title":@"车库",@"image":@"lw_inteligence_car",@"tapAction":@"carControl"},
//                                   @{@"title":@"水路",@"image":@"lw_inteligence_water",@"tapAction":@"waterControl"},
                                   @{@"title":@"电视",@"image":@"lw_inteligence_tv",@"tapAction":@"tvControl"},
                                   @{@"title":@"门窗",@"image":@"lw_inteligence_door",@"tapAction":@"doorControl"},
                                   @{@"title":@"吸尘器",@"image":@"lw_inteligence_cleaner",@"tapAction":@"cleanerControl"},
                                   @{@"title":@"导航",@"image":@"lw_inteligence_gps",@"tapAction":@"gpsControl"},
                                   @{@"title":@"运动",@"image":@"lw_inteligence_sport",@"tapAction":@"sportControl"},
                                   @{@"title":@"空气质量",@"image":@"1",@"tapAction":@"airControl"},
                                   @{@"title":@"绿植",@"image":@"lw_inteligence_potting",@"tapAction":@"pottingControl"}];
    
    [inteligenceSource enumerateObjectsUsingBlock:^(NSDictionary *dict, NSUInteger idx, BOOL * _Nonnull stop) {
            LWIntelligenceModel *model = [[LWIntelligenceModel alloc]init];
            model.cellName = @"RadomLabelCollectionCell";
            model.igenceControlType = idx;
            model.tapAction = dict[@"tapAction"];
            model.avatar = dict[@"image"];
            model.title = dict[@"title"];
            CGFloat color = (float)idx/inteligenceSource.count;
            model.backgroundColor = [UIColor colorWithRed:color green:0.4 blue:1-color alpha:0.6];
        model?[self.dataArrayM addObject:model]:nil;
    }];
}

#pragma mark 获取天气信息
- (void)getWeatherDataWithCity:(NSString *)cityName days:(int)days block:(IDBLOCK)block{
    NSString *weatherStr =KgetAvatarWeather(cityName);
    weatherStr = [weatherStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding ];
    [self.netManager GET:weatherStr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if([responseObject[@"result"] isKindOfClass:[NSDictionary class]]){
        NSDictionary *weatherDic =  responseObject[@"result"][@"realtime"];
        LWWeatherModel *weatherModel = [[LWWeatherModel alloc] init];
        NSDictionary *windDic = weatherDic[@"wind"];
        NSDictionary *weather = weatherDic[@"weather"];
        [weatherModel setValuesForKeysWithDictionary:windDic];
        [weatherModel setValuesForKeysWithDictionary:weather];
        [weatherModel setValuesForKeysWithDictionary:weatherDic];
        block?block(weatherModel):nil;
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"");
    }];
}


-(AFHTTPSessionManager *)netManager{
    return _netManager = _netManager?:[AFHTTPSessionManager manager];
}
-(NSMutableArray *)dataArrayM{
    _dataArrayM = _dataArrayM?:[NSMutableArray arrayWithCapacity:0];
    return _dataArrayM;
}

@end
