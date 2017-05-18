//
//  PiechartView.h
//  ColorAnimationDemo
//
//  Created by fangbmian on 16/3/28.
//  Copyright (c) 2016年 fangbmian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PiechartView : UIView

-(id)initWithFrame:(CGRect)frame withStrokeWidth:(CGFloat )width andPercent:(CGFloat)percent andAnimation:(BOOL) animation;

@end
