//
//  LWChatView.m
//  LW
//
//  Created by joymake on 2017/2/15.
//  Copyright © 2017年 joymake. All rights reserved.
//

#import "LWChatView.h"
#import "InputView.h"
#import "ChatMessage.h"

@interface LWChatView ()
@property (nonatomic,strong)InputView *inputView;
@end

extern const float KDefaultInputViewH;
@implementation LWChatView

-(UIView *)inputView{
    return _inputView = _inputView?:[[InputView alloc]init];
}

#pragma mark 供子类扩展使用
- (void)addSubViewToSelf{
    [self addSubview:self.inputView];
    self.inputView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.6];
    self.inputView.layer.masksToBounds = YES;
    self.inputView.layer.cornerRadius = 4;
    __weak typeof (&*self)weakSelf = self;
    self.inputView.messageBlock = ^(ChatMessage *sendMessage){
        weakSelf.messageBlock?weakSelf.messageBlock(sendMessage):nil;
    };
}

#pragma mark 设置约束
-(void)setConstraint{
    __weak __typeof (&*self)weakSelf = self;
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(weakSelf.mas_leading);
        make.top.equalTo(weakSelf.mas_top);
        make.trailing.equalTo(weakSelf.mas_trailing);
        make.bottom.mas_greaterThanOrEqualTo(_inputView.mas_top).offset(60);
    }];
    
    [self.inputView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(weakSelf.mas_leading);
        make.trailing.equalTo(weakSelf.mas_trailing);
        make.bottom.equalTo(weakSelf.mas_bottom);
        make.height.equalTo(@(KDefaultInputViewH+20));
    }];
}

@end
