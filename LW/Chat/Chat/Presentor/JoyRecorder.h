//
//  JoyRecorder.h
//  AudioRecord
//
//  Created by joymake on 2017/4/18.
//  Copyright © 2017年 joymake. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface JoyRecorder : NSObject
+ (instancetype)shareInstance;
@property (nonatomic,copy)NSString *recordAudioUrlStrPathFile; //xx.caf
@property (nonatomic,copy)NSString *playUrlStrPathFile; //xx.caf

@property (nonatomic,copy)FLOATBLOCK recordFinishBlock;
@property (nonatomic,copy)STRINGBLOCK playFinishBlock;


- (void)setAudioSession;

- (void)startRecord;

- (void)pause;

- (void)resumeAction;

- (void)stopRecord;

- (void)playAudio;

-(void)stopPlayAudio;

- (void)invalidate;
@end

@interface JoyAudioPlayer : NSObject
@property (nonatomic,copy)STRINGBLOCK playFinishBlock;

@end
