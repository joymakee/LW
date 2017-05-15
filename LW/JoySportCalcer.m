//
//  JoySportCalcer.m
//  LW
//
//  Created by wangguopeng on 2017/5/4.
//  Copyright © 2017年 joymake. All rights reserved.
//

#import "JoySportCalcer.h"
#import "JoyAlert.h"

@interface JoySportCalcer ()
@property (nonatomic,strong)CMPedometer *pedometer;
@end

static JoySportCalcer *sportCalcer;
@implementation JoySportCalcer


+(instancetype)shareInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sportCalcer = [[super alloc]init];
    });
    return sportCalcer;
}

-(CMPedometer *)pedometer{
    return _pedometer = _pedometer?:[[CMPedometer alloc]init];
}

#pragma mark 查看今天的运动记录
- (void)queryTodaySportData:(IDBLOCK)block errorBlock:(ERRORBLOCK)errorBlock{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:[NSDate date]];
    NSDate *startDate = [calendar dateFromComponents:components];
    [self querySportDataFromDate:startDate toDate:[NSDate date] block:block errorBlock:errorBlock];
}

#pragma mark 查看当月的运动记录
- (void)queryMonthSportData:(IDBLOCK)block errorBlock:(ERRORBLOCK)errorBlock{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth fromDate:[NSDate date]];
    NSDate *startDate = [calendar dateFromComponents:components];
    [self querySportDataFromDate:startDate toDate:[NSDate date] block:block errorBlock:errorBlock];
}

#pragma mark 查看今年的运动记录
- (void)queryYearSportData:(IDBLOCK)block errorBlock:(ERRORBLOCK)errorBlock{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear fromDate:[NSDate date]];
    NSDate *startDate = [calendar dateFromComponents:components];
    [self querySportDataFromDate:startDate toDate:[NSDate date] block:block errorBlock:errorBlock];
}


#pragma mark 查看某个时间段的运动记录
- (void)querySportDataFromDate:(NSDate *)startDate toDate:(NSDate *)toDate block:(IDBLOCK)block errorBlock:(ERRORBLOCK)errorBlock{
    if([self checkSportAvaliable]){
    __weak __typeof (&*self)weakSelf = self;
    [self.pedometer queryPedometerDataFromDate:startDate toDate:toDate withHandler:^(CMPedometerData * _Nullable pedometerData, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            error?[weakSelf showError:error block:errorBlock]:(block?block(pedometerData):nil);
        });
    }];
    }
}

-(void)showError:(NSError *)error block:(ERRORBLOCK)errorBlock{
    if(errorBlock)
    {
        errorBlock(error);
    }else{
    NSString *title,*message,*cancleTitle,*confirmTitle = nil;
    if (error.code == CMErrorMotionActivityNotAuthorized) {
        title = @"访问健康数据";
        message = @"请前往设置中开启\"运动与健身\"开关";
        cancleTitle = @"取消";
        confirmTitle = @"开启";
    }else{
        title = @"获取计步信息失败";
        message = [NSString stringWithFormat:@"错误信息:%@",error.description];
        cancleTitle = @"确定";
    }
    [[JoyAlert shareAlert]showAlertViewWithTitle:title message:message cancle:cancleTitle confirm:confirmTitle alertBlock:nil];
    }

}

- (BOOL)checkSportAvaliable{
    if ([UIDevice currentDevice].systemVersion.floatValue < 8.0 || ![CMPedometer isStepCountingAvailable])
    {
        [[JoyAlert shareAlert]showAlertViewWithTitle:@"提示" message:@"当前系统版本不支持计步功能" cancle:@"确定" confirm:nil alertBlock:nil];
        return NO;
    }
    return YES;
}

@end
