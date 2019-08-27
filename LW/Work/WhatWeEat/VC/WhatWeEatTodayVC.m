//
//  WhatWeEatTodayVC.m
//  LW
//
//  Created by joymake on 2016/11/18.
//  Copyright © 2016年 joymake. All rights reserved.
//

#import "WhatWeEatTodayVC.h"
#import "PieView.h"         //转盘
#import "FeatherView.h"     //指针
#import "MealModel.h"       //转盘上的每一个菜单模型
#import "WhatWeEatTodayInteracter.h"    //数据处理源
#import "BackGroundBlurView.h"          //模糊背景
#import <JoyTableAutoLayoutView.h>       //弹出的table
#import <JoyKit/JoyKit.h>     //table的section模型
#import <JoyKit/CALayer+JoyLayer.h>
#import "CustomMealInteracter.h"        //table的cell模型
#import <CALayer+JoyLayer.h>
#import "CustomMealVC.h"
#import <JoyRequest/Joy_NetCacheTool.h>

extern const NSString *lw_meal_key;
extern const NSString *selectMealKey ;
extern const NSString *deSelectMealKey;

@interface WhatWeEatTodayVC ()<CAAnimationDelegate>{
    CGFloat _roatedValue ;
}
@property (nonatomic,strong)CABasicAnimation *transformAnimation;   //旋转动画
@property (weak, nonatomic) IBOutlet BackGroundBlurView *blurView;
@property (nonatomic,strong)IBOutlet PieView *pie;   //转盘
@property (weak, nonatomic) IBOutlet FeatherView *featherView;
@property (weak, nonatomic) IBOutlet UILabel *selectLabel;
@property (nonatomic,strong)WhatWeEatTodayInteracter *interacter;

@property (nonatomic,strong)CustomMealInteracter *customMealInteracter;
@end

@implementation WhatWeEatTodayVC

#pragma mark lazyload method

-(void)dealloc{
    [self.pie.layer removeAllAnimations];
    [self.pie.layer removeFromSuperlayer];
    [self.featherView.layer removeFromSuperlayer];
}

-(CustomMealInteracter *)customMealInteracter{
    return _customMealInteracter = _customMealInteracter?:[[CustomMealInteracter alloc]init];
}

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

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setRectEdgeAll];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self recoveryEdgeNav];
}

#pragma mark life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"摇一摇";
    [[UIApplication sharedApplication] setApplicationSupportsShakeToEdit:YES];
    [self becomeFirstResponder];
    [self setRightNavItemWithTitle:@"换口味"];
    [self setRectEdgeAll];
    [self.featherView setBounds:CGRectMake(0, 0, kSCREEN_WIDTH-40, kSCREEN_WIDTH-40)];
    [self.pie setBounds:self.featherView.bounds];
    self.navigationController.navigationBar.translucent = YES;
    NSDictionary *mealDict = [Joy_NetCacheTool scbuDictCacheForKey:lw_meal_key];
    NSArray *selects = [mealDict objectForKey:selectMealKey];
    [self reloadPieViewWithDataSource:selects];
    __weak __typeof (&*self)weakSelf = self;
    [self.featherView drawFeatherViewTouchBlock:^{[weakSelf roate];}];
}

-(void)reloadPieViewWithDataSource:(NSArray *)dataSource{
    [self.interacter getMealDataSourceWithDataSouce:dataSource];
    _pie.totalRadious = self.interacter.totalRadious;
    _pie.dataArrayM = self.interacter.dataArrayM;
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
    @LwWeak(self);
    [self.interacter.dataArrayM enumerateObjectsUsingBlock:^(MealModel *model, NSUInteger idx, BOOL * _Nonnull stop) {
        @LwStrong(self);
        totalValue += model.mealRadius;
        if (2*M_PI * totalValue/self.interacter.totalRadious + _roatedValue>=2*M_PI)
        {
            MealModel *model = self.pie.dataArrayM[idx];
            [self.selectLabel.layer transitionWithAnimType:TransitionAnimTypeOglFlip subType:TransitionSubtypesFromLeft curve:TransitionCurveRamdom duration:1];
            self.selectLabel.text = model.title;
            self.selectLabel.textColor = LW_RADOM_COLOR_NOALPHA;
            self.selectLabel.backgroundColor = LW_RADOM_COLOR;
            *stop = YES;
        }
    }];
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event{
    if (event.subtype == UIEventSubtypeMotionShake) {
        [self roate];
    }
}

-(void)rightNavItemClickAction{
    [super rightNavItemClickAction];
    CustomMealVC *vc = [CustomMealVC new];
    self.hidesBottomBarWhenPushed = YES;
    __weak __typeof (&*self)weakSelf = self;
    [vc routeParam:@{@"selectedMeal":[self.interacter.dataArrayM valueForKey:@"title"]} block:^(NSDictionary *params, NSError *error) {
        [weakSelf reloadPieViewWithDataSource:[params objectForKey:@"selectedMeal"]];
    }];
    [self goVC:vc];
}

@end
