//
//  LWLeftIconCell.m
//  LW
//
//  Created by Joymake on 2016/10/27.
//  Copyright © 2016年 joymake. All rights reserved.
//

#import "LWLeftIconCell.h"
#import "LWCellBaseModel.h"
#import "UIImageView+WebCache.h"

@interface LWLeftIconCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation LWLeftIconCell


-(void)setCellWithModel:(LWCellBaseImageModel *)model{
    [_iconImageView sd_setImageWithURL:[NSURL URLWithString:model.avatar] placeholderImage:[UIImage imageNamed:model.placeHolderImageStr]];
    if (model.viewShape == EImageTypeRound)
    {
        _iconImageView.layer.masksToBounds = YES;
        _iconImageView.layer.cornerRadius = _iconImageView.width/2;
    }else
    {
        _iconImageView.layer.masksToBounds = NO;
    }
    _titleLabel.text = model.title;
    
}


@end
