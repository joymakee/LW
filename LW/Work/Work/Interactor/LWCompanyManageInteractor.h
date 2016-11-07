//
//  TNAOrgnizationViewModel.h
//  Toon
//
//  Created by joymake on 16/6/20.
//  Copyright © 2016年 Joymake. All rights reserved.
//

#import "BaseInteractor.h"

@class LWTableSectionBaseModel;

@interface LWCompanyManageInteractor : BaseInteractor

@property (nonatomic,strong)NSMutableArray <LWTableSectionBaseModel *>*easyWorkArrayM;

@property (nonatomic,strong)NSMutableArray <LWTableSectionBaseModel *>* enterpriseCultureArrayM;

@property (nonatomic,strong)NSMutableArray <LWTableSectionBaseModel *>* restArrayM;

- (void)getWorkDataSource;

@end
