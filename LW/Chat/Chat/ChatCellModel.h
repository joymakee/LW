//
//  ChatCellModel.h
//  LW
//
//  Created by wangguopeng on 2017/4/19.
//  Copyright © 2017年 joymake. All rights reserved.
//

#import <JoyTool/JoyTool.h>

@interface ChatCellModel : JoyCellBaseModel
@property (nonatomic,assign)EChatType chatType;
@property (nonatomic,assign)BOOL isReaded;
@property (nonatomic,copy)NSString *urlPath;
@property (nonatomic,assign)NSUInteger playTotalTime;
@end
