//
//  LWNewsModel.h
//  LW
//
//  Created by Joymake on 2019/7/5.
//  Copyright © 2019 joymake. All rights reserved.
//

#import "JoyCellBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface LWNewsModel : JoyImageCellBaseModel
@property (nonatomic,copy)NSString *date;
@property (nonatomic,copy)NSString *url;
@end

NS_ASSUME_NONNULL_END
