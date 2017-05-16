//
//  JoyProgressView.m
//  LW
//
//  Created by wangguopeng on 2017/5/16.
//  Copyright © 2017年 joymake. All rights reserved.
//

#import "JoyProgressView.h"

@implementation JoyProgressView

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    //1.获取上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    //1.1 设置线条的宽度
    CGContextSetLineWidth(ctx, 10);
    //1.2 设置线条的起始点样式
    CGContextSetLineCap(ctx,kCGLineCapButt);
    //1.3  虚实切换 ，实线5虚线10
    CGFloat length[] = {1.5,3};
    CGContextSetLineDash(ctx, 0, length, 2);
    //1.4 设置颜色
    [[UIColor orangeColor] set];
    
    //2.设置路径
    
    CGFloat end = -5*M_PI_4+(6*M_PI_4*_progress/15);
    
    CGContextAddArc(ctx, self.width/2 , self.height/2, 40, -5*M_PI_4, end , 0);
    
    //3.绘制
    CGContextStrokePath(ctx);

}

-(void)setProgress:(CGFloat)progress{
    _progress = progress;
    [self setNeedsDisplay];
}



@end
