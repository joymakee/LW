//
//  LWThermostatCell.m
//  LW
//
//  Created by joymake on 2017/5/23.
//  Copyright © 2017年 joymake. All rights reserved.
//

#import "LWThermostatCell.h"
#import "LWTempratureView.h"
#import "LWtempratureCellModel.h"
#import "LWImageView.h"
#import <Joy.h>
#import <CAAnimation+HCAnimation.h>

@interface LWThermostatCell (){
    LWtempratureCellModel *_model;
    NSInteger _windSpeed;
}
@property (weak, nonatomic) IBOutlet LWImageView *windSpeedImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (nonatomic,strong)IBOutlet LWTempratureView *tempratureView;
@property (weak, nonatomic) IBOutlet UILabel *targetTemprature;
@property (weak, nonatomic) IBOutlet UILabel *currentTemprature;
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UISwitch *powerSwitch;

@end
@implementation LWThermostatCell

-(void)setCellWithModel:(LWtempratureCellModel *)model{
    _model = model;
    self.titleLabel.text = model.title;
    self.backView.layer.masksToBounds = YES;
    self.backView.layer.cornerRadius = 18;
    self.backView.layer.borderWidth =1;

    self.targetTemprature.layer.masksToBounds = self.currentTemprature.layer.masksToBounds = YES;
    
    self.targetTemprature.layer.cornerRadius = self.currentTemprature.layer.cornerRadius = 7.5;
    
    self.targetTemprature.layer.borderWidth = self.currentTemprature.layer.borderWidth = 1;

    [self setTargetTP:model.targetValue/50];
    
    self.currentTemprature.text = [@(model.currentValue) stringValue];
    self.currentTemprature.layer.borderColor =
    self.backView.layer.borderColor = [UIColor colorWithRed:model.currentValue/50 green:0.2 blue:1-model.currentValue/50 alpha:0.8].CGColor;
    
    [self openPower:_model.on]; //电源状态
    
    self.tempratureView.currentValue = model.currentValue/50;
    
    self.tempratureView.targetValue = model.targetValue/50;

    __weak __typeof(&*self)weakSelf = self;
    self.tempratureView.valueChangedBlock = ^(float floatNumber) {
        [weakSelf setTargetTP:floatNumber];
    };
    
    self.tempratureView.valueChangedEndBlock = ^(float floatNumber) {
        [weakSelf windSpeedChanged];
    };
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [weakSelf windSpeedChanged];    //风机状态
    });
}

- (void)setTargetTP:(CGFloat)value{
    self.targetTemprature.text = [NSString stringWithFormat:@"%ld",(long)[@(value*50) integerValue]];
    _model.targetValue = value*50;
    self.targetTemprature.layer.borderColor = [UIColor colorWithRed:value green:0.2 blue:1-value alpha:0.8].CGColor;
}

- (IBAction)switchValuechanged:(UISwitch *)sender {
    [self openPower:sender.on];
}

- (void)openPower:(BOOL)on{
    self.powerSwitch.on = on;
    _model.on = on;
    self.tempratureView.disableGsture = !on;
    self.backView.backgroundColor = on?[UIColor colorWithRed:_model.currentValue/50 green:0.3 blue:1-_model.currentValue/50 alpha:0.8]:[UIColor lightTextColor];
    if(!on){
        [CAAnimation clearAnimationInView:self.windSpeedImageView];
        _windSpeed = 0;
    }else{[self windSpeedChanged];}
}

- (void)windSpeedChanged{
    float Speed= fabsf(_model.targetValue - _model.currentValue);
    if (Speed>=6 &&_windSpeed!=1) {
        _windSpeed = 1;
        [CAAnimation clearAnimationInView:self.windSpeedImageView];
        [CAAnimation showRotateAnimationInView:self.windSpeedImageView Degree:M_PI*2 Direction:AxisZ Repeat:0 Duration:_windSpeed autoreverses:NO];
    }else if (Speed<6 &&Speed>3 &&_windSpeed!=2){
        _windSpeed = 2;
        [CAAnimation clearAnimationInView:self.windSpeedImageView];
        [CAAnimation showRotateAnimationInView:self.windSpeedImageView Degree:M_PI*2 Direction:AxisZ Repeat:0 Duration:_windSpeed autoreverses:NO];
    }else if(_windSpeed !=3&&Speed<=3){
        _windSpeed = 3;
        [CAAnimation clearAnimationInView:self.windSpeedImageView];
        [CAAnimation showRotateAnimationInView:self.windSpeedImageView Degree:M_PI*2 Direction:AxisZ Repeat:0 Duration:_windSpeed autoreverses:NO];
    }
}

-(void)dealloc{
    [CAAnimation clearAnimationInView:self.windSpeedImageView];
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}
@end
