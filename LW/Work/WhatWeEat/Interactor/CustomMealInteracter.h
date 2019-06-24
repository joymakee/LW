//
//  CustomMealInteracter.h
//  LW
//
//  Created by joymake on 2016/11/21.
//  Copyright © 2016年 joymake. All rights reserved.
//

#import "JoyInteractorBase.h"

@interface CustomMealInteracter : JoyInteractorBase
@property (nonatomic,strong)NSMutableArray *dataArrayM;

- (void)getViewDataSourceWithDataSource:(NSArray *)dataArrayM;
@end
