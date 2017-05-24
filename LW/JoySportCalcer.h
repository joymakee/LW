//
//  JoySportCalcer.h
//  LW
//
//  Created by wangguopeng on 2017/5/4.
//  Copyright © 2017年 joymake. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreMotion/CoreMotion.h>

@interface JoySportCalcer : UIView
+ (instancetype)shareInstance;

#pragma mark 查看今天的运动记录
- (void)queryTodaySportData:(IDBLOCK)block errorBlock:(ERRORBLOCK)errorBlock;//CMPedometerData
#pragma mark 查看当月的运动记录
- (void)queryMonthSportData:(IDBLOCK)block errorBlock:(ERRORBLOCK)errorBlock;
#pragma mark 查看今年的运动记录
- (void)queryYearSportData:(IDBLOCK)block errorBlock:(ERRORBLOCK)errorBlock;
#pragma mark 查看某个时间段的运动记录
- (void)queryPedometerDataFromDate:(NSDate *)startDate toDate:(NSDate *)toDate block:(IDBLOCK)block errorBlock:(ERRORBLOCK)errorBlock;

#pragma MARK 实时更新
- (void)startPedometerUpdatesFromDate:(NSDate *)start
                          withHandler:(CMPedometerHandler)handler;
#pragma mark停止实时更新
- (void)stopPedometerUpdates;
@end
