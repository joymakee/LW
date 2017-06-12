//
//  JoyQRCodeScanView.m
//  LW
//
//  Created by wangguopeng on 2017/6/7.
//  Copyright © 2017年 joymake. All rights reserved.
//

#import "JoyQRCodeScanView.h"
#import <CALayer+JoyLayer.h>
#import "Joy.h"
#import <CAAnimation+HCAnimation.h>
#import "JoyCoreMotion.h"


@interface JoyQRCodeScanView ()<UIGestureRecognizerDelegate,ReCordPlayProtoCol>
/**
 *  记录开始的缩放比例
 */
@property(nonatomic,assign)CGFloat beginGestureScale;
/**
 *  最后的缩放比例
 */
@property(nonatomic,assign)CGFloat effectiveScale;
@property (nonatomic,strong)UIImageView *focusCursor;
@property (nonatomic,strong)UIButton *switchCameraBtn;
@property (nonatomic,strong)UIButton *torchLightBtn;
@property (nonatomic,strong)UIButton *photoSelectBtn;
@property (nonatomic,strong)UIButton *cancleBtn;
@property (nonatomic,strong)UIView  *scanlineView;

@end

@implementation JoyQRCodeScanView

-(UIView *)scanlineView{
    if (!_scanlineView) {
        _scanlineView = [[UIView alloc]initWithFrame:CGRectMake(10, 100, SCREEN_W-20, 2)];
        _scanlineView.backgroundColor = [UIColor greenColor];
        _scanlineView.layer.masksToBounds = YES;
        _scanlineView.layer.cornerRadius =3;
    }
    return _scanlineView;
}

-(UIButton *)switchCameraBtn{
    if (!_switchCameraBtn) {
        _switchCameraBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_switchCameraBtn setImage:[UIImage imageNamed:@"LW_SwitchCamera"] forState:UIControlStateNormal];
        [_switchCameraBtn addTarget:self action:@selector(switchCameraBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _switchCameraBtn;
}

-(UIButton *)torchLightBtn{
    if (!_torchLightBtn) {
        _torchLightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_torchLightBtn setImage:[UIImage imageNamed:@"LW_Video_FlashLight"] forState:UIControlStateNormal];
        [_torchLightBtn addTarget:self action:@selector(lightControl:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _torchLightBtn;
}

-(UIButton *)photoSelectBtn{
    if (!_photoSelectBtn) {
        _photoSelectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_photoSelectBtn setImage:[UIImage imageNamed:@"LW_PhotoLibruary"] forState:UIControlStateNormal];
        [_photoSelectBtn addTarget:self action:@selector(selectPhoto:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _photoSelectBtn;
}

-(UIButton *)cancleBtn{
    if (!_cancleBtn) {
        _cancleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancleBtn setImage:[UIImage imageNamed:@"LW_Video_Down"] forState:UIControlStateNormal];
        [_cancleBtn addTarget:self action:@selector(leaveout:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancleBtn;
}

- (instancetype)init{
    if (self = [super init]) {
        self.backgroundColor = JOY_blackColor;
        self.effectiveScale = self.beginGestureScale = 1.0f;
        [self initCapture];
        [self setUpGesture];
        [self addGenstureRecognizer];
        [self addSubview:self.switchCameraBtn];
        [self addSubview:self.torchLightBtn];
        [self addSubview:self.photoSelectBtn];
        [self addSubview:self.cancleBtn];
        [self addSubview:self.scanlineView];
        [self setCoreMotion];
        [CAAnimation showMoveAnimationInView:self.scanlineView Position:CGPointMake(160, SCREEN_H-100) Repeat:0 Duration:1.5];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    _recorder.preViewLayer.frame = self.bounds;
}

- (void)updateConstraints{
    [super updateConstraints];
    
    __weak __typeof (&*self)weakSelf = self;
    
    MAS_CONSTRAINT(self.torchLightBtn, make.right.equalTo(weakSelf.mas_right).offset(-20);
                   make.top.equalTo(weakSelf.mas_top).offset(30);
                   make.height.mas_equalTo(30);
                   make.width.mas_equalTo(30);
                   );
    
    MAS_CONSTRAINT(_switchCameraBtn, make.right.equalTo(weakSelf.torchLightBtn.mas_left).offset(-20);
                   make.centerY.equalTo(weakSelf.torchLightBtn.mas_centerY);
                   make.height.mas_equalTo(20);
                   make.width.mas_equalTo(25);
                   );
    MAS_CONSTRAINT(self.photoSelectBtn, make.bottom.equalTo(weakSelf.mas_bottom).offset(-60);
                   make.centerX.equalTo(weakSelf.mas_centerX);
                   make.height.mas_equalTo(50);
                   make.width.mas_equalTo(50);
                   );
    
    MAS_CONSTRAINT(self.cancleBtn, make.right.mas_equalTo(weakSelf.photoSelectBtn.mas_left).offset(-40);
                   make.centerY.mas_equalTo(weakSelf.photoSelectBtn);
                   make.height.mas_equalTo(weakSelf.photoSelectBtn.mas_height);
                   make.width.mas_equalTo(weakSelf.photoSelectBtn.mas_width);
                   );
}

- (void)setCoreMotion{
    __weak __typeof(&*self)weakSelf = self;
    [[JoyCoreMotion sharedInstance] startMotionManager:YES];
    [JoyCoreMotion sharedInstance].screenOrentationBlock = ^(NSInteger orientation){
        [weakSelf updateVideoOrientationWithResult:orientation];
    };
}

-(void)stopCoreMotion{
    [[JoyCoreMotion sharedInstance] stopDetect];
    [JoyCoreMotion sharedInstance].screenOrentationBlock = nil;
}

- (void)updateVideoOrientationWithResult:(AVCaptureVideoOrientation)videoOrientation{
    __weak __typeof(&*self)weakSelf = self;
    CGAffineTransform rotateToTransform = CGAffineTransformIdentity;
    switch (videoOrientation) {
        case AVCaptureVideoOrientationPortrait:
        {
            rotateToTransform = CGAffineTransformIdentity;
        }
            break;
        case AVCaptureVideoOrientationPortraitUpsideDown:
        {
            rotateToTransform = CGAffineTransformMakeRotation(M_PI);
        }
            break;
        case AVCaptureVideoOrientationLandscapeRight:
        {
            rotateToTransform = CGAffineTransformMakeRotation(M_PI_2);
        }
            break;
        case AVCaptureVideoOrientationLandscapeLeft:
        {
            rotateToTransform = CGAffineTransformMakeRotation(-M_PI_2);
        }
            break;
            
        default:
            break;
    }
    if (videoOrientation != AVCaptureVideoOrientationPortraitUpsideDown) {
        [UIView animateWithDuration:0.5 animations:^{
            weakSelf.switchCameraBtn.transform = rotateToTransform;
            weakSelf.torchLightBtn.transform = rotateToTransform;
            weakSelf.photoSelectBtn.transform = rotateToTransform;
            weakSelf.cancleBtn.transform = rotateToTransform;
        }];
    }
}

#pragma mark 屏幕旋转
-(void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation{
    self.recorder.preViewLayer.frame = [UIScreen mainScreen].bounds;
}

-(UIImageView *)focusCursor{
    if (!_focusCursor) {
        _focusCursor = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 35, 35)];
        _focusCursor.image = [UIImage imageNamed:@"LW_CameraFocus"];
        [self addSubview:_focusCursor];
        _focusCursor.alpha = 0;
    }
    return _focusCursor;
}

- (void)switchCameraBtn:(UIButton *)btn{
    [self.layer transitionWithAnimType:TransitionAnimTypeRippleEffect subType:TransitionSubtypesFromRamdom curve:TransitionCurveRamdom duration:0.8];
    [self.recorder switchCamera];
}

- (void)lightControl:(UIButton *)btn{
    [self.recorder switchTorch];
}

- (void)selectPhoto:(UIButton *)btn{
    self.selectPhotoBlock?self.selectPhotoBlock():nil;
}

- (void)leaveout:(UIButton *)btn{
    __weak __typeof(&*self)weakSlef = self;
    [UIView animateWithDuration:0.3 animations:^{
        weakSlef.y = SCREEN_H;
    } completion:^(BOOL finished) {
        [weakSlef.recorder stopCurrentVideoRecording];
        [weakSlef.recorder.captureSession stopRunning];
        [weakSlef stopCoreMotion];
        [weakSlef removeFromSuperview];
    }];
}

-(void)initCapture{
    if (!_recorder) {
        __weak typeof(self)weakSelf = self;
        _recorder = [[JoyMediaRecordPlay alloc]initWithCaptureType:EAVCaptureMetadataOutput];
        [self.layer addSublayer:self.recorder.preViewLayer];
        _recorder.delegate = self;
    }
}

-(void)joyCaptureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    if (metadataObjects.count > 0){
        [self.recorder.captureSession stopRunning];
        AVMetadataMachineReadableCodeObject *obj = metadataObjects.count?metadataObjects.firstObject:nil;
        NSString *scanStr = obj?obj.stringValue:nil;
        __weak __typeof(&*self)weakSelf = self;
        scanStr?dispatch_async(dispatch_get_main_queue(), ^{
            weakSelf.scanMMetaBlock?weakSelf.scanMMetaBlock(scanStr):nil;
            [weakSelf leaveout:nil];
        }):nil;
    }
}

/**
 * 添加手势：点按时聚焦
 *
 */
- (void)addGenstureRecognizer
{
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapScreen:)];
    [self addGestureRecognizer:tapGesture];
}
- (void)tapScreen:(UITapGestureRecognizer *)tapGesture
{
    CGPoint point= [tapGesture locationInView:self];
    NSLog(@"(%f,%f)",point.x,point.y);
    [self setFocusCursorWithPoint:point];
    [self.recorder setFoucusWithPoint:point];
}
/**
 *  设置聚焦光标位置
 *
 *  @param point 光标位置
 */
-(void)setFocusCursorWithPoint:(CGPoint)point{
    self.focusCursor.center=point;
    [CAAnimation showRotateAnimationInView:self.focusCursor Degree:6.65*M_PI Direction:AxisZ Repeat:1 Duration:1.5 autoreverses:NO];
    [CAAnimation showScaleAnimationInView:self.focusCursor fromValue:2 ScaleValue:1 Repeat:1 Duration:1 autoreverses:YES];
    [CAAnimation showOpacityAnimationInView:self.focusCursor fromAlpha:1 Alpha:0 Repeat:1 Duration:3 autoreverses:NO];
}

#pragma 创建手势
- (void)setUpGesture{
    
    UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handlePinchGesture:)];
    pinch.delegate = self;
    [self addGestureRecognizer:pinch];
}

#pragma mark gestureRecognizer delegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if ( [gestureRecognizer isKindOfClass:[UIPinchGestureRecognizer class]] ) {
        self.beginGestureScale = self.effectiveScale;
    }
    return YES;
}

//缩放手势 用于调整焦距
- (void)handlePinchGesture:(UIPinchGestureRecognizer *)recognizer{
    BOOL touchAvaliad = YES;
    NSUInteger numTouches = [recognizer numberOfTouches], i;
    for ( i = 0; i < numTouches; ++i ) {
        CGPoint location = [recognizer locationOfTouch:i inView:self];
        CGPoint convertedLocation = [self.recorder.preViewLayer convertPoint:location fromLayer:self.recorder.preViewLayer.superlayer];
        if ( ! [self.recorder.preViewLayer containsPoint:convertedLocation] )
        {
            touchAvaliad = NO;
            break;
        }
    }
    
    if ( touchAvaliad ) {
        CGFloat maxScaleAndCropFactor = 10;
        if (self.beginGestureScale * recognizer.scale > 1.0 && self.beginGestureScale * recognizer.scale < maxScaleAndCropFactor)
        {
            self.effectiveScale = self.beginGestureScale * recognizer.scale;
            [self.recorder updateVideoScaleAndCropFactor:self.effectiveScale];
        }
    }
}
@end
