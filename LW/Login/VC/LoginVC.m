//
//  LoginVC.m
//  LW
//
//  Created by Joymake on 16/6/24.
//  Copyright © 2016年 joymake. All rights reserved.
//

#import "LoginVC.h"
#import "LoginPresenter.h"
#import "LoginInteracter.h"
#import <JoyTableAutoLayoutView.h>
#import "BackGroundBlurView.h"

@interface LoginVC ()
@property (nonatomic,strong)JoyTableAutoLayoutView *loginView;
@property (nonatomic,strong)UIView *copyrightView;
@property (nonatomic,strong)LoginInteracter *interactor;
@property (nonatomic,strong)LoginPresenter *presenter;

@end

@implementation LoginVC

#pragma mark get method
-(LoginInteracter *)interactor{
    return _interactor = _interactor?:[[LoginInteracter alloc]init];
}

-(LoginPresenter *)presenter{
    if (!_presenter) {
    _presenter = [[LoginPresenter alloc]initWithView:self.view];
    _presenter.interactor = self.interactor;
    _presenter.loginView = self.loginView;
    }
    return  _presenter;
}

-(JoyTableAutoLayoutView *)loginView{
    if (!_loginView) {
    _loginView = [[JoyTableAutoLayoutView alloc]init];
    BackGroundBlurView *backView = [[BackGroundBlurView alloc]init];
    [backView setImage:[UIImage imageNamed:@"loginBack.jpg"] andBlur:1];
    _loginView.backView = backView;
    _loginView.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
     return _loginView;
}

-(UIView *)copyrightView{
    return _copyrightView = _copyrightView?:[[[NSBundle mainBundle] loadNibNamed:@"LWCopyRightView" owner:self options:nil] lastObject];
}

#pragma mark 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setDefaultConstraintWithView:self.loginView andTitle:nil];
    [self.view addSubview:self.copyrightView];
    [self.presenter reloadDataSource];
}

#pragma mark 约束
-(void)updateViewConstraints{
    [super updateViewConstraints];
    __weak __typeof (&*self)weakSelf = self;
    [self.copyrightView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.bottom.equalTo(weakSelf.view.mas_bottom).offset(20);
    make.leading.equalTo(weakSelf.view.mas_leading);
    make.trailing.equalTo(weakSelf.view.mas_trailing);
    make.height.equalTo(@(60));
    }];
}

@end
