//
//  TNACommentTableHeaderView.m
//  CommentDemo
//
//  Created by joymake on 16/2/15.
//  Copyright © 2016年 joymake. All rights reserved.
//

#import "TNACommentTableHeaderView.h"

@implementation TNACommentTableHeaderView

-(void)awakeFromNib{
    [super awakeFromNib];
    self.starView.canComment = NO;
    self.starView.rating = 4;
    self.headImageView.layer.borderColor = [UIColor orangeColor].CGColor;
}
- (IBAction)touchUpInside:(UIButton *)sender {
    self.commentBlock?self.commentBlock(sender.tag):nil;
}
@end
