//
//  LWCompanyManagePresenter.m
//  LW
//
//  Created by Joymake on 2016/10/27.
//  Copyright © 2016年 joymake. All rights reserved.
//

#import "LWCompanyManagePresenter.h"
#import "LWTableAutoLayoutView.h"
#import "UISegementView.h"
#import "LWCompanyManageInteractor.h"
#import "LWTableSectionBaseModel.h"
#import "LWCellBaseModel.h"
#import "PlayBambooVC.h"
#import "LWColorTabelVC.h"
#import "WhatWeEatTodayVC.h"

@implementation LWCompanyManagePresenter

-(void)setSegmentView:(UISegementView *)segmentView{
    _segmentView = segmentView;
    _segmentView.segmentItems = @[@"轻松工作",@"企业文化",@"歇一歇"];
    _segmentView.selectColor = [UIColor purpleColor];
    _segmentView.deselectColor = [UIColor lightGrayColor];
    __weak __typeof (&*self)weakSelf = self;
    _segmentView.setmentValuechangedBlock =^(NSInteger selectIndex){
        [weakSelf setMentClickAction:selectIndex];
    };
}

-(void)setStaffManageView:(LWTableAutoLayoutView *)staffManageView{
    _staffManageView = staffManageView;
    [self.staffManageView.tableView setTableHeaderView:self.segmentView];
    __weak __typeof (&*self)weakSelf = self;
    staffManageView.tableDidSelectBlock = ^(NSIndexPath *indexPath){
        [weakSelf tableVIewDidSelect:indexPath];
    };
}

-(void)tableVIewDidSelect:(NSIndexPath *)indexPath{
    LWTableSectionBaseModel *sectionModel = [self.staffManageView.dataArrayM objectAtIndex:indexPath.section];
    LWCellBaseModel * selectModel  = sectionModel.rowArrayM[indexPath.row];
    [super performTapAction:selectModel.tapAction];
}

-(void)reloadDataSource{
    [self.interactor getWorkDataSource];
    self.staffManageView.dataArrayM = self.interactor.easyWorkArrayM;
    [self.staffManageView reloadTableView];
}


- (void)setMentClickAction:(NSInteger)selectIndex{
    switch (selectIndex) {
        case 0:
            self.staffManageView.dataArrayM = self.interactor.easyWorkArrayM;
            break;
        case 1:
            self.staffManageView.dataArrayM = self.interactor.enterpriseCultureArrayM;
            break;
        default:
            self.staffManageView.dataArrayM = self.interactor.restArrayM;
            break;
    }
    [self.staffManageView reloadTableView];
}

- (void)goPlayBambooVC{
    PlayBambooVC *eatVC = [[PlayBambooVC alloc]init];
    [self goVC:eatVC];
}

- (void)goEatVC{
    WhatWeEatTodayVC *eatVC = [[WhatWeEatTodayVC alloc]init];
    [self goVC:eatVC];
}
- (void)goColorTable{
    LWColorTabelVC *colorTable = [[LWColorTabelVC alloc]init];
    [self goVC:colorTable];
}
@end
