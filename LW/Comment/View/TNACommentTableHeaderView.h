//
//  TNACommentTableHeaderView.h
//  CommentDemo
//
//  Created by joymake on 16/2/15.
//  Copyright © 2016年 joymake. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonStarView.h"
typedef NS_ENUM(NSInteger,KScoreNumType) {
    KScoreAllNumType = 0,
    KScoreGoodNumType,
    KScoreMiddleNumType,
    KScoreBacNumType,
    KScoreHasPicNumType
};
@interface TNACommentTableHeaderView : UIView


@property (nonatomic,copy)void (^commentBlock)(KScoreNumType scoreType);
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;

@property (weak, nonatomic) IBOutlet UIImageView *headImageView;

@property (weak, nonatomic) IBOutlet CommonStarView *starView;
@end
