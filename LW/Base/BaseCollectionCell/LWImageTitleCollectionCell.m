//
//  LWImageTitleCollectionCell.m
//  LW
//
//  Created by Joymake on 2019/7/4.
//  Copyright © 2019 joymake. All rights reserved.
//

#import "LWImageTitleCollectionCell.h"
#import <JoyKit/JoyKit.h>
#import <JoyKit/UIColor+JoyColor.h>

@interface LWImageTitleCollectionCell ()
@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) UILabel *titleLabel;
@end
@implementation LWImageTitleCollectionCell

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self.contentView addSubview:self.imageView];
        [self.contentView addSubview:self.titleLabel];
        [self setConstraint];
    }
    return self;
}

-(instancetype)init{
    if (self = [super init]) {
        [self.contentView addSubview:self.imageView];
        [self.contentView addSubview:self.titleLabel];
        [self setConstraint];
    }
    return self;
}

-(UIImageView *)imageView{
    return _imageView =  _imageView?: [[UIImageView alloc]initWithFrame:CGRectZero];
}

-(UILabel *)titleLabel{
    if(!_titleLabel){
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = [UIFont systemFontOfSize:15];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = [UIColor whiteColor];
    }
    return _titleLabel;
}

-(void)setConstraint{
    MAS_CONSTRAINT(self.imageView,
                   make.leading.mas_equalTo(5);
                   make.width.mas_equalTo((kSCREEN_WIDTH-80)/4);
                   make.height.mas_equalTo(1.5 *(kSCREEN_WIDTH-80)/4);
                   make.top.mas_equalTo(self.contentView.mas_top).offset(5);
                   make.centerX.mas_equalTo(self.contentView);
                   );
    
    MAS_CONSTRAINT(self.titleLabel,
                   make.leading.mas_equalTo(self.contentView).offset(5);
                   make.height.mas_equalTo(20);
                   make.top.mas_equalTo(self.imageView.mas_bottom).offset(5);
                   make.bottom.mas_equalTo(self.contentView).offset(-5);
                   make.centerX.mas_equalTo(self.contentView.mas_centerX);
                   );
}

- (void)setCellWithModel:(JoyImageCellBaseModel *)cellModel{
    self.imageView.layer.cornerRadius = 6;
    [self.imageView joySetImageWithUrlString:cellModel.avatar placeholderImage:[UIImage imageNamed:cellModel.placeHolderImageStr]];
    self.titleLabel.text = cellModel.title;
    if(cellModel.titleColor){
        self.titleLabel.textColor = KJoyHexColor(cellModel.titleColor,1);
    }
}
@end
