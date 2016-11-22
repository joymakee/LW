//
//  WhatWeEatTodayVC.m
//  LW
//
//  Created by wangguopeng on 2016/11/18.
//  Copyright © 2016年 joymake. All rights reserved.
//

#import "WhatWeEatTodayVC.h"
#import "PieView.h"         //转盘
#import "FeatherView.h"     //指针
#import "MealModel.h"       //转盘上的每一个菜单模型
#import "WhatWeEatTodayInteracter.h"    //数据处理源
#import "BackGroundBlurView.h"          //模糊背景
#import "LWTableAutoLayoutView.h"       //弹出的table
#import "LWTableSectionBaseModel.h"     //table的section模型
#import "CustomMealInteracter.h"        //table的cell模型
#import "CAAnimation+HCAnimation.h"

@interface WhatWeEatTodayVC ()<CAAnimationDelegate>{
    CGFloat _roatedValue ;
}
@property (nonatomic,strong)CABasicAnimation *transformAnimation;   //旋转动画
@property (weak, nonatomic) IBOutlet BackGroundBlurView *blurView;
@property (nonatomic,strong)IBOutlet PieView *pie;   //转盘

@property (weak, nonatomic) IBOutlet FeatherView *featherView;

@property (nonatomic,strong)WhatWeEatTodayInteracter *interacter;

@property (nonatomic, strong) LWTableAutoLayoutView  *customMealView;

@property (nonatomic,strong)CustomMealInteracter *customMealInteracter;
@end

@implementation WhatWeEatTodayVC

#pragma mark lazyload method

-(LWTableAutoLayoutView *)customMealView{
    return _customMealView = _customMealView?:[[LWTableAutoLayoutView alloc]initWithFrame:CGRectZero];
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

#pragma mark life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"吃饭选择困难户";
    [self setRightNavItemWithTitle:@"自定义菜单"];
    [self.featherView setFrame:CGRectMake(0, 0, SCREEN_W-20, SCREEN_W-20)];
    self.featherView.center = self.view.center;
    [self.pie setFrame:self.featherView.frame];

    [self reloadPieViewWithDataSource:@[@{@"宫保鸡丁":@1},@{@"西红柿炒鸡蛋":@1},@{@"干锅菜花":@1},@{@"鱼香肉丝":@1},@{@"麻辣香锅":@1},@{@"烩虾仁儿":@1},@{@"炸子蟹":@2},@{@"毛血旺":@1},@{@"麻婆豆腐":@1}]];
    [self.blurView setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle]
                                                              pathForResource:@"shuye"
                                                              ofType:@"jpg"]] andBlur:1];


    __weak __typeof (&*self)weakSelf = self;
    [self.featherView drawFeatherViewTouchBlock:^{[weakSelf roate];}];
    [self.view addSubview:self.customMealView];

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
    __weak __typeof (&*self)weakSelf = self;
    [self.interacter.dataArrayM enumerateObjectsUsingBlock:^(MealModel *model, NSUInteger idx, BOOL * _Nonnull stop) {
        totalValue += model.mealRadius;
        if (2*M_PI * totalValue/weakSelf.self.interacter.totalRadious + _roatedValue>=2*M_PI)
        {
        MealModel *model = weakSelf.pie.dataArrayM[idx];
        NSLog(@"你选中了%@",model.title);
        *stop = YES;
        }
    }];
}

static BOOL isSaved = NO;

-(void)rightNavItemClickAction{
    [super rightNavItemClickAction];
    isSaved?[self saveCustomMealAndReloadPie]:[self showCustomTable];
    [self.customMealView setFrame:CGRectMake(0, 0, SCREEN_W, isSaved?0:SCREEN_H)];
    [CAAnimation showScaleAnimationInView:self.customMealView
                                fromValue:isSaved?1:0
                               ScaleValue:isSaved?0:1
                                   Repeat:1
                                 Duration:0.8
                             autoreverses:NO];
    isSaved = !isSaved;
    [self setRightNavItemWithTitle:isSaved?@"保存":@"自定义菜单"];
}

- (void)saveCustomMealAndReloadPie{
    if (!self.customMealView.dataArrayM.count) return;
    __weak __typeof (&*self)weakSelf = self;
    __block NSMutableArray *array = [NSMutableArray array];
    LWTableSectionBaseModel *sectionModel = self.customMealView.dataArrayM[0];
    [sectionModel.rowArrayM enumerateObjectsUsingBlock:^(LWCellBaseTextModel   *obj, NSUInteger idx, BOOL * _Nonnull stop) {
    obj.title.length?[array addObject:@{obj.title:@1}]:nil;
    }];
    array.count?[weakSelf reloadPieViewWithDataSource:array]:nil;

}

- (void)showCustomTable{
    [self.customMealInteracter getViewDataSourceWithDataSource:self.interacter.dataArrayM];
    self.customMealView.dataArrayM = self.customMealInteracter.dataArrayM;
    [self.customMealView reloadTableView];
}

@end
