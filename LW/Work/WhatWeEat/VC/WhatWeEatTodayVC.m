//
//  WhatWeEatTodayVC.m
//  LW
//
//  Created by wangguopeng on 2016/11/18.
//  Copyright © 2016年 joymake. All rights reserved.
//

#import "WhatWeEatTodayVC.h"
#import "PieView.h"
#import "FeatherView.h"
#import "MealModel.h"
#import "WhatWeEatTodayInteracter.h"
#import "BackGroundBlurView.h"

@interface WhatWeEatTodayVC ()<CAAnimationDelegate>{
    CGFloat _roatedValue ;
}
@property (nonatomic,strong)CABasicAnimation *transformAnimation;   //旋转动画
@property (weak, nonatomic) IBOutlet BackGroundBlurView *blurView;
@property (nonatomic,strong)IBOutlet PieView *pie;   //转盘

@property (weak, nonatomic) IBOutlet FeatherView *featherView;

@property (nonatomic,strong)WhatWeEatTodayInteracter *interacter;
@end

@implementation WhatWeEatTodayVC

#pragma mark lazyload method

-(WhatWeEatTodayInteracter *)interacter{
    return _interacter = _interacter?:[[WhatWeEatTodayInteracter alloc]init];
}

-(CABasicAnimation *)transformAnimation{
    if (!_transformAnimation) {
        //设置旋转动画
        _transformAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        _transformAnimation.delegate = self;
        _transformAnimation.fillMode = kCAFillModeForwards;
        _transformAnimation.removedOnCompletion = NO;
        _transformAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        [_transformAnimation setDuration:2];
    }
    return _transformAnimation;
}

#pragma mark life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"吃饭选择困难户";
    [self.interacter getMealDataSource];
    [self.blurView setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle]
                                                              pathForResource:@"shuye"
                                                              ofType:@"jpg"]] andBlur:1];

    _pie.totalRadious = self.interacter.totalRadious;
    _pie.dataArrayM = self.interacter.dataArrayM;
    __weak __typeof (&*self)weakSelf = self;
    [self.featherView drawFeatherViewTouchBlock:^{[weakSelf roate];}];
}

#pragma mark animation
- (void)roate{
    _roatedValue = M_PI *(float)(arc4random()%314)/157;
    self.transformAnimation.toValue = @(6*M_PI +_roatedValue);
    [_pie.layer addAnimation:self.transformAnimation forKey:@"position"];
}

#pragma mark animation stop
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    self.transformAnimation.fromValue = @(_roatedValue);
    __block CGFloat totalValue = 0;
    __weak __typeof (&*self)weakSelf = self;
    [self.interacter.dataArrayM enumerateObjectsUsingBlock:^(MealModel *model, NSUInteger idx, BOOL * _Nonnull stop) {
        totalValue += model.mealRadius;
        if (2*M_PI * totalValue/weakSelf.self.interacter.totalRadious + _roatedValue>=2*M_PI) {
        MealModel *model = weakSelf.pie.dataArrayM[idx];
        NSLog(@"你选中了%@",model.title);
        *stop = YES;
        }
    }];
}

@end
