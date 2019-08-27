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
@property (nonatomic,strong)NSMutableArray *relaxationArrayM;
@property (nonatomic,strong)NSMutableArray *newsArrayM;

-(void)getMedisSourcesDataSource:(VOIDBLOCK)successed;

- (void)getJoySuccess:(VOIDBLOCK)success failure:(ERRORBLOCK)failure;

- (void)getNewsSuccess:(VOIDBLOCK)success failure:(ERRORBLOCK)failure;
@end

@interface LWCustomMediaInteractor : JoyInteractorBase
@property (nonatomic,strong)NSMutableArray *dataArrayM;

@end
