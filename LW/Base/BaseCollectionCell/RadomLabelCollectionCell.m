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
