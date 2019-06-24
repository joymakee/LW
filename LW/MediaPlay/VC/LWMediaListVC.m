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
#import "JoyBaseVC+LWCategory.h"

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
        _segmentView.setSegmentItems(@[@"电视",@"幽默",@"新闻",@"段子",@"游戏"]).setSelectColor([UIColor colorWithRed:0.9 green:0.1 blue:0.2 alpha:0.8]).setDeselectColor([UIColor colorWithRed:0.3 green:0.4 blue:0.6 alpha:0.6]).setBottomSliderColor([UIColor colorWithRed:0.3 green:0.3 blue:0.7 alpha:0.7]);
    }
    return _segmentView;
}

-(JoyWebView *)webView{
    return _webView = _webView?:[[JoyWebView alloc]init];
}

-(JoyTableAutoLayoutView *)mediaListView{
    _mediaListView = _mediaListView?:[[JoyTableAutoLayoutView alloc]init];
    _mediaListView.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _mediaListView.tableView.backgroundColor = [UIColor clearColor];
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
    [self setBackViewWithImageName:nil bundleName:nil];
    self.navigationController.navigationBar.translucent = YES;
    [self.navigationController.navigationBar addSubview:self.segmentView];
    [self.view addSubview:self.mediaListView];
    [self.view addSubview:self.webView];
    [self setConstraint];
    self.navigationController.navigationBar.topItem.titleView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.presenter reloadDataSource];
}

-(void)setConstraint{
    MAS_CONSTRAINT(self.mediaListView,make.edges.mas_equalTo(self.view););
    MAS_CONSTRAINT(self.webView,make.edges.mas_equalTo(self.view););
}

@end
