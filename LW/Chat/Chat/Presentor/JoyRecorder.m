//
//  JoyRecorder.m
//  AudioRecord
//
//  Created by joymake on 2017/4/18.
//  Copyright © 2017年 joymake. All rights reserved.
//

#import "JoyRecorder.h"
#import <AVFoundation/AVFoundation.h>

@interface JoyRecorder ()<AVAudioRecorderDelegate,AVAudioPlayerDelegate>
@property (nonatomic,strong)AVAudioRecorder *audiorecoder;
@property (nonatomic,strong)AVAudioPlayer   *audioPlayer;
@property (nonatomic,strong)NSTimer         *timer;
@property (nonatomic,assign)NSTimeInterval  startRecordTime;


- (NSURL *)getRecordPath;
- (NSDictionary *)getAudioSetting;
- (void)audioPowerChange;

@end

@implementation JoyRecorder
+ (instancetype)shareInstance{
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        instance = [[super alloc]init];
        [instance setAudioSession];
    });
    return instance;
}
#pragma mark -- 监测话筒靠近时播放声音变大
- (void)monitorinObserverOrRemove:(BOOL)state
{
    [[UIDevice currentDevice] setProximityMonitoringEnabled:state]; //建议在播放之前设置yes，播放结束设置NO，这个功能是开启红外感应
    
    if(state)//添加监听
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(sensorStateChange) name:@"UIDeviceProximityStateDidChangeNotification"
                                                   object:nil];
    else//移除监听
        [[NSNotificationCenter defaultCenter] removeObserver:self name:@"UIDeviceProximityStateDidChangeNotification" object:nil];
}
//处理监听触发事件
-(void)sensorStateChange;
{
    //如果此时手机靠近面部放在耳朵旁，那么声音将通过听筒输出，并将屏幕变暗（省电啊）
    if ([[UIDevice currentDevice] proximityState] == YES)
    {
        [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
    }
    else
    {
        NSLog(@"Device is not close to user");
        [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
    }
}

//设置音频会话
-(void)setAudioSession{
    //设置为播放和录音状态，以便可以在录制完之后播放录音
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
    [[AVAudioSession sharedInstance] setActive:YES error:nil];
}

-(AVAudioRecorder *)getRecorder{
    [self setAudioSession];
    NSURL *savePathUrl = [self getRecordPath];
    NSDictionary *audioSetting = [self getAudioSetting];
    NSError *error = nil;
    _audiorecoder = [[AVAudioRecorder alloc]initWithURL:savePathUrl settings:audioSetting error:&error];
    _audiorecoder.delegate = self;
    _audiorecoder.meteringEnabled = YES;//如果要监控声波则必须设置为YES
    if(error){
        NSLog(@"创建录音机对象时发生错误，错误信息：%@",error.localizedDescription);
        return nil;
    }
    return _audiorecoder;
}

//播放器
-(AVAudioPlayer *)getAudioPlayer{
    [self sensorStateChange];
    NSURL *playPath = self.playUrlStrPathFile?[self getPlayPath]:nil;
        NSError *error = nil;
        _audioPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:playPath error:&error];
        _audioPlayer.numberOfLoops = 0;
        _audioPlayer.delegate = self;
        [_audioPlayer prepareToPlay];
        if (error) {
            NSLog(@"创建播放器过程中发生错误，错误信息：%@",error.localizedDescription);
            return nil;
        }
    return _audioPlayer;
}

-(NSTimer *)timer{
    return _timer = _timer?:[NSTimer scheduledTimerWithTimeInterval:0.1f target:self selector:@selector(audioPowerChange) userInfo:nil repeats:YES];
}

- (NSURL *)getRecordPath{
    NSString *urlStr = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingString:[NSString stringWithFormat:@"/%@",self.recordAudioUrlStrPathFile]];
    NSLog(@"urlStr:%@",urlStr);
    return [NSURL fileURLWithPath:urlStr];
}

- (NSURL *)getPlayPath{
    NSString *urlStr = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingString:[NSString stringWithFormat:@"/%@",self.playUrlStrPathFile]];
    NSLog(@"urlStr:%@",urlStr);
    return [NSURL fileURLWithPath:urlStr];

}

//取得录音文件设置
- (NSDictionary *)getAudioSetting{
    NSMutableDictionary *dictM = [NSMutableDictionary dictionary];
    //设置录音格式
    [dictM setObject:@(kAudioFormatLinearPCM) forKey:AVFormatIDKey];
    //设置录音采样率，8000是电话采样率，对于一般录音已经够了
    [dictM setObject:@(8000) forKey:AVSampleRateKey];
    //设置通道,这里采用单声道
    [dictM setObject:@(1) forKey:AVNumberOfChannelsKey];
    //每个采样点位数,分为8、16、24、32
    [dictM setObject:@(8) forKey:AVLinearPCMBitDepthKey];
    //是否使用浮点数采样
    [dictM setObject:@(YES) forKey:AVLinearPCMIsFloatKey];
    //....其他设置等
    return dictM;
}

//录音声波状态设置
-(void)audioPowerChange{
    [self.audiorecoder updateMeters];//更新测量值
    float power = [self.audiorecoder averagePowerForChannel:0];//取得第一个通道的音频，注意音频强度范围时-160到0
    CGFloat progress = (power+160.0)/160;
    self.recordFinishBlock?self.recordFinishBlock(progress):nil;
}

#pragma mark action
- (void)startRecord{
    [self getRecorder];
    self.startRecordTime = self.audiorecoder.deviceCurrentTime;
    if(!self.audiorecoder.isRecording) [self.audiorecoder record];//首次使用应用时如果调用record方法会询问用户是否允许使用麦克风
    self.timer.fireDate = [NSDate distantPast];
}

- (void)pause{
    if(self.audiorecoder.isRecording)[self.audiorecoder pause];
    self.timer.fireDate = [NSDate distantFuture];
}

//恢复录音只需要再次调用record，AVAudioSession会帮助你记录上次录音位置并追加录音
- (void)resumeAction{
    [self startRecord];
}

- (void)stopRecord{
    [self.audiorecoder stop];
    self.timer.fireDate = [NSDate distantFuture];
    [self invalidate];
}

-(void)setPlayUrlStrPathFile:(NSString *)playUrlStrPathFile{
    _playUrlStrPathFile = playUrlStrPathFile;
    [self getAudioPlayer];
}

-(void)playAudio{
    [self monitorinObserverOrRemove:YES];
    if (self.playUrlStrPathFile) {
        if (!self.audioPlayer.isPlaying)[self.audioPlayer play];
    }
}

-(void)stopPlayAudio{
    [self monitorinObserverOrRemove:NO];
    if (self.audioPlayer.isPlaying)[self.audioPlayer stop];
}


#pragma mark 录制完成
-(void)audioRecorderDidFinishRecording:(AVAudioRecorder *)recorder successfully:(BOOL)flag{
    NSLog(@"record End");
    CGFloat recordTime =  recorder.deviceCurrentTime - self.startRecordTime;
    self.recordFinishBlock && recordTime>1?self.recordFinishBlock(recorder.deviceCurrentTime - self.startRecordTime):nil;
}

-(void)audioRecorderEncodeErrorDidOccur:(AVAudioRecorder *)recorder error:(NSError *)error{

}

-(void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag{
    self.playFinishBlock?self.playFinishBlock(nil):nil;
}

-(void)audioPlayerDecodeErrorDidOccur:(AVAudioPlayer *)player error:(NSError *)error{
    self.playFinishBlock?self.playFinishBlock(nil):nil;
}

-(void)invalidate{
    [_timer invalidate];
}

-(void)dealloc{
    [self monitorinObserverOrRemove:NO];
}
@end


@implementation JoyAudioPlayer
+ (instancetype)shareInstance{
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        instance = [[super alloc]init];
    });
    return instance;
}

@end
