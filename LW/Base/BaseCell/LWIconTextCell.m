//
//  LWIconTextCell.m
//  LW
//
//  Created by Joymake on 2019/6/28.
//  Copyright © 2019 joymake. All rights reserved.
//

#import "LWIconTextCell.h"
#import "Joy.h"
#import "UIColor+JoyColor.h"

@interface LWIconTextCell ()
@property (strong, nonatomic) UIView *backView;
@property (strong, nonatomic) UILabel *iconLabel;
@property (strong, nonatomic) UILabel *titleLabel;
@property (nonatomic,strong) JoyCellBaseModel   *model;
@end

@implementation LWIconTextCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = self.contentView.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.backView];
        [self.backView addSubview:self.iconLabel];
        [self.backView addSubview:self.titleLabel];
        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressAction:)];
        [self.contentView addGestureRecognizer:longPress];
        [self setConstraint];
        [self updateConstraintsIfNeeded];
    }
    return self;
}

-(UILabel *)iconLabel{
    if (!_iconLabel) {
        _iconLabel = [UILabel new];
        _iconLabel.textAlignment = NSTextAlignmentCenter;
        _iconLabel.font = [UIFont fontWithName:@"iconfont" size:45];
    }
    return _iconLabel;
}

-(UILabel *)titleLabel{
    if(!_titleLabel){
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.numberOfLines = 0;
        _titleLabel.font =  [UIFont fontWithName:@"iconfont" size:16];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _titleLabel;
}

-(UIView *)backView{
    if (!_backView) {
        _backView = [UIView new];
        _backView.backgroundColor = [UIColor orangeColor];
        _backView.layer.cornerRadius = 10;
    }
    return _backView;
}

-(void)setConstraint{
    __weak __typeof(&*self)weakSelf = self;
    MAS_CONSTRAINT(self.backView,
                   make.leading.mas_equalTo(15);
                   make.trailing.mas_equalTo(-15);
                   make.top.mas_equalTo(5);
                   make.centerY.mas_equalTo(weakSelf.contentView.mas_centerY);
                   );
    
    MAS_CONSTRAINT(self.iconLabel,
                   make.leading.mas_equalTo(15);
                   make.height.width.mas_equalTo(50);
                   make.centerY.mas_equalTo(self.backView);
                   make.top.mas_equalTo(5);
                   );
    
    MAS_CONSTRAINT(self.titleLabel,
                   make.leading.mas_equalTo(self.iconLabel.mas_trailing).mas_offset(15);
                   make.trailing.mas_equalTo(-15);
                   make.centerY.mas_equalTo(weakSelf.backView.mas_centerY);
                   );
}
- (void)setCellWithModel:(JoyImageCellBaseModel *)model{
    self.model = model;
    self.titleLabel.text = model.title;
    if (model.titleColor) {
        self.titleLabel.textColor = KJoyHexColor(model.titleColor,1);
    }
    self.iconLabel.text = model.subTitle;;
    self.iconLabel.textColor = LW_RADOM_COLOR_NOALPHA;
    self.backView.backgroundColor = LW_RADOM_COLOR;
    
}

- (void)longPressAction:(UILongPressGestureRecognizer *)gesture{
    if (gesture.state == UIGestureRecognizerStateBegan) {
        self.model.longPressAction&&self.longPressBlock?self.longPressBlock():nil;
    }
}
@end
