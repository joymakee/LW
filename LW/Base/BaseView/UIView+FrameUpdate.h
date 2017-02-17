//
//  UIView+FrameUpdate.h
//  LW
//
//  Created by wangguopeng on 2017/2/16.
//  Copyright © 2017年 joymake. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (FrameUpdate)

#pragma mark frame update
- (void)setViewX:(CGFloat)x Y:(CGFloat)y Width:(CGFloat)width Height:(CGFloat)height;

- (void)setViewX:(CGFloat)x;
- (void)setViewY:(CGFloat)y;
- (void)setViewX:(CGFloat)x Y:(CGFloat)y;
- (void)setViewOrigin:(CGPoint)origin;

- (void)setViewWidth:(CGFloat)width;
- (void)setViewHeight:(CGFloat)height;
- (void)setViewWidth:(CGFloat)width Height:(CGFloat)height;
- (void)setViewSize:(CGSize)size;

- (void)changeViewX:(CGFloat)x;
- (void)changeViewY:(CGFloat)y;
- (void)changeViewX:(CGFloat)x Y:(CGFloat)y;

- (void)changeViewWidth:(CGFloat)width;
- (void)changeViewHeight:(CGFloat)height;
- (void)changeViewWidth:(CGFloat)width Height:(CGFloat)height;

#pragma mark positionCenter update
- (void)setViewCenterX:(CGFloat)x Y:(CGFloat)y;
- (void)setViewCenterX:(CGFloat)x;
- (void)setViewCenterY:(CGFloat)y;
- (void)setViewCenter:(CGPoint)center;
- (void)changeViewCenterX:(CGFloat)x;
- (void)changeViewCenterY:(CGFloat)y;

@end
