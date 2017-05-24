//
//  IntelligenceControlPresentor.m
//  LW
//
//  Created by joymake on 16/8/8.
//  Copyright © 2016年 joymake. All rights reserved.
//

#import "IntelligenceControlPresentor.h"
#import "IntelligenceControlHeadView.h"

@implementation IntelligenceControlPresentor


-(void)setIntelligenceTableView:(JoyTableAutoLayoutView *)intelligenceTableView{
    _intelligenceTableView = intelligenceTableView;
    IntelligenceControlHeadView *headView = [[[NSBundle mainBundle] loadNibNamed:@"IntelligenceControlHeadView" owner:self options:nil] lastObject];
    [_intelligenceTableView.tableView setTableHeaderView:headView];
    __weak __typeof (&*self)weakSelf = self;
    headView.headImageView.lwImageTouchBlock =^(ELwTouchActionType touchType){
        [weakSelf removeTableFrowmSuperViewAnimation];
    };
}

- (void)scanBluetoothDevice{
    __block bool isHaveFoundDevice = NO;
    __weak __typeof (&*self)weakSelf = self;
    [self.intelligenceControlnteractor scanBlueth:^{
        __strong __typeof (&*weakSelf)strongSelf = weakSelf;
        strongSelf.intelligenceTableView.dataArrayM = strongSelf.intelligenceControlnteractor.dataArrayM;
        [strongSelf.intelligenceTableView reloadTableView];
        [weakSelf reloadViewWithFlag:isHaveFoundDevice];
        isHaveFoundDevice =YES;
    }];
}

- (void)reloadViewWithFlag:(BOOL)flag{
    if (!flag) {
        self.intelligenceTableView.frame = CGRectMake(SCREEN_W/2, SCREEN_H/2, 0, 0);
        __weak __typeof (&*self)weakSelf = self;
        [UIView animateWithDuration:4 delay:0 usingSpringWithDamping:0.4 initialSpringVelocity:0.5 options:UIViewAnimationOptionLayoutSubviews animations:^{
            [[UIApplication sharedApplication].keyWindow addSubview:weakSelf.intelligenceTableView];
            weakSelf.intelligenceTableView.frame = [UIApplication sharedApplication].keyWindow.bounds;
        } completion:^(BOOL finished) {
            
        }];
    }
}


-(void)intelligenceCellDidSelect{
    [self scanBluetoothDevice];
}


- (void)removeTableFrowmSuperViewAnimation{
    __weak __typeof (&*self)weakSelf = self;
    
    [UIView animateWithDuration:2 delay:0 usingSpringWithDamping:0 initialSpringVelocity:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
        weakSelf.intelligenceTableView.frame = CGRectMake(SCREEN_W/2, SCREEN_H/2, 0, 0);
    } completion:^(BOOL finished) {
        [weakSelf.intelligenceTableView removeFromSuperview];
    }];
}
@end
