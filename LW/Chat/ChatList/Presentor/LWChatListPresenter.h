//
//  LWChatListPresenter.h
//  LW
//
//  Created by wangguopeng on 2017/2/14.
//  Copyright © 2017年 joymake. All rights reserved.
//

#import "BasePresentor.h"

@class LWChatListInteractor;
@class LWTableAutoLayoutView;
@interface LWChatListPresenter : BasePresentor
@property (nonatomic,strong)LWChatListInteractor *chatInteractor;
@property (nonatomic,strong)LWTableAutoLayoutView *chatView;

@end
