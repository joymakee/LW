//
//  LWSportVC.m
//  LW
//
//  Created by joymake on 2017/5/18.
//  Copyright © 2017年 joymake. All rights reserved.
//

#import "LWSportVC.h"
#import "JoySportCalcer.h"
#import "JoyCircleGradientLayerView.h"
#import "Joy.h"
#import "JoyLocationManager.h"
#import "JoyTextSpeechConversion.h"
#import "JoyBaseVC+LWCategory.h"

@interface LWSportVC (){
    CAGradientLayer *_gradientLayer;
}
@property (nonatomic,strong)JoyCircleGradientLayerView *pieView;
@property (nonatomic,strong)JoyCircleGradientLayerView *bigPieView;
@property (nonatomic,strong)UILabel *purposeStepsLabel;
@property (nonatomic,strong)UILabel *todayTallStepsLabel;
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
        _pieView =  [[JoyCircleGradientLayerView alloc]initWithFrame:CGRectMake(self.view.centerX-120, kStatusBarAndNavigationBarHeight+80, 240, 240)];
        [_pieView setParameterWithStrokeWidth:15 andPercent:0 andAnimation:YES];
    }
    return _pieView;
}

-(JoyCircleGradientLayerView *)bigPieView{
    if(!_bigPieView){
        _bigPieView =  [[JoyCircleGradientLayerView alloc]initWithFrame:CGRectMake(self.view.centerX-130, kStatusBarAndNavigationBarHeight+100, 260, 260)];
        _bigPieView.center= self.pieView.center;

        [_bigPieView setParameterWithStrokeWidth:5 andPercent:0 andAnimation:YES];
    }
    return _bigPieView;
}

-(UILabel *)todayTallStepsLabel{
    if (!_todayTallStepsLabel) {
        _todayTallStepsLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _todayTallStepsLabel.width = self.pieView.width/2;
        _todayTallStepsLabel.height = 20;
        _todayTallStepsLabel.center = self.pieView.center;
        _todayTallStepsLabel.textColor = [UIColor whiteColor];
        _todayTallStepsLabel.font = [UIFont boldSystemFontOfSize:20];
        _todayTallStepsLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _todayTallStepsLabel;
}

-(UILabel *)purposeStepsLabel{
    if (!_purposeStepsLabel) {
        _purposeStepsLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _purposeStepsLabel.width = self.pieView.width/2;
        _purposeStepsLabel.height = 20;
        _purposeStepsLabel.centerX = self.pieView.centerX;
        _purposeStepsLabel.bottom = self.todayTallStepsLabel.top-20;
        _purposeStepsLabel.textColor = [UIColor lightTextColor];
        _purposeStepsLabel.text = @"每日目标:10000";
        _purposeStepsLabel.font = [UIFont boldSystemFontOfSize:14];
        _purposeStepsLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _purposeStepsLabel;
}


- (void)setupUI{
    [self setRectEdgeAll];
    [self setBackViewWithImageName:nil bundleName:nil];
    [self.view addSubview:self.pieView];
    [self.view addSubview:self.bigPieView];
    [self.view addSubview:self.todayTallStepsLabel];
    [self.view addSubview:self.purposeStepsLabel];
}

- (void)sportData:(CMPedometerData *)obj{
    CGFloat percent = (float)[obj.numberOfSteps integerValue]/10000;
    self.todayTallStepsLabel.text = [obj.numberOfSteps stringValue];
    self.pieView.persentShow = percent;
    self.bigPieView.persentShow = 1;
    JoyTextSpeechConversion *speaker = [[JoyTextSpeechConversion alloc]init];
    [speaker speakStr:[NSString stringWithFormat:@"今天运动了%ld步,%ldm,完成度%@,请继续努力",(long)[obj.numberOfSteps integerValue],(long)[obj.distance integerValue],self.todayTallStepsLabel.text]];
}

-(void)leftNavItemClickAction{
    [super leftNavItemClickAction];
    [[JoySportCalcer shareInstance] stopPedometerUpdates];
}


@end
