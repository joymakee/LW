//
//  LWChatListPresenter.h
//  LW
//
//  Created by joymake on 2017/2/14.
//  Copyright © 2017年 joymake. All rights reserved.
//

#import "LWChatListPresenter.h"
#import <JoyKit/JoyPresenterBase.h>

@class LWChatListInteractor;
@class JoyTableAutoLayoutView;
@interface LWChatListPresenter : JoyPresenterBase
@property (nonatomic,strong)LWChatListInteractor *chatInteractor;
@property (nonatomic,strong)JoyTableAutoLayoutView *chatView;

@end
