//
//  LWLogin_wx&qqCell.m
//  LW
//
//  Created by Joymake on 16/6/25.
//  Copyright © 2016年 joymake. All rights reserved.
//

#import "LWLogin_wx&qqCell.h"
#import "LWImageView.h"
#import <JoyCellBaseModel.h>

@interface LWLogin_wx_qqCell  ()
@property (weak, nonatomic) IBOutlet UIButton *resetPasswordBtn;
@property (weak, nonatomic) IBOutlet LWImageView *wxImageView;
@property (weak, nonatomic) IBOutlet LWImageView *qqImageView;
@property (weak, nonatomic) IBOutlet UIButton *registBtn;

@end
static const void *loginPath = &loginPath;
@implementation LWLogin_wx_qqCell

-(void)setCellWithModel:(NSObject *)model{
    __weak __typeof (&*self)weakSelf = self;
    self.wxImageView.lwImageTouchBlock =^(ELwTouchActionType touchType){
//        [weakSelf tapActionWithPlatform:UMShareToWechatSession];
    };
    self.qqImageView.lwImageTouchBlock =^(ELwTouchActionType touchType){
        [weakSelf tapActionWithPlatform:@"qqLogin"];
    };
    self.registBtn.titleLabel.font = [UIFont fontWithName:@"iconfont" size:25];
    [self.registBtn setTitle:@"\ue631" forState:UIControlStateNormal];
    self.resetPasswordBtn.titleLabel.font = [UIFont fontWithName:@"iconfont" size:25];
    [self.resetPasswordBtn setTitle:@"\ue622" forState:UIControlStateNormal];

}
- (IBAction)registAction:(id)sender {
    [self tapActionWithPlatform:@"registAction"];
}
- (IBAction)resetPasswordAction:(id)sender {
    [self tapActionWithPlatform:@"registPasswordAction"];
}

- (void)tapActionWithPlatform:(NSString *)platform{
    if ([self.delegate respondsToSelector:@selector(cellDidSelectWithIndexPath:action:)]) {
        [self.delegate cellDidSelectWithIndexPath:self.index action:platform];
    }

}
@end
