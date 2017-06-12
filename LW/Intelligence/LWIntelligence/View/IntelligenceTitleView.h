//
//  IntelligenceTitleView.h
//  LW
//
//  Created by wangguopeng on 2017/6/8.
//  Copyright © 2017年 joymake. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LWImageView.h"
@class LWWeatherModel;
@interface IntelligenceTitleView : UIView
- (void)setWeatherModel:(LWWeatherModel *)weather;
@property (nonatomic,copy)LWImageTouchBlock touchBlock;
@end
