//
//  RadomLabelCollectionCell.m
//  LW
//
//  Created by joymake on 16/7/6.
//  Copyright © 2016年 joymake. All rights reserved.
//

#import "RadomLabelCollectionCell.h"
#import <JoyKit/JoyKit.h>
#import <JoyKit/UIColor+JoyColor.h>
@interface RadomLabelCollectionCell ()
@property (weak, nonatomic)  UILabel *titleLabel;
@property (weak, nonatomic)  UIImageView *imageView;

@end
@implementation RadomLabelCollectionCell

-(void)setCellWithModel:(JoyImageCellBaseModel *)cellModel{
    self.contentView.backgroundColor=self.backgroundColor = [UIColor joyColorWithHEXString:cellModel.backgroundColor];
    self.titleLabel.text = cellModel.title;
    self.imageView.image = [UIImage imageNamed:cellModel.avatar];
    __weak __typeof(&*self)weakSelf = self;
    __block JoyImageCellBaseModel*blockModel = cellModel;
    cellModel.aToBCellBlock = ^(id obj){
        weakSelf.titleLabel.text = blockModel.title;
        weakSelf.imageView.image = [UIImage imageNamed:blockModel.avatar];
    };
}
- (void)awakeFromNib {
    [super awakeFromNib];
}

@end

@interface RadomLabelIconCollectionCell ()
@property (strong, nonatomic)  UILabel *iconLabel;
@property (strong, nonatomic)  UILabel *titleLabel;

@end

@implementation RadomLabelIconCollectionCell

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self.contentView addSubview:self.iconLabel];
        [self.contentView addSubview:self.titleLabel];
        [self setConstraint];
    }
    return self;
}

- (void)setConstraint{
    [self.iconLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.mas_equalTo(95);
        make.centerX.centerY.mas_equalTo(self.contentView);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(10);
        make.trailing.mas_equalTo(-10);
        make.bottom.mas_equalTo(-10);
    }];
}

-(void)setCellWithModel:(JoyImageCellBaseModel *)cellModel{
    self.contentView.backgroundColor=self.backgroundColor = [UIColor joyColorWithHEXString:cellModel.backgroundColor alpha:0.7];
    self.titleLabel.text = cellModel.title;
    self.iconLabel.text = cellModel.subTitle;
    __weak __typeof(&*self)weakSelf = self;
    __block JoyImageCellBaseModel*blockModel = cellModel;
    cellModel.aToBCellBlock = ^(id obj){
        weakSelf.titleLabel.text = blockModel.title;
    };
}

-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = [UIColor whiteColor];
    }
    return _titleLabel;
}

-(UILabel *)iconLabel{
    if (!_iconLabel) {
        _iconLabel = [UILabel new];
        _iconLabel.textAlignment = NSTextAlignmentCenter;
        _iconLabel.font = [UIFont fontWithName:@"iconfont" size:46];
        _iconLabel.textColor = LW_RADOM_COLOR_NOALPHA;
    }
    return _iconLabel;
}


- (void)awakeFromNib {
    [super awakeFromNib];
}

@end
