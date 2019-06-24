//
//  LWMediaSourcesModel.h
//  LW
//
//  Created by joymake on 16/7/4.
//  Copyright © 2016年 joymake. All rights reserved.
//

#import "JoyInteractorBase.h"

@interface LWMediaInteractor : JoyInteractorBase
@property (nonatomic,strong)NSMutableArray *dataArrayM;
@property (nonatomic,strong)NSMutableArray *joyArrayM;

-(void)getMedisSourcesDataSource:(VOIDBLOCK)successed;

- (void)getJoySuccess:(VOIDBLOCK)success failure:(ERRORBLOCK)failure;
@end
