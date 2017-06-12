//
//  JoyWebLoader.h
//  LW
//
//  Created by wangguopeng on 2017/6/12.
//  Copyright © 2017年 joymake. All rights reserved.
//

#import <JoyTool/JoyTool.h>
#import "JoyWebView.h"

@interface JoyWebLoader : JoyBaseVC
@property (nonatomic,readonly)JoyWebLoader        *(^initUrlStr)(NSString *urlString);
@property (nonatomic,readonly)JoyWebLoader        *(^initUrlType)(JoyUrl_Type urlType);
@property (nonatomic,readonly)JoyWebLoader          *(^startLoad)();

@end
