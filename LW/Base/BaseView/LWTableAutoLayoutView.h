//
//  TNAAutoLayoutTableBaseView.h
//  Toon
//
//  Created by Joymake on 16/6/20.
//  Copyright © 2016年 Joymake. All rights reserved.
//  autolayout table

//autolayout基类，勿改，若需修改，请建子类修改

#define HIDE_KEYBOARD [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
#import "Masonry.h"

@class LWTableSectionBaseModel;
#pragma mark 是否支持自动布局
typedef NS_ENUM(NSInteger,EIsAutoLayoutType) {
    EIsAutoLayout,//autolayout
    ENotAutoLayout, //非autolayout模式,手动
    ESemiAutomaticLayout//半autolayout自动模式(自动高但走table Height 代理)
};
#pragma mark 文本编辑协议
@protocol TextChangedDelegete <NSObject>
@optional;
#pragma mark 文本取消第一响应时
- (void)textFieldChangedWithIndexPath:(NSIndexPath *)indexPath andChangedText:(NSString *)content andChangedKey:(NSString *)key;
#pragma MARK 文本内容发生变化比如输了一个字符
- (void)textHasChanged:(NSIndexPath *)selectIndex andText:(NSString *)content andChangedKey:(NSString *)changeTextKey;

@end

#pragma MARK 滚动协议
@protocol ScrollDelegate <NSObject>

@optional
- (void)scrollDidScroll:(UIScrollView *)scrollView;

@end

@interface LWTableAutoLayoutView : UIView<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)UIView *backView;
@property (nonatomic,assign)EIsAutoLayoutType isAutoLayoutType; //是否自动布局,默认是
@property (nonatomic,strong)NSMutableArray *dataArrayM;
@property (nonatomic,weak)id<TextChangedDelegete> delegate;
@property (nonatomic,weak)id<ScrollDelegate> scrollDelegate;
@property (nonatomic,strong)NSIndexPath *oldSelectIndexPath;
@property (nonatomic,strong)NSIndexPath *currentSelectIndexPath;

/**
 Description tablecell touch Action
 */
@property (nonatomic,copy)void (^tableDidSelectBlock)(NSIndexPath *indexPath);

/**
 Description tablecell custom Action
 */
@property (nonatomic,copy)void (^tableCellActionBlock)(NSString *action,NSIndexPath *indexPath,id obj);

@property (nonatomic,copy)void (^tableEditingBlock)(UITableViewCellEditingStyle editingStyle,NSIndexPath *indexPath);
#pragma mark  table headview
- (void)setTableHeaderView:(UIView *)headView;

#pragma mark table footview
- (void)setTableFootView:(UIView *)footView;

#pragma mark table 上啦下拉刷新
- (void)setTableRefreshViewWithRefreshBlock:(void(^)(BOOL isDownRefresh))refreshBlock;

#pragma mark 结束刷新
- (void)endRefreshWithNoMoredata;

#pragma mark 刷新整个table
- (void)reloadTableView;

#pragma mark 刷新section
- (void)reloadSection:(NSIndexPath *)indexPath;

#pragma mark 刷新列
- (void)reloadRow:(NSIndexPath *)indexPath;

#pragma mark 设置约束 子类调super时用
- (void)setConstraint;

#pragma mark 准备刷新
- (void)beginUpdates;

#pragma mark 结束新列
- (void)endUpdates;

@end
