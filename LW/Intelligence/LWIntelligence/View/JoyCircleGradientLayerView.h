//
//  JoyCircleGradientLayerView.h
//  LW
//
//  Created by wangguopeng on 2017/5/19.
//  Copyright © 2017年 joymake. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JoyCircleGradientLayerView : UIView
@property (nonatomic) CGFloat persentShow;
- (void)setParameterWithStrokeWidth:(CGFloat )width
                         andPercent:(CGFloat)percent
                       andAnimation:(BOOL)animation;
@end
