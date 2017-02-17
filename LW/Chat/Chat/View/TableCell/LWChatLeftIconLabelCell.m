//
//  LWChatLeftIconLabelCell.m
//  LW
//
//  Created by wangguopeng on 2017/2/13.
//  Copyright © 2017年 joymake. All rights reserved.
//

#import "LWChatLeftIconLabelCell.h"
#import "LWCellBaseModel.h"
#import "LWImageView.h"
@interface LWChatLeftIconLabelCell ()
@property (weak, nonatomic) IBOutlet LWImageView *avatar;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *chatInfoLabel;
@end

@implementation LWChatLeftIconLabelCell

- (void)awakeFromNib {
    [super awakeFromNib];
}


-(void)setCellWithModel:(LWCellBaseModel *)model{
    _nameLabel.text = model.title;
    _chatInfoLabel.text = model.subTitle;
    _chatInfoLabel.layer.cornerRadius = 5;
    _chatInfoLabel.layer.backgroundColor = [UIColor purpleColor].CGColor;
    _avatar.layer.cornerRadius = 20;
    _avatar.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
