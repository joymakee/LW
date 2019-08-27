//
//  LWMediaListCell.m
//  LW
//
//  Created by joymake on 16/7/4.
//  Copyright © 2016年 joymake. All rights reserved.
//

#import "LWMediaListCell.h"
#import "LWMediaModel.h"
#import "LWNewsModel.h"
#import "LWImageView.H"
#import <AVFoundation/AVFoundation.h>
#import <SDWebImage/UIImageView+WebCache.h>

@interface LWMediaListCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subtitleLabel;
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
}


- (void)setCellWithModel:(LWMediaModel *)model{
    self.titleLabel.text = model.title;
    self.subtitleLabel.text = model.subTitle;

    self.countLabel.text = [NSString stringWithFormat:@"%ld.%ld万",model.playCount/10000,model.playCount/1000-model.playCount/10000];
    __weak __typeof(&*self)weakSelf = self;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        UIImage *image = [UIImage imageNamed:model.icon];
        dispatch_async(dispatch_get_main_queue(), ^{
            weakSelf.backgroundIV.image = image;
        });
    });

    self.backView.backgroundColor = LW_RADOM_COLOR;

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


@interface LWNewsListCell ()
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *backImageVIEW;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;
@end


@implementation LWNewsListCell
-(void)awakeFromNib{
    [super awakeFromNib];
    self.contentView.backgroundColor = self.backgroundColor = [UIColor clearColor];
    self.backView.layer.cornerRadius = 20;
}

- (void)setCellWithModel:(LWNewsModel *)model{
    self.titleLabel.text = model.title;
    self.subTitleLabel.text = [NSString stringWithFormat:@"%@\t%@",model.subTitle,model.date];
    @LwWeak(self);
    [self.backImageVIEW sd_setImageWithURL:[NSURL URLWithString:model.avatar] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        @LwStrong(self);
        self.backImageVIEW.image = image;
    }];
    self.backView.backgroundColor = LW_RADOM_COLOR;
}

@end
