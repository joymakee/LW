//
//  LWCompanyManagePresenter.h
//  LW
//
//  Created by Joymake on 2016/10/27.
//  Copyright © 2016年 joymake. All rights reserved.
//

#import "BasePresentor.h"

@class JoyTableAutoLayoutView,JoyUISegementView,LWCompanyManageInteractor;
@interface LWCompanyManagePresenter : BasePresentor
@property (nonatomic, strong) JoyTableAutoLayoutView *staffManageView;
@property (nonatomic,strong)JoyUISegementView *segmentView;
@property (nonatomic,strong)LWCompanyManageInteractor *interactor;
@end
