//
//  LWMediaListCell.m
//  LW
//
//  Created by joymake on 16/7/4.
//  Copyright © 2016年 joymake. All rights reserved.
//

#import "LWMediaListCell.h"
#import "LWMediaModel.h"
#import "LWImageView.H"
@interface LWMediaListCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundIV;
@property (weak, nonatomic) IBOutlet UILabel *timeDurationLabel;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@property (weak, nonatomic) IBOutlet UIButton *playBtn;
@property (weak, nonatomic) IBOutlet LWImageView *commentImageView;

@end
@implementation LWMediaListCell

- (void)setCellWithModel:(LWMediaModel *)model{
    self.titleLabel.text = model.title;
    self.countLabel.text = [NSString stringWithFormat:@"%ld.%ld万",model.playCount/10000,model.playCount/1000-model.playCount/10000];
}
- (IBAction)commentAction:(id)sender {
    if ([self.delegate respondsToSelector:@selector(cellDidSelectWithIndexPath:action:)]) {
        [self.delegate cellDidSelectWithIndexPath:self.index action:@"goCommentVC"];
    }
}

@end
