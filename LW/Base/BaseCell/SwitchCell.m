//
//  SwitchCell.m
//  LW
//
//  Created by joymake on 16/8/8.
//  Copyright © 2016年 joymake. All rights reserved.
//

#import "SwitchCell.h"

@interface SwitchCell ()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UISwitch *controlSwitch;
@end

@implementation SwitchCell

-(void)setCellWithModel:(LWCellBaseModel *)model{
    _nameLabel.text = model.title;

}

- (IBAction)valueChanged:(id)sender {
    
}

@end
