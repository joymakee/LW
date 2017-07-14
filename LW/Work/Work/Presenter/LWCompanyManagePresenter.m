//
//  LWCompanyManagePresenter.m
//  LW
//
//  Created by Joymake on 2016/10/27.
//  Copyright © 2016年 joymake. All rights reserved.
//

#import "LWCompanyManagePresenter.h"
#import <JoyTableAutoLayoutView.h>
#import <JoyUISegementView.h>
#import "LWCompanyManageInteractor.h"
#import <JoyTool.h>
#import "PlayBambooVC.h"
#import "LWColorTabelVC.h"
#import "WhatWeEatTodayVC.h"
#import "LWCommentVC.h"

@implementation LWCompanyManagePresenter

-(void)setSegmentView:(JoyUISegementView *)segmentView{
    _segmentView = segmentView;
    _segmentView.segmentItems = @[@"休息一下",@"轻松工作",@"企业文化"];
    _segmentView.selectColor = [UIColor purpleColor];
    _segmentView.deselectColor = [UIColor lightGrayColor];
    __weak __typeof (&*self)weakSelf = self;
    _segmentView.setmentValuechangedBlock =^(NSInteger selectIndex){
        [weakSelf setMentClickAction:selectIndex];
    };
}

-(void)tableVIewDidSelect:(NSIndexPath *)indexPath{
    JoySectionBaseModel *sectionModel = [self.staffManageView.dataArrayM objectAtIndex:indexPath.section];
    JoyCellBaseModel * selectModel  = sectionModel.rowArrayM[indexPath.row];
    [super performTapAction:selectModel.tapAction];
}

-(void)reloadDataSource{
    [self.interactor getWorkDataSource];
    __weak __typeof (&*self)weakSelf = self;
    self.staffManageView.setDataSource(self.interactor.restArrayM).reloadTable().setTableHeadView(self.segmentView).cellDidSelect(^(NSIndexPath *indexPath, NSString *tapAction) {
        [weakSelf tableVIewDidSelect:indexPath];
    });
}

- (void)setMentClickAction:(NSInteger)selectIndex{
    switch (selectIndex) {
        case 0:
            self.staffManageView.dataArrayM = self.interactor.restArrayM;
            break;
        case 1:
            self.staffManageView.dataArrayM = self.interactor.easyWorkArrayM;
            break;

        default:
            self.staffManageView.dataArrayM = self.interactor.enterpriseCultureArrayM;
            break;
    }
    self.staffManageView.reloadTable();
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


- (void)goCommentVC{
    LWCommentVC *commentVC = [[LWCommentVC alloc]init];
    [self goVC:commentVC];
}

@end
