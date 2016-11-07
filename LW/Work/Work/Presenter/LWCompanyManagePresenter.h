//
//  LWCompanyManagePresenter.h
//  LW
//
//  Created by Joymake on 2016/10/27.
//  Copyright © 2016年 joymake. All rights reserved.
//

#import "BasePresentor.h"

@class LWTableAutoLayoutView,UISegementView,LWCompanyManageInteractor;
@interface LWCompanyManagePresenter : BasePresentor
@property (nonatomic, strong) LWTableAutoLayoutView *staffManageView;
@property (nonatomic,strong)UISegementView *segmentView;
@property (nonatomic,strong)LWCompanyManageInteractor *interactor;
@end
