//
//  LWCustomMediaVC.m
//  LW
//
//  Created by Joymake on 2019/7/16.
//  Copyright © 2019 joymake. All rights reserved.
//

#import "LWCustomMediaVC.h"
#import "JoyBaseVC+LWCategory.h"
#import <JoyTableAutoLayoutView.h>
#import "LWMediaInteractor.h"

@interface LWCustomMediaVC ()
@property (nonatomic,strong)JoyTableAutoLayoutView *customListView;
@property (nonatomic,strong)LWCustomMediaInteractor *interactor;
@property (nonatomic,copy)JoyRouteBlock block;

@end

@implementation LWCustomMediaVC

-(void)routeParam:(NSDictionary *)param block:(JoyRouteBlock)block{
    self.block = block;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setBackViewWithImageName:nil bundleName:nil];
    [self.view addSubview:self.customListView];
    self.title = @"节目编辑";
    [self setRightNavItemWithTitle:@"保存"];
    [self setConstraint];
    self.customListView.setDataSource(self.interactor.dataArrayM).reloadTable();
}

-(void)rightNavItemClickAction{
    JoyCellBaseModel *nameModel = self.interactor.dataArrayM.firstObject;
    JoyCellBaseModel *urlModel = self.interactor.dataArrayM.lastObject;
    if (nameModel.title.length && [urlModel.title hasPrefix:@"http"]) {
        self.block?self.block(@{@"title":nameModel.title,@"url":urlModel.title},nil):nil;
        [self goBack];
    }
}

-(void)setConstraint{
    [self.customListView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
}

-(LWCustomMediaInteractor *)interactor{
    return _interactor = _interactor?:[[LWCustomMediaInteractor alloc]init];
}

-(JoyTableAutoLayoutView *)customListView{
    _customListView = _customListView?:[[JoyTableAutoLayoutView alloc]init];
    _customListView.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _customListView.tableView.backgroundColor = [UIColor clearColor];
    return _customListView;
}

@end
