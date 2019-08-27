//
//  MeVC.m
//  LW
//
//  Created by Joymake on 2019/7/4.
//  Copyright © 2019 joymake. All rights reserved.
//

#import "MeVC.h"
#import <JoyKit/JoyKit.h>
#import "JoyBaseVC+LWCategory.h"
#import "LWUser.h"
#import <JoyKit/JoyRouter.h>
#import "ThemeVC.h"

@interface MeVC ()
@property (nonatomic,strong)JoyTableAutoLayoutView *meListView;
@property (nonatomic,strong)NSMutableArray *dataArrayM;

@end

@implementation MeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的";
    [self setRectEdgeAll];
    [self setBackViewWithImageName:nil bundleName:nil];
    [self setDefaultConstraintWithView:self.meListView andTitle:nil];
    self.meListView.setDataSource(self.dataArrayM).reloadTable().cellDidSelect(^(NSIndexPath *indexPath, NSString *tapAction) {
        [super performTapAction:tapAction];
    }).cellTextEiditEnd(^(NSIndexPath *indexPath, NSString *content, NSString *key) {
    });
}

- (void)themeAction{
    ThemeVC *vc = [ThemeVC new];
    vc.hidesBottomBarWhenPushed = YES;
    [self goVC:vc];
}

- (void)loginOutAction{
    [[LWUser shareInstance] loginOut];
    [[JoyRouter sharedInstance] openNativeWithUrl:[NSURL URLWithString:@"joylw://tabBar/login"]];;
}

-(JoyTableAutoLayoutView *)meListView{
    if (!_meListView) {
        _meListView = [[JoyTableAutoLayoutView alloc]init];
        _meListView.backgroundColor = _meListView.tableView.backgroundColor = [UIColor clearColor];
        _meListView.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _meListView;
}

-(NSMutableArray *)dataArrayM{
    if (!_dataArrayM) {
        _dataArrayM = [NSMutableArray array];
        for (NSDictionary *dict in @[@{@"title":@"个性换肤",@"icon":@"\ue600",@"tapAction":@"themeAction"},
                                     @{@"title":@"退出登录",@"icon":@"\uea86",@"tapAction":@"loginOutAction"}]) {
            JoyCellBaseModel *cellModel = [[JoyCellBaseModel alloc]init];
            cellModel.title = dict[@"title"];
            cellModel.subTitle = dict[@"icon"];
            cellModel.cellName =@"LWIconTextCell";
            cellModel.tapAction = dict[@"tapAction"];
            [_dataArrayM addObject:cellModel];
        }
    }
    return _dataArrayM;
}
@end
