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
    NSArray *inteligenceSource = @[@{@"title":@"灯",@"icon":@"\ue650",@"tapAction":@"lightControl"},
                                   @{@"title":@"温控",@"icon":@"\ue618",@"tapAction":@"temperatureControl"},
                                   @{@"title":@"煮粥",@"icon":@"\ue60d",@"tapAction":@"kitchenControl"},
                                   @{@"title":@"监控",@"icon":@"\ue62a",@"tapAction":@"cameraControl"},
                                   @{@"title":@"车库",@"icon":@"\ue609",@"tapAction":@"carControl"},
//                                   @{@"title":@"水路",@"image":@"lw_inteligence_water",@"tapAction":@"waterControl"},
                                   @{@"title":@"电视",@"icon":@"\ue662",@"tapAction":@"tvControl"},
                                   @{@"title":@"门窗",@"icon":@"\ue606",@"tapAction":@"doorControl"},
                                   @{@"title":@"吸尘器",@"icon":@"\ue62a",@"tapAction":@"cleanerControl"},
                                   @{@"title":@"导航",@"icon":@"\ue624",@"tapAction":@"gpsControl"},
                                   @{@"title":@"运动",@"icon":@"\ue604",@"tapAction":@"sportControl"},
                                   @{@"title":@"空气质量",@"icon":@"\ue68e",@"tapAction":@"airControl"},
                                   @{@"title":@"绿植",@"icon":@"\ue605",@"tapAction":@"pottingControl"}];
    
    [inteligenceSource enumerateObjectsUsingBlock:^(NSDictionary *dict, NSUInteger idx, BOOL * _Nonnull stop) {
            LWIntelligenceModel *model = [[LWIntelligenceModel alloc]init];
            model.cellName = @"RadomLabelIconCollectionCell";
            model.igenceControlType = idx;
//            model.cellType = ECellXibType;
            model.tapAction = dict[@"tapAction"];
            model.subTitle = dict[@"icon"];
            model.title = dict[@"title"];
            CGFloat color = (float)idx/inteligenceSource.count;
        int red = color*200;
        int green = 0.4*200;
        int blue = (1-color)*180;

        NSString *colorStr = [@"#" stringByAppendingString:[NSString stringWithFormat:@"%02x",red]];
        colorStr = [colorStr stringByAppendingString:[NSString stringWithFormat:@"%02x",green]];
        colorStr =[colorStr stringByAppendingString:[NSString stringWithFormat:@"%02x",blue]];
        
        model.backgroundColor = colorStr;
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
