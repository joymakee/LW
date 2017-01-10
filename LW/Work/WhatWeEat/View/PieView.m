//
//  PieView.m
//  PieDrawDemo
//
//  Created by wangguopeng on 2016/11/14.
//  Copyright © 2016年 joymake. All rights reserved.
//

#import "PieView.h"
#import "MealModel.h"
#import "CALayer+CateGory.h"

@interface PieView ()
@property (nonatomic,strong)NSMutableArray *layerArrayM;
@end

@implementation PieView

- (NSMutableArray *)layerArrayM{
    return _layerArrayM = _layerArrayM?:[NSMutableArray array];
}

-(void)setDataArrayM:(NSMutableArray *)dataArrayM{
    _dataArrayM = dataArrayM;
    [self drawPie];
}
- (void)drawPie{
    [self.layerArrayM enumerateObjectsUsingBlock:^(CALayer *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperlayer];
    }];
    self.backgroundColor = [UIColor clearColor];
    __weak __typeof (&*self)weakSelf = self;
    NSArray *colorarray = @[[UIColor orangeColor],[UIColor purpleColor],[UIColor redColor],[UIColor brownColor],[UIColor cyanColor],[UIColor orangeColor],[UIColor greenColor],[UIColor yellowColor],[UIColor magentaColor],[UIColor darkGrayColor]];
    
    CGPoint center = CGPointMake(self.center.x-(CGRectGetMaxX(self.frame)-CGRectGetMaxX(self.bounds)),self.center.y-(CGRectGetMaxY(self.frame)-CGRectGetMaxY(self.bounds)) );
    
    __block CGFloat startAngle = 0.0;
    __block CGFloat endAngle = 0.0;
    [self.dataArrayM enumerateObjectsUsingBlock:^(MealModel *model, NSUInteger idx, BOOL * _Nonnull stop) {
        endAngle = M_PI*2*model.mealRadius/ weakSelf.totalRadious + startAngle;
       
        UIBezierPath *path = [[UIBezierPath alloc]init];
        [path moveToPoint:center];
        [path addArcWithCenter:center radius:CGRectGetWidth(weakSelf.bounds)/2 startAngle:startAngle endAngle:endAngle clockwise:YES];
        
        CAShapeLayer *layer = [CAShapeLayer layer];
        layer.path = path.CGPath;
        layer.fillColor = [(UIColor *)colorarray[idx%colorarray.count] CGColor];
        layer.strokeColor = [UIColor clearColor].CGColor;
        [weakSelf.layer addSublayer:layer];
        CATextLayer *txtLayer = [weakSelf textLayer:model.title rotate:(endAngle - (endAngle-startAngle)/2)];
        [weakSelf.layer addSublayer:txtLayer];
        startAngle = endAngle;
        [weakSelf.layerArrayM addObject:layer];
        [weakSelf.layerArrayM addObject:txtLayer];
    }];
    
    UIBezierPath *path = [[UIBezierPath alloc]init];
    path.lineWidth = 10;
    [path addArcWithCenter:center radius:CGRectGetWidth(self.frame)/2 startAngle:0 endAngle:M_PI*2 clockwise:YES];
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.path = path.CGPath;
    layer.fillColor = [[UIColor clearColor] CGColor];
    layer.strokeColor = [UIColor purpleColor].CGColor;
    [self.layer addSublayer:layer];
    [self.layerArrayM addObject:layer];
}

- (CATextLayer*)textLayer:(NSString*)text rotate:(CGFloat)angel
{
    CATextLayer *txtLayer = (CATextLayer*)[CALayer layer];
    
    return  [txtLayer textLayer:text rotate:angel frame:CGRectMake(0, 0, self.bounds.size.width-self.layer.borderWidth*2-48, 25) position:CGPointMake(self.bounds.size.width/2, self.bounds.size.width/2) font:16];
}


@end
