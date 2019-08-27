//
//  BackGroundBlurView.m
//  CommentDemo
//
//  Created by joymake on 16/3/31.
//  Copyright © 2016年 joymake. All rights reserved.
//

#import "BackGroundBlurView.h"
#import "UIImage+Extension.h"
#import "Masonry.h"
#import <JoyRequest/Joy_NetCacheTool.h>
@interface BackGroundBlurView ()
@property (nonatomic,strong)UIImageView *blurView;
@end

@implementation BackGroundBlurView


-(UIImageView *)blurView{
    if (!_blurView) {
        _blurView = [[UIImageView alloc]initWithFrame:CGRectZero];
        _blurView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _blurView;
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)awakeFromNib{
    [super awakeFromNib];
    [self addSubview:self.blurView];
    [self configCacheImg];
    [self setConstraint];
    [self setNeedsUpdateConstraints];
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        @LwWeak (self);
        [[NSNotificationCenter defaultCenter]addObserverForName:@"LW_THEME_EXCHANGE" object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
            @LwStrong(self);
            [self themeExchange:note.object];
        }];
        
        [self addSubview:self.blurView];
        [self configCacheImg];
        [self setConstraint];
        [self setNeedsUpdateConstraints];
    }
    return self;
}

#define LW_THEME_KEY @"LW_THEME_KEY"

- (void)configCacheImg{
    NSString *cacheThemeImg = [Joy_NetCacheTool scbuStringCacheForKey:LW_THEME_KEY]?:@"loginBack.jpg";
    [self setBlurImage:[UIImage imageNamed:cacheThemeImg] andBlur:1];
}

- (void)themeExchange:(NSString *)imgStr{
    [Joy_NetCacheTool scbuCacheString:imgStr forKey:LW_THEME_KEY];
    [self setBlurImage:[UIImage imageNamed:imgStr] andBlur:1.8];
}

- (void)setBlurImage:(UIImage *)image andBlur:(CGFloat)blur{
    UIImage *newImage = [image blurredImageWithSize:CGSizeMake(2, 22) tintColor:[UIColor colorWithWhite:0.49 alpha:0.5] saturationDeltaFactor:1 maskImage:nil];
    self.blurView.image = newImage;
}


- (void)setConstraint{
    [_blurView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
}

@end
