//
//  LWColorTablePresenter.m
//  LW
//
//  Created by Joymake on 2016/11/9.
//  Copyright © 2016年 joymake. All rights reserved.
//

#import "LWColorTablePresenter.h"
#import <JoyTableAutoLayoutView.h>
#import "LWColorTableInteracter.h"

@implementation LWColorTablePresenter
-(void)reloadDataSource{
    [self.interacter getViewDataSource];
    self.colorView.dataArrayM = self.interacter.dataArrayM;
    [self.colorView reloadTableView];
}
@end
