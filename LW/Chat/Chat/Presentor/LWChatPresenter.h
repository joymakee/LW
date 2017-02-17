//
//  LWChatPresenter.h
//  LW
//
//  Created by wangguopeng on 2017/2/13.
//  Copyright © 2017年 joymake. All rights reserved.
//

#import "BasePresentor.h"

@class LWChatInteractor;
@class LWChatView;
@interface LWChatPresenter : BasePresentor
@property (nonatomic,strong)LWChatInteractor *chatInteractor;
@property (nonatomic,strong)LWChatView *chatView;

- (void)getChatInfoAndDisplay;

@end
