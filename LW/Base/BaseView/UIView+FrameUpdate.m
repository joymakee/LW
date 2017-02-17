//
//  UIView+FrameUpdate.m
//  LW
//
//  Created by wangguopeng on 2017/2/16.
//  Copyright © 2017年 joymake. All rights reserved.
//

#import "UIView+FrameUpdate.h"

#define NOTSET(X) ((X != MAXFLOAT) ||(!X))
@implementation UIView (FrameUpdate)
- (void)setViewX:(CGFloat)x  Y:(CGFloat)y Width:(CGFloat)width Height:(CGFloat)height
{
    
    CGRect viewFrame = self.frame;
    if (NOTSET(x)) {
        
        viewFrame.origin.x = x;
    }
    if (NOTSET(y)) {
        
        viewFrame.origin.y = y;
    }
    if (NOTSET(width)) {
        
        viewFrame.size.width = width;
    }
    if (NOTSET(height)) {
        
        viewFrame.size.height = height;
    }
    self.frame = viewFrame;
}

- (void)setViewX:(CGFloat)x
{
    [self setViewX:x Y:KZERO Width:KZERO Height:KZERO];
}

- (void)setViewY:(CGFloat)y
{
    [self setViewX:KZERO Y:y Width:KZERO Height:KZERO];
}

- (void)setViewX:(CGFloat)x Y:(CGFloat)y
{
    [self setViewX:x Y:y Width:KZERO Height:KZERO];
}

- (void)setViewOrigin:(CGPoint)origin
{
    [self setViewX:origin.x Y:origin.y];
}

- (void)setViewWidth:(CGFloat)width
{
    [self setViewX:KZERO Y:KZERO Width:width Height:KZERO];
}

- (void)setViewHeight:(CGFloat)height
{
    [self setViewX:KZERO Y:KZERO Width:KZERO Height:height];
}

- (void)setViewWidth:(CGFloat)width Height:(CGFloat)height
{
    [self setViewX:KZERO Y:KZERO Width:width Height:height];
}

- (void)setViewSize:(CGSize)size
{
    [self setViewWidth:size.width Height:size.height];
}

- (void)changeViewX:(CGFloat)x
{
    CGFloat viewX = self.frame.origin.x + x;
    [self setViewX:viewX Y:KZERO Width:KZERO Height:KZERO];
}

- (void)changeViewY:(CGFloat)y
{
    CGFloat viewY = self.frame.origin.y + y;
    [self setViewX:KZERO Y:viewY Width:KZERO Height:KZERO];
}

- (void)changeViewX:(CGFloat)x Y:(CGFloat)y
{
    CGFloat viewX = self.frame.origin.x + x;
    CGFloat viewY = self.frame.origin.y + y;
    [self setViewX:viewX Y:viewY Width:KZERO Height:KZERO];
}

- (void)changeViewWidth:(CGFloat)width
{
    CGFloat viewWidth = self.frame.size.width + width;
    [self setViewX:KZERO Y:KZERO Width:viewWidth Height:KZERO];
}

- (void)changeViewHeight:(CGFloat)height
{
    CGFloat viewHeight = self.frame.size.height + height;
    [self setViewX:KZERO Y:KZERO Width:KZERO Height:viewHeight];
}

- (void)changeViewWidth:(CGFloat)width Height:(CGFloat)height
{
    CGFloat viewWidth = self.frame.size.width + width;
    CGFloat viewHeight = self.frame.size.height + height;
    [self setViewX:KZERO Y:KZERO Width:viewWidth Height:viewHeight];
}

#pragma mark - center
//set
- (void)setViewCenterX:(CGFloat)x Y:(CGFloat)y
{
    CGPoint viewCenter = self.center;
    if (NOTSET(x)) {
        
        viewCenter.x = x;
    }
    if (NOTSET(y)) {
        
        viewCenter.y = y;
    }
    self.center = viewCenter;
}

- (void)setViewCenterX:(CGFloat)x
{
    [self setViewCenterX:x Y:KZERO];
}

- (void)setViewCenterY:(CGFloat)y
{
    [self setViewCenterX:KZERO Y:y];
}

- (void)setViewCenter:(CGPoint)center
{
    [self setViewCenterX:center.x Y:center.y];
}

- (void)changeViewCenterX:(CGFloat)x
{
    CGFloat viewCenterX = self.center.x;
    [self setViewCenterX:viewCenterX Y:KZERO];
}

- (void)changeViewCenterY:(CGFloat)y
{
    CGFloat viewCenterY = self.center.y;
    [self setViewCenterY:viewCenterY];
}

@end
