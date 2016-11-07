//
//  LWMediaModel.h
//  LW
//
//  Created by joymake on 16/7/4.
//  Copyright © 2016年 joymake. All rights reserved.
//

#import "LWCellBaseModel.h"

@interface LWMediaModel : LWCellBaseModel
@property (nonatomic,assign)NSInteger playCount;
@property (nonatomic,copy)NSString    *dateStr;
@property (nonatomic,copy)NSString    *mediaUrlStr;

@end
