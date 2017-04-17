//
//  CommentModel.h
//  CommentDemo
//
//  Created by joymake on 16/3/28.
//  Copyright © 2016年 joymake. All rights reserved.
//

#import <JoyTool.h>

@interface CommentModel : JoyCellBaseModel
@property (nonatomic,strong)NSMutableArray *imageArray;
@property (nonatomic,copy)NSString *dateStr;
@property (nonatomic,assign)float  starNumber;

+ (NSString *)getDateStrWithDate:(NSDate *)date;
@end
