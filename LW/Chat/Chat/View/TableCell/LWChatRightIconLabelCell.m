//
//  LWChatRightIconLabelCell.m
//  LW
//
//  Created by joymake on 2017/2/13.
//  Copyright © 2017年 joymake. All rights reserved.
//

#import "LWChatRightIconLabelCell.h"
#import "ChatCellModel.h"
#import "ChatVoiceView.h"

@interface LWChatRightIconLabelCell ()
@property (weak, nonatomic) IBOutlet UIImageView *avatar;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
//@property (weak, nonatomic) IBOutlet UIImageView *bubbleImage;
@property (weak, nonatomic) IBOutlet UILabel *chatInfoLabel;
@property (weak, nonatomic) IBOutlet ChatVoiceView *voiceView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *voiceWidthConstraint;
@property (weak, nonatomic) IBOutlet UILabel *voiceTimeLabel;
@end

@implementation LWChatRightIconLabelCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setCellWithModel:(ChatCellModel *)model{
    _nameLabel.text = model.title;
    _avatar.layer.cornerRadius = 20;
    _avatar.layer.masksToBounds = YES;
    _chatInfoLabel.layer.masksToBounds = YES;
    _chatInfoLabel.layer.cornerRadius = 5;

    if (model.chatType == EChatContentType) {
        _chatInfoLabel.text = model.subTitle;
        _chatInfoLabel.layer.cornerRadius = 5;
//        self.bubbleImage.image = [[UIImage imageNamed:@"bubble.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(21, 10, 5, 20) resizingMode:UIImageResizingModeStretch];
        self.voiceWidthConstraint.constant = 0;
        self.voiceTimeLabel.text = nil;
    }else if (model.chatType == EChatAudioType){
//        self.bubbleImage.image = nil;
        _chatInfoLabel.text = nil;
        self.voiceView.voiceViewMoel = rightViewModel;
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

    // Configure the view for the selected state
}

@end
