//
//  LWChatPresenter.h
//  LW
//
//  Created by joymake on 2017/2/13.
//  Copyright © 2017年 joymake. All rights reserved.
//

#import "LWChatPresenter.h"
#import <JoyKit/JoyKit.h>

@class LWChatInteractor;
@class LWChatView;
@interface LWChatPresenter : JoyPresenterBase
@property (nonatomic,strong)LWChatInteractor *chatInteractor;
@property (nonatomic,strong)LWChatView *chatView;

- (void)getChatInfoAndDisplay:(AlertBlock)alert;

@end
