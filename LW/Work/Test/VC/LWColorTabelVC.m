//
//  LWColorTabelVC.m
//  LW
//
//  Created by Joymake on 2016/11/9.
//  Copyright © 2016年 joymake. All rights reserved.
//

#import "LWColorTabelVC.h"
#import <JoyTableAutoLayoutView.h>
#import "LWColorTableInteracter.h"
#import "LWColorTablePresenter.h"

@interface LWColorTabelVC ()
@property (nonatomic, strong) JoyTableAutoLayoutView     *colorView;
@property (nonatomic, strong) LWColorTableInteracter    *interacter;
@property (nonatomic, strong) LWColorTablePresenter     *presenter;

@end

@implementation LWColorTabelVC

-(JoyTableAutoLayoutView *)colorView{
    return _colorView = _colorView?:[[JoyTableAutoLayoutView alloc]initWithFrame:CGRectZero];
}

-(LWColorTableInteracter *)interacter{
    return _interacter = _interacter?:[[LWColorTableInteracter alloc]init];
}

-(LWColorTablePresenter *)presenter{
    if (!_presenter) {
        _presenter = [[LWColorTablePresenter alloc]initWithView:self.view];
        _presenter.interacter = self.interacter;
        _presenter.colorView = self.colorView;
    }
    return _presenter;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setDefaultConstraintWithView:self.colorView andTitle:@"多彩程序🐒"];
    [self.presenter reloadDataSource];
}

@end
