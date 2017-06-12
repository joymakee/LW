//
//  JoyLocationManager.h
//  LW
//
//  Created by wangguopeng on 2017/6/9.
//  Copyright © 2017年 joymake. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JoyLocationManager : NSObject
//检测授权并设置更新模式
@property (nonatomic,readonly)JoyLocationManager        *(^checkAuthorization)(BOOL backGroundModel);
@property (nonatomic,readonly)JoyLocationManager        *(^startLocation)();
@property (nonatomic,readonly)JoyLocationManager        *(^stopLocation)();
@property (nonatomic,copy)JoyLocationManager            *(^locationSuccess)(IDBLOCK block);
@property (nonatomic,copy)JoyLocationManager            *(^locationError)(ERRORBLOCK block);
@property (nonatomic,copy)JoyLocationManager            *(^reverseGEOCodeLocation)(IDBLOCK block);

@property (nonatomic,readonly)JoyLocationManager        *(^startUpdateHeading)();
@property (nonatomic,copy)JoyLocationManager            *(^headUpdateSuccess)(FLOATBLOCK block);
@property (nonatomic,readonly)JoyLocationManager        *(^stopUpdateHeading)();
@end
