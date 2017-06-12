//
//  JoyTextSpeechConversion.m
//  LW
//
//  Created by wangguopeng on 2017/6/9.
//  Copyright © 2017年 joymake. All rights reserved.
//

#import "JoyTextSpeechConversion.h"
#import <AVFoundation/AVSpeechSynthesis.h>  //文字转语音
#import <Speech/Speech.h>                   //语音转文字

@interface JoyTextSpeechConversion ()<AVSpeechSynthesizerDelegate>
@property (nonatomic,strong)AVSpeechSynthesizer *textSpeaker;


//{
//    AVSpeechSynthesizer *av;
//}
//
@end

@implementation JoyTextSpeechConversion

-(AVSpeechSynthesizer *)textSpeaker{
    if (!_textSpeaker) {
        _textSpeaker = [[AVSpeechSynthesizer alloc]init];
        _textSpeaker.delegate = self;
    }
    return _textSpeaker;
}

- (void)speakStr:(NSString *)speakStr{
    AVSpeechUtterance*utterance = [[AVSpeechUtterance alloc]initWithString:speakStr];//需要转换的文字
    
    utterance.rate=0.5;// 设置语速，范围0-1，注意0最慢，1最快；AVSpeechUtteranceMinimumSpeechRate最慢，AVSpeechUtteranceMaximumSpeechRate最快
    
    AVSpeechSynthesisVoice*voice = [AVSpeechSynthesisVoice voiceWithLanguage:@"zh-CN"];//设置发音，这是中文普通话
    
    utterance.voice= voice;
    
    [self.textSpeaker speakUtterance:utterance];//开始

}

- (void)pauseSpeak{
    //[av stopSpeakingAtBoundary:AVSpeechBoundaryWord];//感觉效果一样，对应代理>>>取消
    
    [self.textSpeaker pauseSpeakingAtBoundary:AVSpeechBoundaryWord];//暂停

}

- (void)conitinueSpeak{
    [self.textSpeaker continueSpeaking];
}


- (void)speechSynthesizer:(AVSpeechSynthesizer*)synthesizer didStartSpeechUtterance:(AVSpeechUtterance*)utterance{
    
    NSLog(@"---开始播放");
    
}
- (void)speechSynthesizer:(AVSpeechSynthesizer*)synthesizer didFinishSpeechUtterance:(AVSpeechUtterance*)utterance{
    
    NSLog(@"---完成播放");
    
}
- (void)speechSynthesizer:(AVSpeechSynthesizer*)synthesizer didPauseSpeechUtterance:(AVSpeechUtterance*)utterance{
    
    NSLog(@"---播放中止");
    
}
- (void)speechSynthesizer:(AVSpeechSynthesizer*)synthesizer didContinueSpeechUtterance:(AVSpeechUtterance*)utterance{
    
    NSLog(@"---恢复播放");
    
}
- (void)speechSynthesizer:(AVSpeechSynthesizer*)synthesizer didCancelSpeechUtterance:(AVSpeechUtterance*)utterance{
    
    NSLog(@"---播放取消");
    
}


-(void)startSpeakerConvert{
    //申请用户语音识别权限
    [SFSpeechRecognizer requestAuthorization:^(SFSpeechRecognizerAuthorizationStatus status) {
        NSLog(@"------%ld",(long)status);
//        typedef NS_ENUM(NSInteger, SFSpeechRecognizerAuthorizationStatus) {
//            //结果未知 用户尚未进行选择
//            SFSpeechRecognizerAuthorizationStatusNotDetermined,
//            //用户拒绝授权语音识别
//            SFSpeechRecognizerAuthorizationStatusDenied,
//            //设备不支持语音识别功能
//            SFSpeechRecognizerAuthorizationStatusRestricted,
//            //用户授权语音识别
//            SFSpeechRecognizerAuthorizationStatusAuthorized,
//        } API_AVAILABLE(ios(10.0));
    }];
    
    //初始化
    SFSpeechRecognizer * rec = [[SFSpeechRecognizer alloc]init];
    //文件路径(这里有个坑,url初始化要用 fileURLWithPath,别用URLWithString,UIBoundle也行)

    NSURL * url = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%dxx.caf",arc4random()%100]];
    SFSpeechRecognitionRequest * request = [[SFSpeechURLRecognitionRequest alloc]initWithURL:url];//进行请求
    [rec recognitionTaskWithRequest:request resultHandler:^(SFSpeechRecognitionResult * _Nullable result, NSError * _Nullable error) {
        //打印语音识别的结果字符串
        NSLog(@"*******%@",result.bestTranscription.formattedString);
    }];
}

/*
@property(nonatomic,readonly,getter=isSpeaking)BOOL speaking;//是否正在播放

@property(nonatomic,readonly,getter=isPaused)BOOL paused;//是否暂停
- (BOOL)stopSpeakingAtBoundary:(AVSpeechBoundary)boundary;//取消播放，将会完全停止

- (BOOL)pauseSpeakingAtBoundary:(AVSpeechBoundary)boundary;//暂停播放，将会保存进度

- (BOOL)continueSpeaking;//恢复播放
取消与暂停的两个效果我感觉都一样：

typedefNS_ENUM(NSInteger, AVSpeechBoundary) {
    
    AVSpeechBoundaryImmediate,
    
    AVSpeechBoundaryWord
    
}NS_ENUM_AVAILABLE_IOS(7_0);
@property(nonatomic)floatrate;// 设置语速，范围0-1，注意0最慢，1最快；AVSpeechUtteranceMinimumSpeechRate最慢，AVSpeechUtteranceMaximumSpeechRate最快

@property(nonatomic)floatpitchMultiplier;// [0.5 - 2] Default = 1，声调，不怕逗死你就设成2

@property(nonatomic)floatvolume;// [0-1] Default = 1，音量



avspeech支持的语言种类包括：

"[AVSpeechSynthesisVoice 0x978a0b0] Language: th-TH",

"[AVSpeechSynthesisVoice 0x977a450] Language: pt-BR",

"[AVSpeechSynthesisVoice 0x977a480] Language: sk-SK",

"[AVSpeechSynthesisVoice 0x978ad50] Language: fr-CA",

"[AVSpeechSynthesisVoice 0x978ada0] Language: ro-RO",

"[AVSpeechSynthesisVoice 0x97823f0] Language: no-NO",

"[AVSpeechSynthesisVoice 0x978e7b0] Language: fi-FI",

"[AVSpeechSynthesisVoice 0x978af50] Language: pl-PL",

"[AVSpeechSynthesisVoice 0x978afa0] Language: de-DE",

"[AVSpeechSynthesisVoice 0x978e390] Language: nl-NL",

"[AVSpeechSynthesisVoice 0x978b030] Language: id-ID",

"[AVSpeechSynthesisVoice 0x978b080] Language: tr-TR",

"[AVSpeechSynthesisVoice 0x978b0d0] Language: it-IT",

"[AVSpeechSynthesisVoice 0x978b120] Language: pt-PT",

"[AVSpeechSynthesisVoice 0x978b170] Language: fr-FR",

"[AVSpeechSynthesisVoice 0x978b1c0] Language: ru-RU",

"[AVSpeechSynthesisVoice 0x978b210] Language: es-MX",

"[AVSpeechSynthesisVoice 0x978b2d0] Language: zh-HK",中文(香港)粤语

"[AVSpeechSynthesisVoice 0x978b320] Language: sv-SE",

"[AVSpeechSynthesisVoice 0x978b010] Language: hu-HU",

"[AVSpeechSynthesisVoice 0x978b440] Language: zh-TW",中文(台湾)

"[AVSpeechSynthesisVoice 0x978b490] Language: es-ES",

"[AVSpeechSynthesisVoice 0x978b4e0] Language: zh-CN",中文(普通话)

"[AVSpeechSynthesisVoice 0x978b530] Language: nl-BE",

"[AVSpeechSynthesisVoice 0x978b580] Language: en-GB",英语(英国)

"[AVSpeechSynthesisVoice 0x978b5d0] Language: ar-SA",

"[AVSpeechSynthesisVoice 0x978b620] Language: ko-KR",

"[AVSpeechSynthesisVoice 0x978b670] Language: cs-CZ",

"[AVSpeechSynthesisVoice 0x978b6c0] Language: en-ZA",

"[AVSpeechSynthesisVoice 0x978aed0] Language: en-AU",

"[AVSpeechSynthesisVoice 0x978af20] Language: da-DK",

"[AVSpeechSynthesisVoice 0x978b810] Language: en-US",英语(美国)

"[AVSpeechSynthesisVoice 0x978b860] Language: en-IE",

"[AVSpeechSynthesisVoice 0x978b8b0] Language: hi-IN",

"[AVSpeechSynthesisVoice 0x978b900] Language: el-GR",

"[AVSpeechSynthesisVoice 0x978b950] Language: ja-JP"
 */
@end
