//
//  TNALabelCell.m
//  Toon
//
//  Created by Joymake on 16/3/16.
//  Copyright © 2016年 Joymake. All rights reserved.
//

#import "LWLabelCell.h"

@interface LWLabelCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *middleLabel;
@property (weak, nonatomic) IBOutlet UILabel *rightLabel;

@end

@implementation LWLabelCell


- (void)setCellWithModel:(LWCellBaseModel *)model{
    LWCellBaseModel *setModel = (LWCellBaseModel *)model;
    self.titleLabel.text = setModel.title;
    self.rightLabel.text = model.subTitle;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
