//
//  LWMediaModel.h
//  LW
//
//  Created by joymake on 16/7/4.
//  Copyright © 2016年 joymake. All rights reserved.
//

#import <JoyTool.h>

@interface LWMediaModel : JoyCellBaseModel
@property (nonatomic,assign)NSInteger playCount;
@property (nonatomic,copy)NSString    *dateStr;
@property (nonatomic,copy)NSString    *mediaUrlStr;

@end
