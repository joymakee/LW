//
//  LWSportVC.m
//  LW
//
//  Created by wangguopeng on 2017/5/18.
//  Copyright © 2017年 joymake. All rights reserved.
//

#import "LWSportVC.h"
#import "PiechartView.h"
#import "JoySportCalcer.h"

@interface LWSportVC ()

@end

@implementation LWSportVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"运动";
    __weak __typeof (&*self)weakSelf = self;
    [[JoySportCalcer shareInstance]queryTodaySportData:^(CMPedometerData *obj) {
        [weakSelf sportData:obj];
    } errorBlock:nil];
}

- (void)sportData:(CMPedometerData *)obj{
    
    CGFloat percent = (float)[obj.numberOfSteps integerValue]/10000;
    PiechartView *pieView = [[PiechartView alloc]initWithFrame:CGRectMake(self.view.centerX-100, 100, 200, 200) withStrokeWidth:10 andPercent:percent andAnimation:YES];
    [self.view addSubview:pieView];
    
    UILabel *percentLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    percentLabel.width = pieView.width - 30;
    percentLabel.height = 20;
    percentLabel.center = pieView.center;
    percentLabel.text = [[NSString stringWithFormat:@"%.2f",percent>1?100:(float)percent *100
] stringByAppendingString:@"%"];
    percentLabel.textColor = JOY_brownColor;
    percentLabel.font = [UIFont boldSystemFontOfSize:20];
    percentLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:percentLabel];
    
    
    UILabel *stepcountLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    stepcountLabel.width = pieView.width - 30;
    stepcountLabel.height = 20;
    stepcountLabel.centerY =50;
    stepcountLabel.centerX = self.view.centerX;
    stepcountLabel.text = [NSString stringWithFormat:@"%@步",obj.numberOfSteps];
    stepcountLabel.textColor = JOY_brownColor;
    stepcountLabel.font = [UIFont boldSystemFontOfSize:20];
    stepcountLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:stepcountLabel];


}

@end
