//
//  LWTempratureInteractor.h
//  LW
//
//  Created by wangguopeng on 2017/5/23.
//  Copyright © 2017年 joymake. All rights reserved.
//

#import <JoyTool/JoyTool.h>

@interface LWTempratureInteractor : JoyInteractorBase
@property (nonatomic,strong)NSMutableArray *dataArrayM;
- (void)getTempratureDataSource:(VOIDBLOCK)success;
@end
