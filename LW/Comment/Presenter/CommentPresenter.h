//
//  CommentPresenter.h
//  LW
//
//  Created by joymake on 2016/10/27.
//  Copyright © 2016年 joymake. All rights reserved.
//

#import "BasePresentor.h"

@class JoyTableAutoLayoutView;
@class CommentInteractor;
@interface CommentPresenter : BasePresentor
@property (nonatomic,strong)JoyTableAutoLayoutView *commentView;
@property (nonatomic,strong)CommentInteractor *interactor;
@end
