//
//  CommentModel.m
//  CommentDemo
//
//  Created by joymake on 16/3/28.
//  Copyright © 2016年 joymake. All rights reserved.
//

#import "CommentModel.h"

@implementation CommentModel
-(NSMutableArray *)imageArray{
    if (!_imageArray) {
        _imageArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _imageArray;
}

+ (NSString *)getDateStrWithDate:(NSDate *)date{
    NSDateFormatter *dateFormater = [[NSDateFormatter alloc]init];
    [dateFormater setDateFormat:@"hh:mm"];
    return [dateFormater stringFromDate:date];
}

@end
