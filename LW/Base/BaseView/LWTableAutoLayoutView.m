//
//  TNAAutoLayoutTableBaseView.m
//  Toon
//
//  Created by Joymake on 16/6/20.
//  Copyright © 2016年 Joymake. All rights reserved.
//

#define KNoInfoSectionH 15
#define KNormalSectionH 40
#import "LWTableSectionBaseModel.h"
#import "LWBaseCell.h"
#import "LWTableAutoLayoutView.h"
#import <objc/message.h>
#import "CAAnimation+HCAnimation.h"

@interface LWTableAutoLayoutView ()<LWBaseCellDelegate>{
    NSMutableArray *registCellArrayM;
}
@end

const NSString *tableHDelegate =  @"tableHDelegate";
@implementation LWTableAutoLayoutView
#pragma mark 动态执行代理
CGFloat tableRowH(id self, SEL _cmd, UITableView *tableView,NSIndexPath *indexPath){
    NSMutableArray *array =  objc_getAssociatedObject(self, &tableHDelegate);
    LWTableSectionBaseModel *sectionModel = [array objectAtIndex:indexPath.section];
    LWCellBaseModel * model  = sectionModel.rowArrayM[indexPath.row];
    return model.cellH;
}

#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        if (!IOS8_OR_LATER)
        {class_addMethod([self class], @selector(tableView:heightForRowAtIndexPath:), (IMP)tableRowH, "f@:@:@");}
        registCellArrayM = [NSMutableArray array];
        [self addSubview:self.tableView];
        [self addSubViewToSelf];
        [self setConstraint];
        [self setNeedsUpdateConstraints];
    }
    return self;
}

//-(void)setIsAutoLayoutType:(EIsAutoLayoutType)isAutoLayoutType{
//    _isAutoLayoutType = isAutoLayoutType;
//    if (self.isAutoLayoutType == ENotAutoLayout | self.isAutoLayoutType == ESemiAutomaticLayout)
//    {class_addMethod([self class], @selector(tableView:heightForRowAtIndexPath:), (IMP)tableRowH, "f@:@:@");}
//}

#pragma mark 供子类扩展使用
- (void)addSubViewToSelf{}

#pragma mark getter method
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.sectionHeaderHeight = 0;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.sectionFooterHeight = 0;
        _tableView.rowHeight = UITableViewAutomaticDimension;
    }
    return _tableView;
}

- (void)setBackView:(UIView *)backView{
    [_tableView setBackgroundView:backView];
    _tableView.backgroundView.contentMode = UIViewContentModeScaleAspectFill;
}

-(void)updateConstraints{
    [super updateConstraints];
    __weak __typeof (&*self)weakSelf = self;
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(weakSelf.mas_leading);
        make.top.equalTo(weakSelf.mas_top);
        make.trailing.equalTo(weakSelf.mas_trailing);
        make.bottom.equalTo(weakSelf.mas_bottom);
    }];
    if (_backView) {
        [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(weakSelf.tableView.mas_leading);
            make.top.equalTo(weakSelf.tableView.mas_top);
            make.trailing.equalTo(weakSelf.tableView.mas_trailing);
            make.bottom.equalTo(weakSelf.tableView.mas_bottom);
        }];
    }
}
#pragma mark 设置约束
-(void)setConstraint{
    __weak __typeof (&*self)weakSelf = self;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(weakSelf.mas_leading);
        make.top.equalTo(weakSelf.mas_top);
        make.trailing.equalTo(weakSelf.mas_trailing);
        make.bottom.equalTo(weakSelf.mas_bottom);
    }];
}

#pragma mark 准备刷新
- (void)beginUpdates{
    [self.tableView beginUpdates];
}

#pragma mark 结束新列
- (void)endUpdates{
    [self.tableView endUpdates];
}

#pragma mark 刷新table
-(void)reloadTableView{
    objc_setAssociatedObject(self, &tableHDelegate, self.dataArrayM, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self.tableView reloadData];
}

#pragma mark 刷新table 的section
- (void)reloadSection:(NSIndexPath *)indexPath{
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationNone];
}

#pragma mark 刷新table 的row
- (void)reloadRow:(NSIndexPath *)indexPath{
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
}

#pragma mark TableDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    LWTableSectionBaseModel*sectionModel = [self.dataArrayM objectAtIndex:section];
    return sectionModel.sectionH?:([sectionModel.sectionTitle length]?KNormalSectionH:KNoInfoSectionH);
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    LWTableSectionBaseModel*sectionModel = [self.dataArrayM objectAtIndex:section];
    sectionModel.sectionH = sectionModel.sectionH?:sectionModel.sectionTitle?KNormalSectionH:KNoInfoSectionH;
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, sectionModel.sectionH)];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0,view.frame.size.width, sectionModel.sectionH)];
    titleLabel.text =  sectionModel.sectionTitle;
    titleLabel.font = [UIFont systemFontOfSize:14];
    titleLabel.textColor = [UIColor lightGrayColor];
    [titleLabel sizeToFit];
    CGFloat titleLabelW = titleLabel.frame.size.width;
    CGFloat titleLabelH = titleLabel.frame.size.height;
    CGFloat titleLabelX = 9;
    CGFloat titleLabelY = sectionModel.sectionH - (7) - titleLabelH;
    titleLabel.frame = CGRectMake(titleLabelX, titleLabelY, titleLabelW, titleLabelH);
    [view addSubview:titleLabel];
    return view;
}


- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
    LWTableSectionBaseModel*sectionModel = [self.dataArrayM objectAtIndex:section];
    return sectionModel.sectionFootTitle;
}

//ios7系统需要计算cell的h
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    LWTableSectionBaseModel*sectionModel = [self.dataArrayM objectAtIndex:indexPath.section];
    LWCellBaseModel * model  = sectionModel.rowArrayM[indexPath.row];
    if(!model.cellH){
        [self registTableCellWithCellModel:model];
        LWBaseCell *cell = [tableView dequeueReusableCellWithIdentifier:model.cellName];
        [cell setCellWithModel:model];
        [cell.contentView setNeedsLayout];
        [cell.contentView layoutIfNeeded];
        CGFloat height = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height+1;
        model.cellH = height;
    }
    return model.cellH;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArrayM.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    LWTableSectionBaseModel*sectionModel = [self.dataArrayM objectAtIndex:section];
    return sectionModel.rowArrayM.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LWTableSectionBaseModel*sectionModel = [self.dataArrayM objectAtIndex:indexPath.section];
    LWCellBaseModel * model  = sectionModel.rowArrayM[indexPath.row];
    [self registTableCellWithCellModel:model];
    LWBaseCell *cell = [tableView dequeueReusableCellWithIdentifier:model.cellName];
    __weak __typeof (&*self)weakSelf = self;
    model.cellBlock =^(id obj,ERefreshScheme scheme){
        [weakSelf.tableView beginUpdates];
        [weakSelf reloadWithScheme:scheme andIndexPath:indexPath andObj:obj];
        [weakSelf.tableView endUpdates];
    };
    cell.delegate = self;
    
    cell.index = indexPath;
    
    [cell setCellWithModel:model];
    
    model.backgroundColor? cell.backgroundColor = model.backgroundColor:nil;
    
    cell.beginUpdatesBlock =^(){
        [weakSelf beginUpdates];
    };
    
    cell.endUpdatesBlock =^(){
        [weakSelf endUpdates];
    };
    
    cell.scrollBlock = ^(NSIndexPath *indexPath,UITableViewScrollPosition scrollPosition,BOOL animated){
        [weakSelf.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:scrollPosition animated:animated];
    };
    
    cell.accessoryType = model.accessoryType;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.contentView.userInteractionEnabled = !model.disable;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.oldSelectIndexPath = self.currentSelectIndexPath;
    self.tableView.contentInset = UIEdgeInsetsZero;
    HIDE_KEYBOARD;
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    LWTableSectionBaseModel *sectionModel = [self.dataArrayM objectAtIndex:indexPath.section];
    LWCellBaseModel * model  = sectionModel.rowArrayM[indexPath.row];
    if (!model.disable) {
        self.currentSelectIndexPath = indexPath;
        self.tableDidSelectBlock?self.tableDidSelectBlock(indexPath):nil;
        [model didSelect];
    }
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.currentSelectIndexPath = nil;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    LWTableSectionBaseModel *sectionModel = [self.dataArrayM objectAtIndex:indexPath.section];
    LWCellBaseModel * model  = sectionModel.rowArrayM[indexPath.row];
    return model.editingStyle;
}
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    LWTableSectionBaseModel *sectionModel = [self.dataArrayM objectAtIndex:indexPath.section];
    LWCellBaseModel * model  = sectionModel.rowArrayM[indexPath.row];
    return model.editingStyle;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    self.tableEditingBlock?self.tableEditingBlock(editingStyle,indexPath):nil;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    LWTableSectionBaseModel *sectionModel = [self.dataArrayM objectAtIndex:indexPath.section];
    
    if(sectionModel.sectionLeadingOffSet){
        [cell respondsToSelector:@selector(setSeparatorInset:)]?[cell setSeparatorInset:UIEdgeInsetsMake(0, sectionModel.sectionLeadingOffSet, 0, 0)]:nil;
        [cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]?[cell setPreservesSuperviewLayoutMargins:NO]:nil;
    }
    else
    {
        [cell respondsToSelector:@selector(setSeparatorInset:)]?[cell setSeparatorInset:UIEdgeInsetsMake(0, KNoInfoSectionH, 0, 0)]:nil;
        [cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]?[cell setPreservesSuperviewLayoutMargins:NO]:nil;
    }
    [CAAnimation showScaleAnimationInView:cell  fromValue:0.7 ScaleValue:1 Repeat:1 Duration:0.3 autoreverses:NO];
}

#pragma mark textDelegate
-(void)textChanged:(NSIndexPath *)selectIndex andText:(NSString *)content andChangedKey:(NSString *)changeTextKey{
    if ([self.delegate respondsToSelector:@selector(textFieldChangedWithIndexPath:andChangedText:andChangedKey:)]&& content) {
        self.currentSelectIndexPath = selectIndex;
        [self.delegate textFieldChangedWithIndexPath:selectIndex andChangedText:content andChangedKey:changeTextKey];
    }
}
- (void)textHasChanged:(NSIndexPath *)selectIndex andText:(NSString *)content andChangedKey:(NSString *)changeTextKey{
    if([self.delegate respondsToSelector:@selector(textHasChanged:andText:andChangedKey:) ] && content){
        self.currentSelectIndexPath = selectIndex;
        [self.delegate textHasChanged:selectIndex andText:content andChangedKey:changeTextKey];
    }
}

-(void)textshouldBeginEditWithTextContainter:(id)textContainer andIndexPath:(NSIndexPath *)indexPath{
    self.currentSelectIndexPath = indexPath;
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 300, 0);
    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}

-(void)textshouldEndEditWithTextContainter:(id)textContainer andIndexPath:(NSIndexPath *)indexPath{
    
}

#pragma mark cell的点击事件
-(void)cellDidSelectWithIndexPath:(NSIndexPath *)indexPath{
    [self tableView:self.tableView didSelectRowAtIndexPath:indexPath];
}

#pragma mark cell 的扩展事件,用于未定义的cell事件
-(void)viewAction:(NSString *)action IndexPath:(NSIndexPath *)indexPath object:(id)obj{
    self.tableCellActionBlock?self.tableCellActionBlock(action,indexPath,obj):nil;
}

#pragma mark scrollDelegate
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    if (scrollView == self.tableView) {
        self.tableView.contentInset = UIEdgeInsetsZero;
        HIDE_KEYBOARD;
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.scrollDelegate respondsToSelector:@selector(scrollDidScroll:)]?[self.scrollDelegate scrollDidScroll:scrollView]:nil;
}

#pragma mark 手势触摸
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    self.tableView.contentInset = UIEdgeInsetsZero;
    HIDE_KEYBOARD;
}

#pragma mark 回刷数据 cellmodel使用
- (void)reloadWithScheme:(ERefreshScheme)scheme andIndexPath:(NSIndexPath *)indexPath andObj:(id)obj{
    switch (scheme) {
        case ERefreshSchemeRow:
            [self reloadRow:indexPath];
            break;
        case ERefreshSchemeSection:
            [self reloadSection:indexPath];
            break;
        case ERefreshSchemeTable:
            [self reloadTableView];
            break;
        case ERefreshSchemeView:
        default:
            break;
    }
    LWTableSectionBaseModel *sectionModel = [self.dataArrayM objectAtIndex:indexPath.section];
    LWCellBaseModel * model  = sectionModel.rowArrayM[indexPath.row];
    model.changeKey?[self textChanged:indexPath andText:obj andChangedKey:model.changeKey]:nil;
}

#pragma mark table 头和尾
- (void)setTableHeaderView:(UIView *)headView{
    [self.tableView setTableHeaderView:headView];
}

- (void)setTableFootView:(UIView *)footView{
    [self.tableView setTableFooterView:footView];
}

-(NSMutableArray *)dataArrayM{
    return _dataArrayM =_dataArrayM?:[NSMutableArray arrayWithCapacity:0];
}

- (void)registTableCellWithCellModel:(LWCellBaseModel *)cellModel{
    if (![registCellArrayM containsObject:cellModel.cellName])
    {
        cellModel.cellType == ECellCodeType?[_tableView registerClass:NSClassFromString(cellModel.cellName) forCellReuseIdentifier:cellModel.cellName]:[_tableView registerNib:[UINib nibWithNibName:cellModel.cellName bundle:nil] forCellReuseIdentifier:cellModel.cellName];
        [registCellArrayM addObject:cellModel.cellName];
    }
}
@end
