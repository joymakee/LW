//
//  IntelligenceTitleView.m
//  LW
//
//  Created by joymake on 2017/6/8.
//  Copyright © 2017年 joymake. All rights reserved.
//

#import "IntelligenceTitleView.h"
#import "LWImageView.h"
#import "LWWeatherModel.h"
@interface IntelligenceTitleView ()
@property (weak, nonatomic) IBOutlet LWImageView *weatherImageView;
@property (weak, nonatomic) IBOutlet UILabel *cityLabel;
@property (weak, nonatomic) IBOutlet UILabel *hdLabel;
@property (weak, nonatomic) IBOutlet UILabel *tpLabel;

@end

@implementation IntelligenceTitleView

-(void)setWeatherModel:(LWWeatherModel *)weather{

    self.weatherImageView.image = [UIImage imageNamed:weather.img];
    self.tpLabel.text = [NSString stringWithFormat:@" 🌡️%@℃ ☁️%@ ",weather.temperature,weather.info];
    self.hdLabel.text = [NSString stringWithFormat:@" 💦%@%% 🌪%@ ",weather.humidity,weather.power ];
    self.cityLabel.text = [NSString stringWithFormat:@" %@ ",weather.city_name];
    [self initBaseInfo];
}

-(instancetype)init{
    if (self = [super init]) {
        [self initBaseInfo];
    }
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        [self initBaseInfo];
    }
    return self;
}

- (void)initBaseInfo{
    self.cityLabel.layer.masksToBounds = self.tpLabel.layer.masksToBounds = self.hdLabel.layer.masksToBounds = YES;
    self.cityLabel.layer.borderColor =self.tpLabel.layer.borderColor = self.hdLabel.layer.borderColor = [UIColor colorWithRed:0.2 green:0.6 blue:0.2 alpha:0.6].CGColor;
    self.tpLabel.layer.borderWidth = self.hdLabel.layer.borderWidth = 1;
    self.tpLabel.layer.cornerRadius = self.hdLabel.layer.cornerRadius= 6;
    self.cityLabel.layer.borderWidth = 1;
    self.cityLabel.layer.cornerRadius = 10;
}

@end

