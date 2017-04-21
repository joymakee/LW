//
//  LWChatLeftIconLabelCell.m
//  LW
//
//  Created by wangguopeng on 2017/2/13.
//  Copyright © 2017年 joymake. All rights reserved.
//

#import "LWChatLeftIconLabelCell.h"
#import "ChatCellModel.h"
#import "LWImageView.h"
#import "ChatVoiceView.h"

@interface LWChatLeftIconLabelCell ()
@property (weak, nonatomic) IBOutlet LWImageView *avatar;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *chatInfoLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *voiceWidthConstraint;
@property (weak, nonatomic) IBOutlet ChatVoiceView *voiceView;
@property (weak, nonatomic) IBOutlet UILabel *voiceTimeLabel;
@end

@implementation LWChatLeftIconLabelCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

-(void)setCellWithModel:(ChatCellModel *)model{
    _nameLabel.text = model.title;
    _avatar.layer.cornerRadius = 20;
    _avatar.layer.masksToBounds = YES;
    if (model.chatType == EChatContentType)
    {
        _chatInfoLabel.layer.masksToBounds = YES;
        _chatInfoLabel.layer.cornerRadius = 5;
        _chatInfoLabel.text = model.subTitle;
        self.voiceWidthConstraint.constant = 0;
        self.voiceTimeLabel.text = nil;
    }
    else if (model.chatType == EChatAudioType)
    {
        self.voiceView.voiceViewMoel = leftViewModel;
        _chatInfoLabel.text = nil;
        self.voiceTimeLabel.text = [NSString stringWithFormat:@"%lu\"",(unsigned long)model.playTotalTime];
        self.voiceWidthConstraint.constant = 40 + (model.playTotalTime>10?100:model.playTotalTime*10);
    }
    self.voiceTimeLabel.textColor = model.isReaded?[UIColor lightGrayColor]:[UIColor redColor];
    __weak __typeof (&*self)weakSelf = self;
    model.aToBCellBlock = ^(NSNumber *isStopPlay) {
        [isStopPlay boolValue]?[weakSelf.voiceView stopVoiceAnimation]:[weakSelf.voiceView startVoiceAnimation];
        weakSelf.voiceTimeLabel.textColor = [UIColor lightGrayColor];
    };

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
