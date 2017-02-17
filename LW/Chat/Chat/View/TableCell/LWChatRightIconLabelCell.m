//
//  LWChatRightIconLabelCell.m
//  LW
//
//  Created by wangguopeng on 2017/2/13.
//  Copyright © 2017年 joymake. All rights reserved.
//

#import "LWChatRightIconLabelCell.h"
#import "LWCellBaseModel.h"

@interface LWChatRightIconLabelCell ()
@property (weak, nonatomic) IBOutlet UIImageView *avatar;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *bubbleImage;
@property (weak, nonatomic) IBOutlet UILabel *chatInfoLabel;
@end

@implementation LWChatRightIconLabelCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setCellWithModel:(LWCellBaseModel *)model{
    _nameLabel.text = model.title;
    _chatInfoLabel.text = model.subTitle;
    _chatInfoLabel.layer.cornerRadius = 5;
//    _chatInfoLabel.layer.backgroundColor = [UIColor orangeColor].CGColor;
    self.bubbleImage.image = [[UIImage imageNamed:@"bubble.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(31, 10, 10, 20) resizingMode:UIImageResizingModeStretch];
    _avatar.layer.cornerRadius = 20;
    _avatar.layer.masksToBounds = YES;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
