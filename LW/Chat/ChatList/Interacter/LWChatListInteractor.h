//
//  LWChatListInteractor.h
//  LW
//
//  Created by joymake on 2017/2/14.
//  Copyright © 2017年 joymake. All rights reserved.
//

#import "JoyInteractorBase.h"

@interface LWChatListInteractor : JoyInteractorBase
@property (nonatomic,strong)NSMutableArray *dataArrayM;

- (void)getChatListInfo:(VOIDBLOCK)block;
@end
