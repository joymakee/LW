//
//  CALayer+ScanCode.m
//  bei
//
//  Created by Joymake on 2019/6/24.
//  Copyright © 2019 IB. All rights reserved.
//

#import "CALayer+ScanCode.h"
#import <UIKit/UIBezierPath.h>
#import <UIKit/UIColor.h>
#import <UIKit/UIGeometry.h>

@implementation CALayer (ScanCode)

- (void)addScanLayerScanW:(CGFloat)scanW scanH:(CGFloat)scanH cornerWidth:(CGFloat)cornerW{
    
    float scanWidth = scanW?:200;
    float scanHeight = scanH?:200;
    float cornerWidth = cornerW?:30;
    
    CGFloat width = self.bounds.size.width;
    CGFloat height = self.bounds.size.height;
    
    CGFloat spaceLeading = (width - scanWidth)/2;
    CGFloat spaceTop = (height - scanHeight)/2;
    
    UIBezierPath *grayPath = [[UIBezierPath alloc]init];
    [grayPath moveToPoint:CGPointMake(spaceLeading, spaceTop)];
    [grayPath addLineToPoint:CGPointMake(width-spaceLeading, spaceTop)];
    [grayPath addLineToPoint:CGPointMake(width-spaceLeading, height-spaceTop)];
    [grayPath addLineToPoint:CGPointMake(spaceLeading, height-spaceTop)];
    
    [grayPath moveToPoint:CGPointMake(0, 0)];
    [grayPath addLineToPoint:CGPointMake(self.bounds.size.width, 0)];
    [grayPath addLineToPoint:CGPointMake(self.bounds.size.width,self.bounds.size.height)];
    [grayPath addLineToPoint:CGPointMake(0, self.bounds.size.height)];
    [grayPath closePath];
    
    CAShapeLayer *grayLayer = [CAShapeLayer layer];
    grayLayer.path = grayPath.CGPath;
    grayLayer.strokeColor = [UIColor whiteColor].CGColor;
    grayLayer.fillColor = [[UIColor colorWithWhite:0.3 alpha:0.8] CGColor];
    grayLayer.fillRule = kCAFillRuleEvenOdd;
    [self addSublayer:grayLayer];
    
    //四个角
    UIBezierPath *topCornerPath = [[UIBezierPath alloc]init];
    [topCornerPath moveToPoint:CGPointMake(spaceLeading, spaceTop+cornerWidth)];
    [topCornerPath addLineToPoint:CGPointMake(spaceLeading, spaceTop)];
    [topCornerPath addLineToPoint:CGPointMake(spaceLeading+cornerWidth, spaceTop)];
    
    [topCornerPath moveToPoint:CGPointMake(width-cornerWidth-spaceLeading, spaceTop)];
    [topCornerPath addLineToPoint:CGPointMake(width-spaceLeading, spaceTop)];
    [topCornerPath addLineToPoint:CGPointMake(width-spaceLeading, spaceTop+cornerWidth)];
    
    [topCornerPath moveToPoint:CGPointMake(width-spaceLeading, height-spaceTop-cornerWidth)];
    [topCornerPath addLineToPoint:CGPointMake(width-spaceLeading, height-spaceTop)];
    [topCornerPath addLineToPoint:CGPointMake(width-spaceLeading-cornerWidth, height-spaceTop)];
    
    [topCornerPath moveToPoint:CGPointMake(cornerWidth+spaceLeading, height-spaceTop)];
    [topCornerPath addLineToPoint:CGPointMake(spaceLeading, height-spaceTop)];
    [topCornerPath addLineToPoint:CGPointMake(spaceLeading, height-spaceTop-cornerWidth)];
    topCornerPath.lineWidth = 5;
    topCornerPath.lineJoinStyle = kCGLineJoinMiter;
    topCornerPath.lineCapStyle = kCGLineCapRound;
    
    CAShapeLayer *topCornerLayer = [CAShapeLayer layer];
    topCornerLayer.path = topCornerPath.CGPath;
    topCornerLayer.strokeColor = [[UIColor greenColor] CGColor];
    topCornerLayer.fillColor = [[UIColor clearColor] CGColor];
    [self addSublayer:topCornerLayer];
    
    //动画layer
    UIBezierPath *animationPath = [[UIBezierPath alloc]init];
    [animationPath moveToPoint:CGPointMake(spaceLeading+cornerWidth, spaceTop)];
    [animationPath addLineToPoint:CGPointMake(width - spaceLeading-cornerWidth, spaceTop)];
    animationPath.lineWidth = 50;
    CAShapeLayer *animationLayer = [CAShapeLayer layer];
    animationLayer.path = animationPath.CGPath;
    animationLayer.strokeColor = [[UIColor greenColor] CGColor];
    animationLayer.fillColor = [[UIColor clearColor] CGColor];
    
    CABasicAnimation *moveAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    moveAnimation.fromValue = [NSValue valueWithCGPoint:animationLayer.position];
    moveAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(0, scanHeight)];
    moveAnimation.autoreverses = YES;
    moveAnimation.fillMode = kCAFillModeForwards;
    moveAnimation.removedOnCompletion = NO;
    moveAnimation.repeatCount = MAXFLOAT;
    moveAnimation.duration = 1.5;
    [animationLayer addAnimation:moveAnimation forKey:@"moveAnimation"];
    
    [self addSublayer:animationLayer];
}

@end
