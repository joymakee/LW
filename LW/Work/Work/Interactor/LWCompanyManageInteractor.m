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
    [self getAppManageSource];
    [self getStaffManageViewModel];
    [self getCompanyManageSource];
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
    cellModel.tapAction = @"goCommentVC";
    [arrayM addObject:cellModel];
 
    JoyImageCellBaseModel *happyModel = [[JoyImageCellBaseModel alloc]init];
    happyModel.title =@"开心一刻";
    happyModel.placeHolderImageStr =@"happy";
    happyModel.cellName =@"JoyLeftIconCell";
    happyModel.bundleName = JoyToolBundle;
    happyModel.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    happyModel.viewShape = EImageTypeSquare;
    [arrayM addObject:happyModel];

    JoySectionBaseModel *companySectionModel = [JoySectionBaseModel sectionWithHeaderModel:nil footerModel:nil cellModels:arrayM sectionH:KHeadSectionH sectionTitle:nil];

    [self.enterpriseCultureArrayM addObject:companySectionModel];
}

- (void)getAppManageSource{
    [self.restArrayM removeAllObjects];
    NSMutableArray * arrayM = [NSMutableArray arrayWithCapacity:0];

    JoyImageCellBaseModel *cellModel = [[JoyImageCellBaseModel alloc]init];
    cellModel.title =@"猜🎲";
    cellModel.placeHolderImageStr =@"eat";
    cellModel.cellName =@"JoyLeftIconCell";
    cellModel.bundleName = JoyToolBundle;
    cellModel.accessoryType =  UITableViewCellAccessoryDisclosureIndicator;
    cellModel.viewShape = EImageTypeSquare;
    cellModel.tapAction = @"goPlayBambooVC";
    [arrayM addObject:cellModel];
    
    JoyImageCellBaseModel *eatModel = [[JoyImageCellBaseModel alloc]init];
    eatModel.title =@"今儿个吃🍜";
    eatModel.placeHolderImageStr =@"poker";
    eatModel.cellName =@"JoyLeftIconCell";
    eatModel.bundleName = JoyToolBundle;
    eatModel.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    eatModel.viewShape = EImageTypeSquare;
    eatModel.tapAction = @"goEatVC";
    [arrayM addObject:eatModel];
    
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
