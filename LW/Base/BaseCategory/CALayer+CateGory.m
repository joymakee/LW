//
//  CALayer+CateGory.m
//  LW
//
//  Created by wangguopeng on 2016/11/18.
//  Copyright © 2016年 joymake. All rights reserved.
//

#import "CALayer+CateGory.h"

@implementation CALayer (CateGory)
- (CATextLayer*)textLayer:(NSString*)text rotate:(CGFloat)angel frame:(CGRect)frame position:(CGPoint)position font:(NSInteger)fontSize
{
    CATextLayer *txtLayer = [CATextLayer layer];
    
    txtLayer.frame = frame;
    
    //设置锚点，绕中心点旋转
    txtLayer.anchorPoint = CGPointMake(0.5, 0.5);
    txtLayer.string = text;
    txtLayer.alignmentMode = [NSString stringWithFormat:@"right"];
    txtLayer.fontSize = fontSize;
    txtLayer.foregroundColor = [UIColor grayColor].CGColor;
    
    txtLayer.shadowColor = [UIColor yellowColor].CGColor;
    txtLayer.shadowOffset = CGSizeMake(5, 2);
    txtLayer.shadowRadius = 6;
    txtLayer.shadowOpacity = 0.6;
    
    //layer没有center，用Position
    [txtLayer setPosition:position];
    //旋转
    txtLayer.transform = CATransform3DMakeRotation(angel,0,0,1);
    return txtLayer;
}

@end
