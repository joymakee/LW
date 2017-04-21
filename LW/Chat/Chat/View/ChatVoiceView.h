//
//  ChatVoiceView.h
//  LW
//
//  Created by wangguopeng on 2017/4/19.
//  Copyright © 2017年 joymake. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,EVoiceViewModel){
    EVoiceLeftModel,
    EVoiceRighttModel
};

@interface ChatVoiceView : UIView
@property (nonatomic,assign)EVoiceViewModel voiceViewMoel;
- (void)startVoiceAnimation;
- (void)stopVoiceAnimation;
@end
