//
//  LWTempratureCell.m
//  LW
//
//  Created by joymake on 2017/5/23.
//  Copyright © 2017年 joymake. All rights reserved.
//

#import "LWTempratureCell.h"
#import "LWTempratureView.h"
#import "LWtempratureCellModel.h"
#import <Joy.h>

@interface LWTempratureCell ()
@property (nonatomic,strong)LWTempratureView *tempratureView;
@property (nonatomic,strong)UILabel *positionLabel;

@end

@implementation LWTempratureCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.tempratureView];
        [self.contentView addSubview:self.positionLabel];
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 15;
        [self setConstraint];
    }
    return  self;
}

-(void)setConstraint{
    __weak __typeof(&*self)weakSelf = self;
    [self.tempratureView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.contentView.mas_top).mas_offset(10);
        make.trailing.mas_equalTo(weakSelf.contentView.mas_trailing).mas_offset(-15);
//        make.centerX.mas_equalTo(weakSelf.contentView.mas_centerX);
        make.height.mas_equalTo(120);
        make.width.mas_equalTo(120);
        make.bottom.mas_equalTo(weakSelf.contentView.mas_bottom).offset(-10);
    }];
    [self updateConstraintsIfNeeded];
}

-(void)setCellWithModel:(LWtempratureCellModel *)model{
    self.tempratureView.currentValue = model.currentValue;
    self.tempratureView.targetValue = model.targetValue;
}

-(LWTempratureView *)tempratureView{
    return _tempratureView = _tempratureView?:[[LWTempratureView alloc]initWithFrame:CGRectZero];
}

-(UILabel *)positionLabel{
    return _positionLabel = _positionLabel?:[[UILabel alloc]init];
}



@end
