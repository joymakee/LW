//
//  LWChatListCell.m
//  LW
//
//  Created by joymake on 2017/2/14.
//  Copyright © 2017年 joymake. All rights reserved.
//

#import "LWChatListCell.h"
#import "LWChatListCellModel.h"

@interface LWChatListCell ()
@property (weak, nonatomic) IBOutlet UILabel *avatar;
//@property (weak, nonatomic) IBOutlet UIImageView *avatar;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *messageCountLabel;
@property (weak, nonatomic) IBOutlet UIView *backView;

@end

@implementation LWChatListCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

-(void)setCellWithModel:(LWChatListCellModel *)model{
    self.avatar.font = [UIFont fontWithName:@"iconFont" size:33];
    self.avatar.text = model.avatar;
    self.avatar.textColor = LW_RADOM_COLOR_NOALPHA;
    self.titleLabel.text = model.title;
    self.subTitleLabel.text = model.subTitle;
    if (model.messageCount) {
        self.messageCountLabel.hidden = NO;
        self.messageCountLabel.layer.masksToBounds = YES;
        self.messageCountLabel.layer.cornerRadius = 10;
        self.messageCountLabel.text =[NSString stringWithFormat:@"%ld",(long)model.messageCount];
    }else{
        self.messageCountLabel.hidden = YES;
    }
    self.backView.backgroundColor = LW_RADOM_COLOR;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
