//
//  LWColorTablePresenter.h
//  LW
//
//  Created by Joymake on 2016/11/9.
//  Copyright © 2016年 joymake. All rights reserved.
//

#import "BasePresentor.h"
@class LWTableAutoLayoutView,LWColorTableInteracter;
@interface LWColorTablePresenter : BasePresentor
@property (nonatomic, strong) LWTableAutoLayoutView     *colorView;
@property (nonatomic, strong) LWColorTableInteracter    *interacter;

@end
