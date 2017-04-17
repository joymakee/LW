//
//  TNACommentTableCell.h
//  CommentDemo
//
//  Created by joymake on 16/2/15.
//  Copyright © 2016年 joymake. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UITableViewCell+JoyCell.h"
#import "CommonImageCollectView.h"
@interface TNACommentTableCell : UITableViewCell
- (void)setCellWithModel:(id)model;
@property (nonatomic,weak)void (^deleteBlock)();
@end
