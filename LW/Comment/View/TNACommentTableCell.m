//
//  TNACommentTableCell.m
//  CommentDemo
//
//  Created by joymake on 16/2/15.
//  Copyright © 2016年 joymake. All rights reserved.
//

#import "TNACommentTableCell.h"
#import "CommonStarView.h"
#import "XHImageViewer.h"
#import "CommentModel.h"
#import <JoyTool.h>

@interface TNACommentTableCell()<UIGestureRecognizerDelegate>{
    float lastScale;

}
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet CommonStarView *starView;
@property (weak, nonatomic) IBOutlet CommonImageCollectView *imageCollectionView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *collectionConstraintH;
@property (nonatomic,strong) UIImageView *fullScreenImageView;
@end
@implementation TNACommentTableCell

- (void)setCellWithModel:(CommentModel *)model{
    self.starView.canComment = NO;
    self.collectionConstraintH.constant = model.imageArray.count?80:0;
    __weak __typeof (&*self)weakSelf = self;
    self.imageCollectionView.imageClickBlock =^(BOOL isLongPress,NSIndexPath *indexPath){
        [weakSelf imageBtnClick:indexPath andSource:model.imageArray];
    };
    [self setNeedsUpdateConstraints];
    [self.imageCollectionView setData:model.imageArray];
    self.timeLabel.text = model.dateStr;
    self.commentLabel.text = model.subTitle;
    self.nameLabel.text = model.title;
    self.starView.rating = model.starNumber;
    self.contentView.clipsToBounds = YES;
}

- (void)imageBtnClick:(NSIndexPath *)indexPath andSource:(NSArray *)array {
    __block NSMutableArray *datasArray = [NSMutableArray arrayWithCapacity:0];
    [array enumerateObjectsUsingBlock:^(JoyImageCellBaseModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(-1, -1, 1, 1)];
        SDIMAGE_LOAD(imageView, obj.avatar, obj.placeHolderImageStr);
        [datasArray addObject:imageView];
    }];
    XHImageViewer *image = [[XHImageViewer alloc] init];
    [image showWithImageViews:datasArray selectedView:datasArray[indexPath.row] andTag:1];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
