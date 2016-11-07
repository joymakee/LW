//
//  LWSingleLabelCell.m
//  LW
//
//  Created by Joymake on 16/6/30.
//  Copyright © 2016年 joymake. All rights reserved.
//

#import "LWSingleLabelCell.h"
#import <QuartzCore/QuartzCore.h>

@interface LWSingleLabelCell (){
    NSTimer *_timer;
}
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (nonatomic,assign)CGFloat progress;
@property (strong, nonatomic) CAGradientLayer *gradientLayer;
@end

@implementation LWSingleLabelCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

-(void)dealloc{
    [_timer setFireDate:[NSDate distantFuture]];
    _timer = nil;
}

- (CAGradientLayer *)gradientLayer{
    if (!_gradientLayer) {
        _gradientLayer = [CAGradientLayer layer];
        _gradientLayer.endPoint = CGPointMake(1, 0);
        _gradientLayer.startPoint = CGPointMake(0, 0);
        _gradientLayer.mask = self.titleLabel.layer;
        //设定颜色组
        _gradientLayer.colors = @[(__bridge id)[UIColor purpleColor].CGColor,
                                  (__bridge id)[UIColor clearColor].CGColor,
                                  (__bridge id)[UIColor yellowColor].CGColor,
                                  (__bridge id)[UIColor redColor].CGColor,
                                  (__bridge id)[UIColor greenColor].CGColor,
                                  (__bridge id)[UIColor orangeColor].CGColor,
                                  (__bridge id)[UIColor greenColor].CGColor
                                  ];
        [self.contentView.layer addSublayer:_gradientLayer];
        _timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(update) userInfo:@"" repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:_timer forMode:UITrackingRunLoopMode];
    }
    return _gradientLayer;
}

- (void)setCellWithModel:(LWCellBaseModel *)model{
    LWCellBaseModel *setModel = (LWCellBaseModel *)model;
    self.titleLabel.text = setModel.title;
    [_timer setFireDate:[NSDate distantFuture]];
    [_timer setFireDate:[NSDate distantPast]];
}

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    self.gradientLayer.frame = self.contentView.bounds;
    self.gradientLayer.cornerRadius = CGRectGetHeight(self.titleLabel.bounds)/2;
    
}

- (void)update{
    self.progress +=1;
    if (self.progress>100) {
        self.progress = 1;
    }
    //定时改变分割点
    self.gradientLayer.locations = @[@(0.0f), @(_progress/100)];
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
