//
//  CommentViewModel.h
//  LW
//
//  Created by joymake on 16/6/30.
//  Copyright © 2016年 joymake. All rights reserved.
//

#import "JoyInteractorBase.h"
@interface CommentInteractor : JoyInteractorBase
@property (nonatomic,strong)NSMutableArray *dataArrayM;

- (void)getCommentViewDataSource:(VOIDBLOCK)successed;

@end
