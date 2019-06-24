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
#import <AVFoundation/AVFoundation.h>

@interface LWMediaListCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundIV;
@property (weak, nonatomic) IBOutlet UILabel *timeDurationLabel;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@property (weak, nonatomic) IBOutlet UIButton *playBtn;
@property (weak, nonatomic) IBOutlet LWImageView *commentImageView;
@property (weak, nonatomic) IBOutlet UIView *backView;

@end
@implementation LWMediaListCell

-(void)awakeFromNib{
    [super awakeFromNib];
    self.contentView.backgroundColor = self.backgroundColor = [UIColor clearColor];
    self.backView.layer.cornerRadius = 20;
    self.backView.backgroundColor = self.backgroundColor = [UIColor colorWithWhite:0.7 alpha:0.7];
}

- (void)setCellWithModel:(LWMediaModel *)model{
    self.titleLabel.text = model.title;
    self.countLabel.text = [NSString stringWithFormat:@"%ld.%ld万",model.playCount/10000,model.playCount/1000-model.playCount/10000];
}

- (void)getVideoPreViewImage:(NSString *)strUrlPath block:(IDBLOCK)block{
    NSURL *sourceMovieUrl = [NSURL URLWithString:strUrlPath];
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:sourceMovieUrl options:nil];
    AVAssetImageGenerator *gen = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    gen.appliesPreferredTrackTransform = YES;
    CMTime time = CMTimeMakeWithSeconds(0.0, 600);
    NSError *error = nil;
    CMTime actualTime;
    CGImageRef image = [gen copyCGImageAtTime:time actualTime:&actualTime error:&error];
    UIImage *img = [[UIImage alloc] initWithCGImage:image];
    CGImageRelease(image);
    block?block(img):nil;
    
}
- (IBAction)commentAction:(id)sender {
    if ([self.delegate respondsToSelector:@selector(cellDidSelectWithIndexPath:action:)]) {
        [self.delegate cellDidSelectWithIndexPath:self.index action:@"goCommentVC"];
    }
}

@end
