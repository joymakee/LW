//
//  InputViewModel.h
//  LW
//
//  Created by wangguopeng on 2017/4/19.
//  Copyright © 2017年 joymake. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChatMessage : NSObject
@property (nonatomic,assign)EChatType chatType;
@property (nonatomic,copy)NSString *message;
@property (nonatomic,copy)NSString *urlPath;
@property (nonatomic,assign)NSUInteger playTotalTime;
@property (nonatomic,strong)NSData *data;
@end
