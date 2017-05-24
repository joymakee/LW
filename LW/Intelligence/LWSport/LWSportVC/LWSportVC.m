//
//  LWSportVC.m
//  LW
//
//  Created by wangguopeng on 2017/5/18.
//  Copyright © 2017年 joymake. All rights reserved.
//

#import "LWSportVC.h"
#import "JoySportCalcer.h"
#import "JoyCircleGradientLayerView.h"
#import "Joy.h"

@interface LWSportVC (){
    CAGradientLayer *_gradientLayer;
}
@property (nonatomic,strong)JoyCircleGradientLayerView *pieView;
@property (nonatomic,strong)JoyCircleGradientLayerView *bigPieView;

@property (nonatomic,strong)UILabel *todayTallStepsLabel;
@property (nonatomic,strong)UILabel *completionProgressLabel;

@end

@implementation LWSportVC

- (void)viewDidLoad {
    [super viewDidLoad];

    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM月dd日"];
    NSString *currentDateStr = [dateFormatter stringFromDate:[NSDate date]];
    
    self.title = [NSString stringWithFormat:@"%@",currentDateStr];
    [self setupUI];
    __weak __typeof (&*self)weakSelf = self;
    [[JoySportCalcer shareInstance]queryTodaySportData:^(CMPedometerData *obj) {
        [weakSelf sportData:obj];
    } errorBlock:nil];
}

-(JoyCircleGradientLayerView *)pieView{
    if(!_pieView){
        _pieView =  [[JoyCircleGradientLayerView alloc]initWithFrame:CGRectMake(self.view.centerX-100, 100, 200, 200)];
        [_pieView setParameterWithStrokeWidth:15 andPercent:0 andAnimation:YES];
    }
    return _pieView;
}

-(JoyCircleGradientLayerView *)bigPieView{
    if(!_bigPieView){
        _bigPieView =  [[JoyCircleGradientLayerView alloc]initWithFrame:CGRectMake(self.view.centerX-120, 120, 220, 220)];
        _bigPieView.center= self.pieView.center;

        [_bigPieView setParameterWithStrokeWidth:5 andPercent:0 andAnimation:YES];
    }
    return _bigPieView;
}

-(UILabel *)completionProgressLabel{
    if (!_completionProgressLabel) {
        _completionProgressLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _completionProgressLabel.width = self.pieView.width/2;
        _completionProgressLabel.height = 20;
        _completionProgressLabel.center = self.pieView.center;
        _completionProgressLabel.textColor = JOY_brownColor;
        _completionProgressLabel.font = [UIFont boldSystemFontOfSize:20];
        _completionProgressLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _completionProgressLabel;
}

-(UILabel *)todayTallStepsLabel{
    if (!_todayTallStepsLabel) {
        _todayTallStepsLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _todayTallStepsLabel.width = self.view.width - 20;
        _todayTallStepsLabel.height = 20;
        _todayTallStepsLabel.centerY =50;
        _todayTallStepsLabel.centerX = self.view.centerX;
        _todayTallStepsLabel.textColor = JOY_brownColor;
        _todayTallStepsLabel.font = [UIFont boldSystemFontOfSize:20];
        _todayTallStepsLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _todayTallStepsLabel;
}

- (void)setupUI{
    [self.view addSubview:self.pieView];
    [self.view addSubview:self.bigPieView];
    [self.view addSubview:self.completionProgressLabel];
    [self.view addSubview:self.todayTallStepsLabel];
}

- (void)sportData:(CMPedometerData *)obj{
    CGFloat percent = (float)[obj.numberOfSteps integerValue]/10000;
    self.todayTallStepsLabel.text = [NSString stringWithFormat:@"%ld步\t😊\t%ldm",(long)[obj.numberOfSteps integerValue],(long)[obj.distance integerValue]];
    self.completionProgressLabel.text = [[NSString stringWithFormat:@"%.0f",percent>1?100:(float)percent *100] stringByAppendingString:@"%"];
    self.pieView.persentShow = percent;
    self.bigPieView.persentShow = percent;

}

-(void)leftNavItemClickAction{
    [super leftNavItemClickAction];
    [[JoySportCalcer shareInstance] stopPedometerUpdates];
}


@end
