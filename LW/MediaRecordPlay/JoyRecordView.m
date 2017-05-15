//
//  JoyRecordView.m
//  LW
//
//  Created by wangguopeng on 2017/5/3.
//  Copyright © 2017年 joymake. All rights reserved.
//

#import "JoyRecordView.h"
#import "JoyMediaRecordPlay.h"
#import <CALayer+JoyLayer.h>
#import "Joy.h"
#import <CAAnimation+HCAnimation.h>

@interface JoyRecordView ()<UIGestureRecognizerDelegate>
@property (nonatomic,strong)JoyMediaRecordPlay *recorder;
/**
 *  记录开始的缩放比例
 */
@property(nonatomic,assign)CGFloat beginGestureScale;
/**
 *  最后的缩放比例
 */
@property(nonatomic,assign)CGFloat effectiveScale;

@property (nonatomic,strong)UIImageView *focusCursor;

@end

@implementation JoyRecordView

- (instancetype)init{
    if (self = [super init]) {
//        self.frame = [UIScreen mainScreen].bounds;
        self.backgroundColor = JOY_blackColor;
        self.effectiveScale = self.beginGestureScale = 1.0f;

        UIButton *switchCameraBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [switchCameraBtn setImage:[UIImage imageNamed:@"LW_SwitchCamera"] forState:UIControlStateNormal];
//        [switchCameraBtn setFrame:CGRectMake(SCREEN_W-90, 35, 20, 20)];
        [switchCameraBtn addTarget:self action:@selector(switchCameraBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *torchLightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [torchLightBtn setImage:[UIImage imageNamed:@"LW_Video_FlashLight"] forState:UIControlStateNormal];
//        [torchLightBtn setFrame:CGRectMake(SCREEN_W-50, 30, 30, 30)];
        [torchLightBtn addTarget:self action:@selector(lightControl:) forControlEvents:UIControlEventTouchUpInside];

        UIButton *startRecordBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [startRecordBtn setImage:[UIImage imageNamed:@"LW_StartRecordVideo"] forState:UIControlStateNormal];
//        [startRecordBtn setFrame:CGRectMake(0, SCREEN_H-100, 50, 50)];
//        startRecordBtn.centerX = self.centerX;
        [startRecordBtn addTarget:self action:@selector(startRecord:) forControlEvents:UIControlEventTouchDown];
        [startRecordBtn addTarget:self action:@selector(stopRecord:) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *cancleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [cancleBtn setImage:[UIImage imageNamed:@"LW_Video_Down"] forState:UIControlStateNormal];
//        [cancleBtn setFrame:startRecordBtn.frame];
        [cancleBtn addTarget:self action:@selector(leaveout:) forControlEvents:UIControlEventTouchUpInside];
//        cancleBtn.x = startRecordBtn.x-cancleBtn.width-40;
        [self initRecorder];
        [self setUpGesture];
        [self addGenstureRecognizer];
        [self addSubview:switchCameraBtn];
        [self addSubview:torchLightBtn];
        [self addSubview:startRecordBtn];
        [self addSubview:cancleBtn];

        __weak __typeof (&*self)weakSelf = self;
        
        MAS_CONSTRAINT(torchLightBtn, make.right.equalTo(weakSelf.mas_right).offset(-20);
                       make.top.equalTo(weakSelf.mas_top).offset(30);
                       make.height.mas_equalTo(30);
                       make.width.mas_equalTo(30);
                       );
        MAS_CONSTRAINT(switchCameraBtn, make.right.equalTo(torchLightBtn.mas_left).offset(-20);
                       make.centerY.equalTo(torchLightBtn.mas_centerY);
                       make.height.mas_equalTo(25);
                       make.width.mas_equalTo(25);
                       );
        MAS_CONSTRAINT(startRecordBtn, make.bottom.equalTo(weakSelf.mas_bottom).offset(-60);
                       make.centerX.equalTo(weakSelf.mas_centerX);
                       make.height.mas_equalTo(50);
                       make.width.mas_equalTo(50);
                       );
//
        MAS_CONSTRAINT(cancleBtn, make.right.mas_equalTo(startRecordBtn.mas_left).offset(-40);
                       make.centerY.mas_equalTo(startRecordBtn);
                       make.height.mas_equalTo(startRecordBtn.mas_height);
                       make.width.mas_equalTo(startRecordBtn.mas_width);
                       );
        
        _recorder.preViewLayer.frame = CGRectMake(0, 0, SCREEN_W, SCREEN_H);
        [self updateConstraintsIfNeeded];
    }
    return self;
}

-(void)updateConstraints{
    [super updateConstraints];
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
    self.switchCameraBlock?self.switchCameraBlock():nil;

}

- (void)lightControl:(UIButton *)btn{
    [self.recorder switchTorch];
    self.flashLightControlBlock?self.flashLightControlBlock():nil;
}

- (void)startRecord:(UIButton *)btn{
    __weak __typeof (&*self)weakSelf = self;
    [CAAnimation showScaleAnimationInView:btn fromValue:1 ScaleValue:1.3 Repeat:1 Duration:0.3 autoreverses:NO];
    NSURL *url = [NSURL fileURLWithPath:[JoyMediaRecordPlay generateFilePathWithType:@"mp4"]];
    [self.recorder startRecordToFile:url];
    self.startRecordBlock?self.startRecordBlock():nil;
}
                  
- (void)stopRecord:(UIButton *)btn{
    [self.recorder stopCurrentVideoRecording];
    [CAAnimation showScaleAnimationInView:btn fromValue:1.3 ScaleValue:1 Repeat:1 Duration:0.3 autoreverses:NO];
    self.startRecordBlock?self.startRecordBlock():nil;
}

- (void)leaveout:(UIButton *)btn{
    __weak __typeof(&*self)weakSlef = self;
    [UIView animateWithDuration:0.3 animations:^{
        weakSlef.y = SCREEN_H;
    } completion:^(BOOL finished) {
        [weakSlef.recorder.captureSession stopRunning];
        [weakSlef removeFromSuperview];
        weakSlef.cancleRecordBlock?weakSlef.cancleRecordBlock():nil;
    }];
}

-(void)initRecorder{
    if (!_recorder) {
        __weak typeof(self)weakSelf = self;
        _recorder = [[JoyMediaRecordPlay alloc]init];
        [self.layer addSublayer:self.recorder.preViewLayer];
        self.recorder.recordFinishBlock = ^(NSURL *recordUrl){
//            [weakSelf mergeUrl:recordUrl];
            [weakSelf reviewRecordVideoWithUrl:recordUrl];
        };
        _recorder.recordTimeBlock = ^(CGFloat floatValue, CGFloat totalValue){

        };
    }
}

- (void)mergeUrl:(NSURL *)recordUrl{
    __weak typeof(self)weakSelf = self;
    NSString *mergeUrlStr = [JoyMediaRecordPlay generateFilePathWithType:@"mp4"];
    [JoyMediaRecordPlay mergeAndExportVideosAtFileURLs:recordUrl newUrl:mergeUrlStr widthHeightScale:SCREEN_W/SCREEN_H presetName:AVAssetExportPresetHighestQuality mergeSucess:^{
        [weakSelf.recorder removeAVCaptureAudioDeviceInput];
        [weakSelf reviewRecordVideoWithUrl:[NSURL fileURLWithPath:mergeUrlStr]];
    }];
}

- (void)reviewRecordVideoWithUrl:(NSURL *)playUrl{
    JoyPlayerView * playView= [[JoyPlayerView alloc]initWithFrame:self.bounds];
    playView.backgroundColor = JOY_blackColor;
    playView.playUrl = playUrl;
    [[UIApplication sharedApplication].keyWindow addSubview:playView];
    [self.recorder.captureSession stopRunning];
    __weak __typeof (&*self)weakSelf = self;
    playView.playCancleBlock = ^{
        [weakSelf.recorder preareReCord];
    };
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
    [CAAnimation showRotateAnimationInView:self.focusCursor Degree:6.65*M_PI Direction:AxisZ Repeat:1 Duration:1.5];
    [CAAnimation showScaleAnimationInView:self.focusCursor fromValue:2 ScaleValue:1 Repeat:2 Duration:1 autoreverses:YES];
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



#pragma mark 播放视图
@implementation JoyPlayerView


- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {

    }
    return self;
}

- (UIButton *)cancelButton
{
    if (!_cancelButton) {
        _cancelButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
        _cancelButton.bottom = SCREEN_H - 60;
        _cancelButton.centerX = self.centerX;
        
        _cancelButton.layer.masksToBounds = YES;
        _cancelButton.layer.cornerRadius = 25;
        _cancelButton.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.5];
        
        [_cancelButton setImage:[UIImage imageNamed:@"trends_ preview_video_back"] forState:UIControlStateNormal];
        [_cancelButton addTarget:self action:@selector(cancelButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelButton;
}
- (UIButton *)doneButton
{
    if (!_doneButton) {
        _doneButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
        _doneButton.bottom = SCREEN_H - 60;
        _doneButton.centerX = self.centerX;
        _doneButton.layer.masksToBounds = YES;
        _doneButton.layer.cornerRadius = 25;
        _doneButton.backgroundColor = [UIColor whiteColor];
        [_doneButton setImage:[UIImage imageNamed:@"trends_preview_video_done"] forState:UIControlStateNormal];
        [_doneButton addTarget:self action:@selector(saveToPhotoBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _doneButton;
}

- (void)cancelButtonClick{
    self.playCancleBlock?self.playCancleBlock():nil;
    [self removeFromSuperview];
}

- (void)saveToPhotoBtnClick{
    [JoyMediaRecordPlay saveToPhotoWithUrl:_playUrl];
}

- (void)playClick {
    if(self.player.rate==0){ //说明时暂停
        [self.player play];
    }else if(self.player.rate==1){//正在播放
        [self.player pause];
    }
}


- (CALayer *)playerLayer
{
    AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
    playerLayer.frame = self.bounds;
    playerLayer.videoGravity = AVLayerVideoGravityResizeAspect;
    return playerLayer;
}

-(void)setPlayUrl:(NSURL *)playUrl{
    _playUrl = playUrl;
    [self.layer addSublayer:self.playerLayer];
    [self.player play];
    [self addSubview:self.cancelButton];
    [self addSubview:self.doneButton];
    __weak __typeof(&*self)weakSelf = self;
    [UIView animateWithDuration:0.5 animations:^{
        weakSelf.cancelButton.centerX = weakSelf.centerX-100;
        weakSelf.doneButton.centerX = weakSelf.centerX+100;
    }];
}

- (AVPlayer *)player{
    if (!_player) {
        AVPlayerItem *playerItem = [AVPlayerItem playerItemWithURL:self.playUrl];
        _player = [AVPlayer playerWithPlayerItem:playerItem];
        [self addObserverToPlayerItem:playerItem];
    }
    return _player;
}

-(void)playbackFinished:(NSNotification *)notification{
    [self.player seekToTime:kCMTimeZero];
    [self.player play];
}

#pragma mark - notification method
-(void)addObserverToPlayerItem:(AVPlayerItem *)playerItem{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playbackFinished:) name:AVPlayerItemDidPlayToEndTimeNotification object:playerItem];
//    [playerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
//    [playerItem addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];
//    NSLog(@"%s",__func__);
}

-(void)removeObserverFromPlayerItem:(AVPlayerItem *)playerItem{
    NSLog(@"%s",__func__);
//    [playerItem removeObserver:self forKeyPath:@"status"];
//    [playerItem removeObserver:self forKeyPath:@"loadedTimeRanges"];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)dealloc
{
    [self.player pause];
    [self removeObserverFromPlayerItem:self.player.currentItem];
    NSLog(@"%s",__FUNCTION__);
}

@end
