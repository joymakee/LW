//
//  RadomLabelCollectionCell.m
//  LW
//
//  Created by joymake on 16/7/6.
//  Copyright © 2016年 joymake. All rights reserved.
//

#import "RadomLabelCollectionCell.h"
#import <JoyTool.h>
@interface RadomLabelCollectionCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end
@implementation RadomLabelCollectionCell
-(void)setCellWithModel:(JoyImageCellBaseModel *)cellModel{
    self.contentView.backgroundColor=self.backgroundColor = cellModel.backgroundColor;
    self.titleLabel.text = cellModel.title;
    self.imageView.image = [UIImage imageNamed:cellModel.avatar];
}
- (void)awakeFromNib {
    [super awakeFromNib];
}

@end
