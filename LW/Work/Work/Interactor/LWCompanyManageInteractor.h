//
//  TNAOrgnizationViewModel.h
//  Toon
//
//  Created by joymake on 16/6/20.
//  Copyright © 2016年 Joymake. All rights reserved.
//

#import "JoyInteractorBase.h"

@class JoySectionBaseModel;

@interface LWCompanyManageInteractor : JoyInteractorBase

@property (nonatomic,strong)NSMutableArray <JoySectionBaseModel *>*easyWorkArrayM;

@property (nonatomic,strong)NSMutableArray <JoySectionBaseModel *>* enterpriseCultureArrayM;

@property (nonatomic,strong)NSMutableArray <JoySectionBaseModel *>* restArrayM;

- (void)getWorkDataSource;

@end
