//
//  RadomLabelCollectionCell.m
//  LW
//
//  Created by joymake on 16/7/6.
//  Copyright © 2016年 joymake. All rights reserved.
//

#import "RadomLabelCollectionCell.h"
#import "LWCellBaseModel.h"
@interface RadomLabelCollectionCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end
@implementation RadomLabelCollectionCell
-(void)setCellWithModel:(LWCellBaseModel *)cellModel{
    self.contentView.backgroundColor=self.backgroundColor = cellModel.backgroundColor;
    self.titleLabel.text = cellModel.title;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
