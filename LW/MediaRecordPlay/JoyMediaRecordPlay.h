//
//  JoyMediaRecordPlay.h
//  LW
//
//  Created by wangguopeng on 2017/5/3.
//  Copyright © 2017年 joymake. All rights reserved.
//

//typedef void (^TIMERBLOCK)(NSInteger currentValue,NSInteger totalValue);

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@protocol ReCordPlayProtoCol <NSObject>
- (void)joyRecordTimeCurrentTime:(CGFloat)currentTime totalTime:(CGFloat)totalTime;

- (void)joyCaptureOutput:(AVCaptureFileOutput *)captureOutput didStartRecordingToOutputFileAtURL:(NSURL *)fileURL fromConnections:(NSArray *)connections;

-(void)joyCaptureOutput:(AVCaptureFileOutput *)captureOutput didFinishRecordingToOutputFileAtURL:(NSURL *)outputFileURL fromConnections:(NSArray *)connections error:(NSError *)error;
@end

@interface JoyMediaRecordPlay : NSObject
@property (nonatomic,strong)AVCaptureSession            *captureSession;
@property (nonatomic,strong)AVCaptureVideoPreviewLayer  *preViewLayer;       //视图层
//@property (nonatomic,assign)TIMERBLOCK recordProgressBlock;
//@property (nonatomic,copy)IDBLOCK recordFinishBlock;
@property (nonatomic,weak)id<ReCordPlayProtoCol>        delegate;

#pragma mark 准备录制
- (void)preareReCord;

#pragma mark 设置焦距
- (void)updateVideoScaleAndCropFactor:(CGFloat)scale;

#pragma mark 防抖功能
- (void)openStabilization;

#pragma mark 开始录制
- (void)startRecordToFile:(NSURL *)outPutFile;

#pragma mark 停止录制
- (void)stopCurrentVideoRecording;

#pragma mark 移除输入
-(void)removeAVCaptureAudioDeviceInput;

#pragma mark 手电筒
- (void)switchTorch;

#pragma mark 切换摄像头
- (void)switchCamera;

#pragma mark 设置聚焦点
- (void)setFoucusWithPoint:(CGPoint)point;
@end

@interface JoyMediaRecordPlay (JoyRecorderPrivary)

- (BOOL)isAvailableWithCamera;

- (BOOL)isAvailableWithMic;

- (void)getVideoAuth:(BOOLBLOCK)videoAuth;

- (void)showAlert;

#pragma mark 视频裁剪压缩
+ (void)mergeAndExportVideosAtFileURLs:(NSURL *)fileURL newUrl:(NSString *)mergeFilePath widthHeightScale:(CGFloat)whScalle presetName:(NSString *)presetName mergeSucess:(VOIDBLOCK)mergeSucess;

#pragma mark 视频保存相册
+ (void)saveToPhotoWithUrl:(NSURL *)url;

#pragma mark - 视频地址

+ (NSString *)generateFilePathWithType:(NSString *)fileType;

#pragma mark 获取文件大小
+ (CGFloat)getfileSize:(NSString *)filePath;

@end

