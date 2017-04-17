//
//  TNAOrgnizationViewModel.m
//  Toon
//
//  Created by joymake on 16/6/20.
//  Copyright © 2016年 Joymake. All rights reserved.
//

#import "LWCompanyManageInteractor.h"
#import <JoyTool.h>
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

    JoyImageCellBaseModel *cellModel = [[JoyImageCellBaseModel alloc]init];
    cellModel.title =@"工作伙伴";
    cellModel.placeHolderImageStr =@"poker";
    cellModel.cellName =@"JoyLeftIconCell";
    cellModel.bundleName = JoyToolBundle;
    cellModel.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cellModel.viewShape = EImageTypeSquare;
    [workArrayM addObject:cellModel];
    
    JoyImageCellBaseModel *workGrooup = [[JoyImageCellBaseModel alloc]init];
    workGrooup.title =@"讨论组";
    workGrooup.placeHolderImageStr =@"poker";
    workGrooup.cellName =@"JoyLeftIconCell";
    workGrooup.bundleName = JoyToolBundle;
    workGrooup.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    workGrooup.viewShape = EImageTypeSquare;
    [workArrayM addObject:workGrooup];
    
    JoyImageCellBaseModel *infoModel = [[JoyImageCellBaseModel alloc]init];
    infoModel.title =@"个人信息管理";
    infoModel.placeHolderImageStr =@"poker";
    infoModel.cellName =@"JoyLeftIconCell";
    infoModel.bundleName = JoyToolBundle;
    infoModel.tapAction = @"goColorTable";
    infoModel.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    infoModel.viewShape = EImageTypeSquare;
    [workArrayM addObject:infoModel];

    JoySectionBaseModel *staffSectionModel = [JoySectionBaseModel sectionWithHeaderModel:nil footerModel:nil cellModels:workArrayM sectionH:KHeadSectionH sectionTitle:nil];
    [self.easyWorkArrayM addObject:staffSectionModel];
}

- (void)getCompanyManageSource{
    [self.enterpriseCultureArrayM removeAllObjects];
    NSMutableArray * arrayM = [NSMutableArray arrayWithCapacity:0];
    JoyImageCellBaseModel *cellModel = [[JoyImageCellBaseModel alloc]init];
    cellModel.title =@"照片墙";
    cellModel.placeHolderImageStr =@"poker";
    cellModel.cellName =@"JoyLeftIconCell";
    cellModel.bundleName = JoyToolBundle;
    cellModel.accessoryType =  UITableViewCellAccessoryDisclosureIndicator;
    cellModel.viewShape = EImageTypeSquare;
    [arrayM addObject:cellModel];
    
    JoyImageCellBaseModel *activityModel = [[JoyImageCellBaseModel alloc]init];
    activityModel.title =@"活动";
    activityModel.placeHolderImageStr =@"poker";
    activityModel.cellName =@"JoyLeftIconCell";
    activityModel.bundleName = JoyToolBundle;
    activityModel.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    activityModel.viewShape = EImageTypeSquare;
    [arrayM addObject:activityModel];

    JoyImageCellBaseModel *newsModel = [[JoyImageCellBaseModel alloc]init];
    newsModel.title =@"新闻";
    newsModel.placeHolderImageStr =@"poker";
    newsModel.cellName =@"JoyLeftIconCell";
    newsModel.bundleName = JoyToolBundle;
    newsModel.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    newsModel.viewShape = EImageTypeSquare;
    [arrayM addObject:newsModel];

    JoyImageCellBaseModel *happyModel = [[JoyImageCellBaseModel alloc]init];
    happyModel.title =@"开心一刻";
    happyModel.placeHolderImageStr =@"happy";
    happyModel.cellName =@"JoyLeftIconCell";
    happyModel.bundleName = JoyToolBundle;
    happyModel.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    happyModel.viewShape = EImageTypeSquare;
    [arrayM addObject:happyModel];
    
    JoyImageCellBaseModel *spitslotModel = [[JoyImageCellBaseModel alloc]init];
    spitslotModel.title =@"吐槽一下";
    spitslotModel.placeHolderImageStr =@"happy";
    spitslotModel.cellName =@"JoyLeftIconCell";
    spitslotModel.bundleName = JoyToolBundle;
    spitslotModel.tapAction = @"goSpitslot";
    spitslotModel.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    spitslotModel.viewShape = EImageTypeSquare;
    [arrayM addObject:spitslotModel];
    
    JoySectionBaseModel *companySectionModel = [JoySectionBaseModel sectionWithHeaderModel:nil footerModel:nil cellModels:arrayM sectionH:KHeadSectionH sectionTitle:nil];

    [self.enterpriseCultureArrayM addObject:companySectionModel];
}

- (void)getAppManageSource{
    [self.restArrayM removeAllObjects];
    NSMutableArray * arrayM = [NSMutableArray arrayWithCapacity:0];

    JoyImageCellBaseModel *cellModel = [[JoyImageCellBaseModel alloc]init];
    cellModel.title =@"扔骰子";
    cellModel.placeHolderImageStr =@"eat";
    cellModel.cellName =@"JoyLeftIconCell";
    cellModel.bundleName = JoyToolBundle;
    cellModel.accessoryType =  UITableViewCellAccessoryDisclosureIndicator;
    cellModel.viewShape = EImageTypeSquare;
    cellModel.tapAction = @"goPlayBambooVC";
    [arrayM addObject:cellModel];
    
    JoyImageCellBaseModel *eatModel = [[JoyImageCellBaseModel alloc]init];
    eatModel.title =@"今天吃什么";
    eatModel.placeHolderImageStr =@"poker";
    eatModel.cellName =@"JoyLeftIconCell";
    eatModel.bundleName = JoyToolBundle;
    eatModel.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    eatModel.viewShape = EImageTypeSquare;
    eatModel.tapAction = @"goEatVC";
    [arrayM addObject:eatModel];
    
    JoyImageCellBaseModel *pokerModel = [[JoyImageCellBaseModel alloc]init];
    pokerModel.title =@"斗地主";
    pokerModel.placeHolderImageStr =@"poker";
    pokerModel.cellName =@"JoyLeftIconCell";
    pokerModel.bundleName = JoyToolBundle;
    pokerModel.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    pokerModel.viewShape = EImageTypeSquare;
    [arrayM addObject:pokerModel];

    JoySectionBaseModel *staffSectionModel = [JoySectionBaseModel sectionWithHeaderModel:nil footerModel:nil cellModels:arrayM sectionH:KHeadSectionH sectionTitle:nil];
   
    JoyCellBaseModel *reCommentCellModel = [[JoyCellBaseModel alloc]init];
    reCommentCellModel.title =@"勾搭一下";
    reCommentCellModel.cellName =@"LWSingleLabelCell";
    JoySectionBaseModel *reCommentSectionModel = [JoySectionBaseModel sectionWithHeaderModel:nil footerModel:nil cellModels:@[reCommentCellModel] sectionH:KHeadSectionH sectionTitle:nil];
    
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
