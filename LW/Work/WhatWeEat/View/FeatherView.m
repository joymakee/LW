//
//  FeatherView.m
//  PieDrawDemo
//
//  Created by wangguopeng on 2016/11/14.
//  Copyright © 2016年 joymake. All rights reserved.
//

#import "FeatherView.h"
#import <objc/runtime.h>
#import "CALayer+CateGory.h"

@interface FeatherView ()
@property (nonatomic,strong)UIBezierPath *centerPath;
@property (nonatomic,strong)NSMutableArray *layerArrayM;
@end

@implementation FeatherView

- (NSMutableArray *)layerArrayM{
    return _layerArrayM = _layerArrayM?:[NSMutableArray array];
}

- (UIBezierPath *)centerPath{
    return _centerPath = _centerPath?:[[UIBezierPath alloc]init];
}

- (void)drawFeatherViewTouchBlock:(VOIDBLOCK)touchBlock{
    [self.layerArrayM enumerateObjectsUsingBlock:^(CALayer *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperlayer];
    }];
    objc_setAssociatedObject(self, @selector(touchesEnded:withEvent:), touchBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    CGPoint center = CGPointMake(self.center.x-(CGRectGetMaxX(self.frame)-CGRectGetMaxX(self.bounds)),self.center.y-(CGRectGetMaxY(self.frame)-CGRectGetMaxY(self.bounds)) );
    UIBezierPath *path = [[UIBezierPath alloc]init];
    [path moveToPoint:CGPointMake(center.x+CGRectGetWidth(self.bounds)/3, center.y)];
    [path addArcWithCenter:center radius:CGRectGetWidth(self.frame)/14 startAngle:M_PI/4 endAngle:M_PI*7/4 clockwise:YES];
    [path closePath];
    [path addArcWithCenter:CGPointMake(center.x+CGRectGetWidth(self.bounds)/3, center.y) radius:CGRectGetWidth(self.frame)/120 startAngle:0 endAngle:M_PI*2 clockwise:YES];
    
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.path = path.CGPath;
    layer.fillColor = [UIColor orangeColor].CGColor;
    layer.strokeColor = [[UIColor purpleColor] CGColor];
    [self.layer addSublayer:layer];
    
    [self.centerPath addArcWithCenter:center radius:CGRectGetWidth(self.frame)/30 startAngle:0 endAngle:M_PI*2 clockwise:YES];
    [self.centerPath addLineToPoint:CGPointMake(center.x+CGRectGetWidth(self.bounds)/3, center.y)];
    [self.centerPath closePath];
    CAShapeLayer *centerLayer = [CAShapeLayer layer];
    centerLayer.path = self.centerPath.CGPath;
    centerLayer.fillColor = [UIColor purpleColor].CGColor;
    centerLayer.strokeColor = [UIColor purpleColor].CGColor;
    [self.layer addSublayer:centerLayer];
    
    CATextLayer *txtLayer = [self textLayer:@"Go" rotate:0];
    [self.layer addSublayer:txtLayer];
    
    [self.layerArrayM addObject:layer];
    [self.layerArrayM addObject:centerLayer];
    [self.layerArrayM addObject:txtLayer];

}

- (CATextLayer*)textLayer:(NSString*)text rotate:(CGFloat)angel
{
    CATextLayer *txtLayer = (CATextLayer*)[CALayer layer];

    return  [txtLayer textLayer:text rotate:angel frame:CGRectMake(0, 0, 25, 25) position:CGPointMake(self.bounds.size.width/2, self.bounds.size.width/2) font:16];
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSSet *allTouches = [event allTouches];    //返回与当前接收者有关的所有的触摸对象
    UITouch *touch = [allTouches anyObject];   //视图中的所有对象
    CGPoint point = [touch locationInView:[touch view]]; //返回触摸点在视图中的当前坐标
    int x = point.x;
    int y = point.y;
    if ([self.centerPath containsPoint:point]) {
        VOIDBLOCK touchBlock = objc_getAssociatedObject(self, _cmd);
        touchBlock?touchBlock():nil;
        NSLog(@"touch (x, y) is (%d, %d)", x, y);
    }
}
@end
