//
//  LoginHeadCell.m
//  LW
//
//  Created by Joymake on 16/6/25.
//  Copyright © 2016年 joymake. All rights reserved.
//

#import "LoginHeadCell.h"

@implementation LoginHeadCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    [self.headImage addLayer];
}

-(void)setCellWithModel:(NSObject *)model{
    __weak __typeof (&*self)weakSelf = self;
    self.headImage.lwImageTouchBlock = ^(ELwTouchActionType touchType){
        if([weakSelf.delegate respondsToSelector:@selector(cellDidSelectWithIndexPath:)]){
            [weakSelf.delegate cellDidSelectWithIndexPath:weakSelf.index];
        }
    };
}

@end
