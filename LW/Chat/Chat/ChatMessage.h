//
//  InputViewModel.h
//  LW
//
//  Created by joymake on 2017/4/19.
//  Copyright © 2017年 joymake. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChatMessage : NSObject
@property  NSString *messageId;
@property (nonatomic,assign)EChatType chatType;
@property (nonatomic,copy)NSString *userId;
@property (nonatomic,copy)NSString *userName;
@property (nonatomic,copy)NSString *message;
@property (nonatomic,copy)NSString *urlPath;
@property (nonatomic,assign)NSUInteger playTotalTime;
@property (nonatomic,strong)NSData *data;
@end
