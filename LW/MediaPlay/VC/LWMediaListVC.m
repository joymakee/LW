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
#import "JoyBaseVC+LWCategory.h"

@interface LWMediaListVC ()
@property (nonatomic,strong)JoyTableAutoLayoutView *mediaListView;
@property (nonatomic,strong)JoyUISegementView *segmentView;
@property (nonatomic,strong)LWMediaInteractor *interactor;
@property (nonatomic,strong)LWMediaPresenter *presenter;
@end

@implementation LWMediaListVC
-(JoyUISegementView *)segmentView{
    if (!_segmentView) {
        _segmentView = [[JoyUISegementView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, 40)];
        _segmentView.setSegmentItems(@[@"电视",@"每日一笑",@"休闲",@"新闻",@""]).setSelectColor([UIColor whiteColor]).setDeselectColor([UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:0.8]).setBottomSliderColor([UIColor colorWithRed:0.3 green:0.3 blue:0.7 alpha:0.7]);
    }
    return _segmentView;
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
        _presenter.interactor = self.interactor;
    }
    return _presenter;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setBackViewWithImageName:nil bundleName:nil];
    [self.view addSubview:self.segmentView];
    [self.view addSubview:self.mediaListView];
    [self setConstraint];
    [self.presenter reloadDataSource];
}

-(void)setConstraint{
    MAS_CONSTRAINT(self.mediaListView,make.leading.trailing.bottom.mas_equalTo(self.view);
                   make.top.mas_equalTo(self.segmentView.mas_bottom););
    MAS_CONSTRAINT(self.segmentView,make.leading.trailing.mas_equalTo(self.view);
                   make.top.mas_equalTo(KStatusBarHeight);
                   make.height.mas_equalTo(40););

}

@end
