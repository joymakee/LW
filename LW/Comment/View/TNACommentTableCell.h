//
//  TNACommentTableCell.h
//  CommentDemo
//
//  Created by joymake on 16/2/15.
//  Copyright © 2016年 joymake. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LWBaseCell.h"
#import "CommonImageCollectView.h"
@interface TNACommentTableCell : LWBaseCell
- (void)setCellWithModel:(id)model;
@property (nonatomic,weak)void (^deleteBlock)();
@end
