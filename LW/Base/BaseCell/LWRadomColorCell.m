//
//  LWRadomColorCell.m
//  LW
//
//  Created by Joymake on 2019/6/26.
//  Copyright © 2019 joymake. All rights reserved.
//

#import "LWRadomColorCell.h"
#import "Joy.h"
#import "UIColor+JoyColor.h"

@interface LWRadomColorCell ()
@property (strong, nonatomic) UIView *backView;
@property (strong, nonatomic) UILabel *titleLabel;
@property (nonatomic,strong) JoyCellBaseModel   *model;
@end

@implementation LWRadomColorCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = self.contentView.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.backView];
        [self.backView addSubview:self.titleLabel];
        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressAction:)];
        [self.contentView addGestureRecognizer:longPress];
        [self setConstraint];
        [self updateConstraintsIfNeeded];
    }
    return self;
}

-(UILabel *)titleLabel{
    if(!_titleLabel){
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.numberOfLines = 0;
        _titleLabel.font = [UIFont systemFontOfSize:16];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel = _titleLabel?:[[UILabel alloc]init];
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
                   make.leading.mas_equalTo(15).offset(15);
                   make.trailing.mas_equalTo(-15).offset(-15);
                   make.top.mas_equalTo(5).offset(5);
                   make.centerY.mas_equalTo(weakSelf.contentView.mas_centerY);
                   );

    MAS_CONSTRAINT(self.titleLabel,
                   make.leading.mas_equalTo(15).offset(15);
                   make.trailing.mas_equalTo(-15).offset(-15);
                   make.height.mas_greaterThanOrEqualTo(33.5);
                   make.top.mas_equalTo(5).offset(5);
                   make.centerY.mas_equalTo(weakSelf.backView.mas_centerY);
                   );
}
- (void)setCellWithModel:(JoyCellBaseModel *)model{
    self.model = model;
    self.titleLabel.text = model.title;
    if (model.titleColor) {
        self.titleLabel.textColor = KJoyHexColor(model.titleColor,1);
    }

    self.backView.backgroundColor = LW_RADOM_COLOR;
}

- (void)longPressAction:(UILongPressGestureRecognizer *)gesture{
    if (gesture.state == UIGestureRecognizerStateBegan) {
        self.model.longPressAction&&self.longPressBlock?self.longPressBlock():nil;
    }
}
@end
