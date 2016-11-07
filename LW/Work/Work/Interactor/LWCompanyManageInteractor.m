//
//  TNAOrgnizationViewModel.m
//  Toon
//
//  Created by joymake on 16/6/20.
//  Copyright © 2016年 Joymake. All rights reserved.
//

#define KHeadSectionH 15
#define KNormalSectionH 40

#import "LWCompanyManageInteractor.h"
#import "LWTableSectionBaseModel.h"
#import "LWCellBaseModel.h"
@implementation LWCompanyManageInteractor
#pragma mark 员工更多信息数据

- (void)getWorkDataSource{
    [self getStaffManageViewModel];
    [self getCompanyManageSource];
    [self getAppManageSource];
}

- (void)getStaffManageViewModel{
    [self.easyWorkArrayM removeAllObjects];
    NSMutableArray * workArrayM = [NSMutableArray arrayWithCapacity:0];

    LWCellBaseImageModel *cellModel = [[LWCellBaseImageModel alloc]init];
    cellModel.title =@"工作伙伴";
    cellModel.placeHolderImageStr =@"poker";
    cellModel.cellName =@"LWLeftIconCell";
    cellModel.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cellModel.viewShape = EImageTypeSquare;
    [workArrayM addObject:cellModel];
    
    LWCellBaseImageModel *workGrooup = [[LWCellBaseImageModel alloc]init];
    workGrooup.title =@"讨论组";
    workGrooup.placeHolderImageStr =@"poker";
    workGrooup.cellName =@"LWLeftIconCell";
    workGrooup.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    workGrooup.viewShape = EImageTypeSquare;
    [workArrayM addObject:workGrooup];
    
    LWCellBaseImageModel *infoModel = [[LWCellBaseImageModel alloc]init];
    infoModel.title =@"个人信息管理";
    infoModel.placeHolderImageStr =@"poker";
    infoModel.cellName =@"LWLeftIconCell";
    infoModel.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    infoModel.viewShape = EImageTypeSquare;
    [workArrayM addObject:infoModel];

    LWTableSectionBaseModel *staffSectionModel = [LWTableSectionBaseModel sectionWithHeaderModel:nil footerModel:nil cellModels:workArrayM sectionH:KHeadSectionH sectionTitle:nil];
    [self.easyWorkArrayM addObject:staffSectionModel];
}

- (void)getCompanyManageSource{
    [self.enterpriseCultureArrayM removeAllObjects];
    NSMutableArray * arrayM = [NSMutableArray arrayWithCapacity:0];
    LWCellBaseImageModel *cellModel = [[LWCellBaseImageModel alloc]init];
    cellModel.title =@"照片墙";
    cellModel.placeHolderImageStr =@"poker";
    cellModel.cellName =@"LWLeftIconCell";
    cellModel.accessoryType =  UITableViewCellAccessoryDisclosureIndicator;
    cellModel.viewShape = EImageTypeSquare;
    [arrayM addObject:cellModel];
    
    LWCellBaseImageModel *activityModel = [[LWCellBaseImageModel alloc]init];
    activityModel.title =@"活动";
    activityModel.placeHolderImageStr =@"poker";
    activityModel.cellName =@"LWLeftIconCell";
    activityModel.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    activityModel.viewShape = EImageTypeSquare;
    [arrayM addObject:activityModel];

    LWCellBaseImageModel *newsModel = [[LWCellBaseImageModel alloc]init];
    newsModel.title =@"新闻";
    newsModel.placeHolderImageStr =@"poker";
    newsModel.cellName =@"LWLeftIconCell";
    newsModel.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    newsModel.viewShape = EImageTypeSquare;
    [arrayM addObject:newsModel];

    LWCellBaseImageModel *happyModel = [[LWCellBaseImageModel alloc]init];
    happyModel.title =@"开心一刻";
    happyModel.placeHolderImageStr =@"happy";
    happyModel.cellName =@"LWLeftIconCell";
    happyModel.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    happyModel.viewShape = EImageTypeSquare;
    [arrayM addObject:happyModel];

    LWTableSectionBaseModel *companySectionModel = [LWTableSectionBaseModel sectionWithHeaderModel:nil footerModel:nil cellModels:arrayM sectionH:KHeadSectionH sectionTitle:nil];

    [self.enterpriseCultureArrayM addObject:companySectionModel];
}

- (void)getAppManageSource{
    [self.restArrayM removeAllObjects];
    NSMutableArray * arrayM = [NSMutableArray arrayWithCapacity:0];

    LWCellBaseImageModel *cellModel = [[LWCellBaseImageModel alloc]init];
    cellModel.title =@"扔骰子";
    cellModel.placeHolderImageStr =@"eat";
    cellModel.cellName =@"LWLeftIconCell";
    cellModel.accessoryType =  UITableViewCellAccessoryDisclosureIndicator;
    cellModel.viewShape = EImageTypeSquare;
    cellModel.tapAction = @"goPlayBambooVC";
    [arrayM addObject:cellModel];
    
    LWCellBaseImageModel *pokerModel = [[LWCellBaseImageModel alloc]init];
    pokerModel.title =@"斗地主";
    pokerModel.placeHolderImageStr =@"poker";
    pokerModel.cellName =@"LWLeftIconCell";
    pokerModel.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    pokerModel.viewShape = EImageTypeSquare;
    [arrayM addObject:pokerModel];

    LWTableSectionBaseModel *staffSectionModel = [LWTableSectionBaseModel sectionWithHeaderModel:nil footerModel:nil cellModels:arrayM sectionH:KHeadSectionH sectionTitle:nil];
   
    LWCellBaseModel *reCommentCellModel = [[LWCellBaseModel alloc]init];
    reCommentCellModel.title =@"勾搭一下";
    reCommentCellModel.cellName =@"LWSingleLabelCell";
    LWTableSectionBaseModel *reCommentSectionModel = [LWTableSectionBaseModel sectionWithHeaderModel:nil footerModel:nil cellModels:@[reCommentCellModel] sectionH:KHeadSectionH sectionTitle:nil];
    
    [self.restArrayM addObject:staffSectionModel];
    [self.restArrayM addObject:reCommentSectionModel];
}


-(NSMutableArray *)easyWorkArrayM{
    return _easyWorkArrayM = _easyWorkArrayM?:[NSMutableArray arrayWithCapacity:0];
}

-(NSMutableArray *)restArrayM{
    return _restArrayM = _restArrayM?:[NSMutableArray arrayWithCapacity:0];
}

-(NSMutableArray *)enterpriseCultureArrayM{
    return _enterpriseCultureArrayM = _enterpriseCultureArrayM?:[NSMutableArray arrayWithCapacity:0];
}
@end
