//
//  LWMediaListVC.m
//  LW
//
//  Created by joymake on 16/7/4.
//  Copyright © 2016年 joymake. All rights reserved.
//

#import "LWMediaListVC.h"
#import "LWMediaInteractor.h"
#import "LWMediaPresenter.h"
#import <JoyTableAutoLayoutView.h>
#import <JoyUISegementView.h>
#import <WebKit/WebKit.h>
#import "JoyWebView.h"
@interface LWMediaListVC ()
@property (nonatomic,strong)JoyTableAutoLayoutView *mediaListView;
@property (nonatomic,strong)JoyUISegementView *segmentView;
@property (nonatomic,strong)LWMediaInteractor *interactor;
@property (nonatomic,strong)LWMediaPresenter *presenter;
@property (nonatomic,strong)JoyWebView *webView;
@end

@implementation LWMediaListVC
-(JoyUISegementView *)segmentView{
    if (!_segmentView) {
        _segmentView = [[JoyUISegementView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, 40)];
        _segmentView.segmentItems = @[@"电视",@"新闻",@"段子",@"游戏"];
        _segmentView.selectColor = [UIColor colorWithRed:0.9 green:0.1 blue:0.2 alpha:0.8];
        _segmentView.deselectColor = [UIColor colorWithRed:0.3 green:0.4 blue:0.6 alpha:0.6];
        _segmentView.bottomSliderColor = [UIColor colorWithRed:0.3 green:0.3 blue:0.7 alpha:0.7];
//        _segmentView.backgroundColor = JOY_clearColor;
    }
    return _segmentView;
}

-(JoyWebView *)webView{
    return _webView = _webView?:[[JoyWebView alloc]init];
}

-(JoyTableAutoLayoutView *)mediaListView{
    _mediaListView = _mediaListView?:[[JoyTableAutoLayoutView alloc]init];
    _mediaListView.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
//    _mediaListView.tableView.tableHeaderView = self.segmentView;
    return _mediaListView;
}

-(LWMediaInteractor *)interactor{
    return _interactor = _interactor?:[[LWMediaInteractor alloc]init];
}

-(LWMediaPresenter *)presenter{
    if (!_presenter) {
        _presenter = [[LWMediaPresenter alloc]initWithView:self.view];
        _presenter.segmentView = self.segmentView;
        _presenter.mediaListView = self.mediaListView;
        _presenter.webView = self.webView;
        _presenter.interactor = self.interactor;
    }
    return _presenter;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeAll;
    [self.navigationController.navigationBar addSubview:self.segmentView];
    [self.view addSubview:self.mediaListView];
    [self.view addSubview:self.webView];
    [self setConstraint];
    self.navigationController.navigationBar.topItem.titleView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.presenter reloadDataSource];
}

-(void)setConstraint{
    __weak __typeof (&*self)weakSelf = self;
    MAS_CONSTRAINT(self.mediaListView, make.leading.mas_equalTo(weakSelf.view);
                   make.trailing.mas_equalTo(weakSelf.view);
                   make.bottom.mas_equalTo(weakSelf.view);
                   make.top.mas_equalTo(weakSelf.view).mas_offset(20););
    
    MAS_CONSTRAINT(self.webView, make.leading.mas_equalTo(weakSelf.view);
                   make.trailing.mas_equalTo(weakSelf.view);
                   make.bottom.mas_equalTo(weakSelf.view);
                   make.top.mas_equalTo(weakSelf.view).mas_offset(20););
    [self.view updateConstraintsIfNeeded];
}

@end
