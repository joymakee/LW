//
//  TNAStaffManageVC.m
//  Toon
//
//  Created by joymake on 16/6/23.
//  Copyright © 2016年 Joymake. All rights reserved.
//

#import "TNACompanyManageVC.h"
#import "LWCompanyManageInteractor.h"
#import "LWTableAutoLayoutView.h"
#import "UISegementView.h"
#import "LWCompanyManagePresenter.h"

@interface TNACompanyManageVC ()
@property (nonatomic, strong) LWTableAutoLayoutView *staffManageView;
@property (nonatomic,strong)UISegementView *segmentView;
@property (nonatomic,strong)LWCompanyManageInteractor *interactor;
@property (nonatomic,strong)LWCompanyManagePresenter *presenter;

@end

@implementation TNACompanyManageVC

-(LWTableAutoLayoutView *)staffManageView{
   return _staffManageView =_staffManageView?:[[LWTableAutoLayoutView alloc] init];
}

-(LWCompanyManageInteractor *)interactor{
    return _interactor = _interactor?:[[LWCompanyManageInteractor alloc]init];
}

-(LWCompanyManagePresenter *)presenter{
    if (!_presenter) {
        _presenter = [[LWCompanyManagePresenter alloc]initWithView:self.view];
        _presenter.interactor = self.interactor;
        _presenter.segmentView = self.segmentView;
        _presenter.staffManageView = self.staffManageView;
    }
    return _presenter;
}

-(UISegementView *)segmentView{
    return  _segmentView = _segmentView?: [[UISegementView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, 40)];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setDefaultConstraintWithView:self.staffManageView andTitle:NSLocalizedString(@"工作", nil)];
    [self.presenter reloadDataSource];
}

@end
