//
//  LWTempratureView.m
//  DashboardDemo
//
//  Created by joymake on 2017/5/22.
//  Copyright © 2017年 bestdew. All rights reserved.
//


//圆环线宽
#define KCIRCLE_LINE_WIDTH KSELF_WIDTH_2/20
#define KCIRCLE_LINE_WIDTH_2 KCIRCLE_LINE_WIDTH/2

//自身view宽高
#define KSELF_WIDTH  self.bounds.size.width
#define KSELF_HEIGHT self.bounds.size.height

#define KSELF_WIDTH_2  KSELF_WIDTH/2
#define KSELF_HEIGHT_2 self.bounds.size.height/2

//progress线宽
#define KPROGRESS_LINE_WIDTH KSELF_WIDTH_2/2
#define KPROGRESS_LINE_WIDTH_2 KPROGRESS_LINE_WIDTH/2

//刻度线高
#define KTIC_LINE_WIDTH KSELF_WIDTH_2/16
#define KTIC_LINE_WIDTH_2 KTIC_LINE_WIDTH/2

#define KCALIBRATIONFONT KSELF_WIDTH_2/12

#define KSTART_ANGLE -M_PI_4 *5

#define KEND_ANGLE   M_PI_4

#import "LWTempratureView.h"

@interface LWTempratureView (){
    CALayer *_needleLayer;
}
@property (nonatomic, weak) CAShapeLayer *progressLayer;
@property (nonatomic, weak) UILabel      *label;
@end

@implementation LWTempratureView


-(void)layoutSubviews{
    [super layoutSubviews];
    [self drawTempratureView];
}

- (void)drawTempratureView{
    [self addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)]];
    // 外环弧线
    CAShapeLayer *outArc = [self drawCurveWithRadius:KSELF_WIDTH_2-KCIRCLE_LINE_WIDTH_2];
    [self.layer addSublayer:outArc];

    // 内环弧线 半径为自身宽度-外环宽度-progress宽度-circle一半的宽度，因为radiouds位置不是圆环的顶端而是圆环线宽的中间
    CAShapeLayer *inArc = [self drawCurveWithRadius:KSELF_WIDTH_2-KPROGRESS_LINE_WIDTH-KCIRCLE_LINE_WIDTH-KCIRCLE_LINE_WIDTH_2];
    [self.layer addSublayer:inArc];

    // 绘制进度图层
    UIBezierPath *progressPath  = [UIBezierPath bezierPathWithArcCenter:CGPointMake(KSELF_WIDTH_2, KSELF_HEIGHT_2)
                                                                 radius:KSELF_WIDTH_2-KCIRCLE_LINE_WIDTH-KPROGRESS_LINE_WIDTH_2
                                                             startAngle:KSTART_ANGLE
                                                               endAngle:KEND_ANGLE
                                                              clockwise:YES];
    CAShapeLayer *progressLayer = [CAShapeLayer layer];
    progressLayer.lineWidth     =  KPROGRESS_LINE_WIDTH;
    progressLayer.fillColor     = [[UIColor clearColor] CGColor];
    progressLayer.strokeColor   = [[UIColor whiteColor] CGColor];
    progressLayer.path          = progressPath.CGPath;
    progressLayer.strokeStart   = 0.0;
    progressLayer.strokeEnd     = 0.0;
    [self.layer addSublayer:progressLayer];
    _progressLayer = progressLayer;

    // 添加观察者，观察progressLayer的strokeEnd属性，以便为_lbel赋值
    [progressLayer addObserver:self
                    forKeyPath:@"strokeEnd"
                       options:NSKeyValueObservingOptionNew
                       context:nil];

    // 渐变图层
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = self.bounds;
    [gradientLayer setColors:[NSArray arrayWithObjects:
                              (id)[[UIColor colorWithRed:0.09 green:0.58 blue:0.15 alpha:1.00] CGColor],
                              (id)[[UIColor colorWithRed:0.20 green:0.63 blue:0.25 alpha:1.00] CGColor],
                              (id)[[UIColor colorWithRed:0.60 green:0.82 blue:0.22 alpha:1.00] CGColor],
                              (id)[[UIColor colorWithRed:0.97 green:0.65 blue:0.22 alpha:1.00] CGColor],
                              (id)[[UIColor colorWithRed:0.96 green:0.08 blue:0.10 alpha:1.00] CGColor],
                              nil]];
    [gradientLayer setLocations:@[@0, @0.25, @0.5, @0.75, @1]];
    [gradientLayer setStartPoint:CGPointMake(0, 0)];
    [gradientLayer setEndPoint:CGPointMake(1, 0)];
    [gradientLayer setMask:progressLayer];
    [self.layer addSublayer:gradientLayer];
    // 绘制刻度
    CGFloat perAngle = (KEND_ANGLE -KSTART_ANGLE) / 50; // 一刻度的弧度值
    CGFloat calWidth = perAngle / 5; // 刻度线的宽度

    for (int i = 0; i<=50; i++) {
        CGFloat startAngel = KSTART_ANGLE + perAngle * i;
        CGFloat endAngel   = startAngel + calWidth;
        UIBezierPath *tickPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(KSELF_WIDTH_2, KSELF_HEIGHT_2)
                                                                radius:KSELF_WIDTH_2-KCIRCLE_LINE_WIDTH-KTIC_LINE_WIDTH_2
                                                            startAngle:startAngel
                                                              endAngle:endAngel
                                                             clockwise:YES];
        CAShapeLayer *perLayer = [CAShapeLayer layer];
        if (i % 5 == 0) {
            perLayer.strokeColor = [[UIColor whiteColor] CGColor];
            perLayer.lineWidth   = KTIC_LINE_WIDTH;
            CGPoint point = [self calculateTextPositonWithArcCenter:CGPointMake(KSELF_WIDTH_2, KSELF_HEIGHT_2) angle:-startAngel];
            UILabel *calibration       = [[UILabel alloc] initWithFrame:CGRectMake(point.x - 15, point.y - 10, 30, 20)];
            calibration.text           = [NSString stringWithFormat:@"%d", i];
            calibration.font           = [UIFont systemFontOfSize:KCALIBRATIONFONT];
            calibration.textColor      = [UIColor whiteColor];
            calibration.textAlignment  = NSTextAlignmentCenter;
            [self addSubview:calibration];
            
        }else{
            
            perLayer.strokeColor = [[UIColor colorWithRed:0.22 green:0.66 blue:0.87 alpha:1.0] CGColor];
            perLayer.lineWidth   = KTIC_LINE_WIDTH_2;
        }
        
        perLayer.path = tickPath.CGPath;
        
        [self.layer addSublayer:perLayer];
    }
    [self addPointer];

    float labelW = (KSELF_WIDTH_2-KPROGRESS_LINE_WIDTH-2*KCIRCLE_LINE_WIDTH)*2 ,labelH = 50.0f;
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(KSELF_WIDTH_2-labelW/2,KSELF_HEIGHT_2,labelW,labelH)];
    label.textColor = [UIColor whiteColor];
    label.text = @"0°C";
    CGFloat font = KSELF_WIDTH_2/4;
    label.font = [UIFont italicSystemFontOfSize:font];
    label.textAlignment = NSTextAlignmentCenter;
    [self addSubview:label];
    _label = label;
    //首次layout动画刷新一下
    self.targetValue = self.targetValue;
}


- (void)addPointer{
    // 指针
    _needleLayer = [CALayer layer];
    // 锚点位置
    _needleLayer.position = CGPointMake(KSELF_WIDTH_2, KSELF_HEIGHT_2);
    // bounds
    _needleLayer.bounds = CGRectMake(0, 0, KSELF_HEIGHT_2/5, KSELF_HEIGHT_2);

    // 设置锚点
    _needleLayer.anchorPoint = CGPointMake(0.5, 1155/1300.f);
    // 添加图片
    _needleLayer.contents = (id)[UIImage imageNamed:@"zhizhen"].CGImage;
    [self.layer addSublayer:_needleLayer];
    _needleLayer.transform = CATransform3DMakeRotation(M_PI_4*5+self.currentValue*(KEND_ANGLE-KSTART_ANGLE), 0, 0, 1);
}

/**
 绘制弧线
 
 @param radius 半径
 @return CAShapeLayer
 */
- (CAShapeLayer *)drawCurveWithRadius:(CGFloat)radius
{
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2)
                                                        radius:radius
                                                    startAngle:KSTART_ANGLE
                                                      endAngle:KEND_ANGLE
                                                     clockwise:YES];
    CAShapeLayer *curve = [CAShapeLayer layer];
    curve.lineWidth     = KCIRCLE_LINE_WIDTH;
    curve.fillColor     = [[UIColor clearColor] CGColor];
    curve.strokeColor   = [[UIColor colorWithWhite:0.7 alpha:0.6] CGColor];
    curve.path          = path.CGPath;
    
    return curve;
}

/**
 计算Label位置
 
 @param center 中心点
 @param angel 角度
 @return CGPoint
 */
- (CGPoint)calculateTextPositonWithArcCenter:(CGPoint)center angle:(CGFloat)angel
{
    //KCALIBRATIONFONT是字号的大小
    CGFloat calRadius = KSELF_WIDTH_2-KCIRCLE_LINE_WIDTH-KTIC_LINE_WIDTH-KCALIBRATIONFONT; // 刻度Label中心点所在圆弧的半径
    CGFloat x = calRadius * cosf(angel);
    CGFloat y = calRadius * sinf(angel);
    return CGPointMake(center.x + x, center.y - y);
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"strokeEnd"]) {
        
        NSInteger value = [change[@"new"] floatValue] * 50;
        
        CATransition *animation = [CATransition animation];
        animation.duration = 1.f;
        _label.text = [NSString stringWithFormat:@"%zd°C", value];
        [_label.layer addAnimation:animation forKey:nil];
    }
}

- (void)handlePan:(UIGestureRecognizer *)gesture {
    CGPoint currentPosition = [gesture locationInView:self];
    
    if (gesture.state == UIGestureRecognizerStateBegan)
    {
        NSLog(@"[%f, %f]", currentPosition.x, currentPosition.y);
        NSLog(@"1111111111");
    }
    else if (gesture.state == UIGestureRecognizerStateChanged)
    {
        self.targetValue = [self calculateRadian:currentPosition];
        self.valueChangedBlock?self.valueChangedBlock(self.targetValue):nil;
        NSLog(@"[%f, %f]", currentPosition.x, currentPosition.y);
        NSLog(@"222222222222");
    }
    else if (gesture.state == UIGestureRecognizerStateEnded)
    {
        self.valueChangedBlock?self.valueChangedBlock(self.targetValue):nil;
        NSLog(@"[%f, %f]", currentPosition.x, currentPosition.y);
        NSLog(@"333333333333");
    }
}

-(void)setDisableGsture:(BOOL)disableGsture{
    _disableGsture = disableGsture;
    self.userInteractionEnabled = !disableGsture;
}

- (CGFloat)calculateRadian:(CGPoint)pos {
    //反正切计算夹角弧度
    float angle = atan2f(pos.y-KSELF_HEIGHT_2,pos.x-KSELF_WIDTH_2 );
    if (pos.x<KSELF_WIDTH_2 &&pos.y>KSELF_HEIGHT_2) {
        //x，y均在中心点左下角时,atan2f计算出来的值没有符号,多出来一个圆的弧度所以要减去
        angle -=M_PI*2;
    }
    
    float result = (angle - KSTART_ANGLE) /(KEND_ANGLE-KSTART_ANGLE);
    
    if (result<=0) {
        result =0;
    }
    if (result>1) {
        result = 1;
    }
    return result;
}

-(void)setTargetValue:(CGFloat)targetValue{
    _targetValue = targetValue;
    [CATransaction begin];
    [CATransaction setDisableActions:NO];
    [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]];
    [CATransaction setAnimationDuration:1.f];
    _progressLayer.strokeEnd =targetValue;
    [CATransaction commit];

}

//-(void)setCurrentValue:(CGFloat)currentValue{
//    _currentValue = currentValue;
//    [CATransaction begin];
//    [CATransaction setDisableActions:NO];
//    [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]];
//    [CATransaction setAnimationDuration:1.f];
//    _progressLayer.strokeEnd =currentValue;
//    [CATransaction commit];
//}

- (void)dealloc
{
    [_progressLayer removeObserver:self forKeyPath:@"strokeEnd"];
    [_progressLayer removeAllAnimations];
}

@end
