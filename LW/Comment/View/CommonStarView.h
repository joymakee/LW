//
//  CommonStarView.h
//  CommentDemo
//
//  Created by joymake on 16/2/15.
//  Copyright © 2016年 joymake. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger,STARLEVEL) {
    StarLevel0 = 1,
    StarLevel1 ,
    StarLevel2 ,
    StarLevel3 ,
    StarLevel4
};

@interface CommonStarView : UIView
@property (nonatomic,assign)CGFloat rating;
@property (nonatomic,assign)BOOL canComment;

@end
