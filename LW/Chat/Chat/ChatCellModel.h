//
//  ChatCellModel.h
//  LW
//
//  Created by joymake on 2017/4/19.
//  Copyright © 2017年 joymake. All rights reserved.
//

#import <JoyKit/JoyKit.h>

@interface ChatCellModel : JoyCellBaseModel
@property (nonatomic,assign)EChatType chatType;
@property (nonatomic,assign)BOOL isReaded;
@property (nonatomic,copy)NSString *urlPath;
@property (nonatomic,assign)NSUInteger playTotalTime;
@end
