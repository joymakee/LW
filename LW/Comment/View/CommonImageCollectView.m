//
//  CommonImageCollectView.m
//  Toon
//
//  Created by joymake on 16/2/18.
//  Copyright © 2016年 Joymake. All rights reserved.
//
#define CELL_W  80

#import "CommonImageCollectView.h"
#import "LWBaseCollectionCell.h"
#import "UIView+VM.h"
#import "Masonry.h"
#import <JoyTool.h>
const int KCommon_min_cellSpace = 20.0f;
const int KCommon_min_cellInset = 10.0f;

@interface CommonImageCollectView ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,strong)NSMutableArray *dataArray;
@property (nonatomic,assign) BOOL isUrlDataSource;
@property (nonatomic,assign) BOOL isHideDeleteImage;
@property (nonatomic,assign) BOOL isShake;
@property (nonatomic,strong) UIPageControl *pageControl;
@property (nonatomic,strong)NSMutableDictionary *registDict;
@end

@implementation CommonImageCollectView
@synthesize selectStaffLayout = _selectStaffLayout;

-(NSMutableDictionary *)registDict{
    return _registDict = _registDict?:[NSMutableDictionary dictionary];
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        _collectionView.scrollsToTop = NO;
        _collectionView=  [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:self.selectStaffLayout];
        _collectionView.backgroundColor = self.backgroundColor;
        _collectionView.scrollEnabled = YES;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
    }
    return _collectionView;
}

- (UIPageControl *)pageControl{
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc]init];
        _pageControl.hidesForSinglePage = YES;
        _pageControl.currentPageIndicatorTintColor = JOY_blueColor;
        _pageControl.pageIndicatorTintColor = JOY_grayColor;
    }
    return _pageControl;
}

-(void)setSelectStaffLayout:(UICollectionViewFlowLayout *)selectStaffLayout{
    _selectStaffLayout = selectStaffLayout;
    [_collectionView setCollectionViewLayout:_selectStaffLayout];
}

-(UICollectionViewFlowLayout *)selectStaffLayout{
    if (!_selectStaffLayout) {
        _selectStaffLayout = [[UICollectionViewFlowLayout alloc]init];
        _selectStaffLayout.itemSize = CGSizeMake(CELL_W, CELL_W);//cell的大小
        _selectStaffLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;//滑动方式
//        _selectStaffLayout.minimumLineSpacing = KCommon_min_cellSpace;//每行的间距
//        _selectStaffLayout.minimumInteritemSpacing = KCommon_min_cellInset;//每行cell内部的间距
//        _selectStaffLayout.sectionInset = UIEdgeInsetsMake(KCommon_min_cellSpace, KCommon_min_cellInset, KCommon_min_cellSpace, KCommon_min_cellInset);
    }
    return _selectStaffLayout;
}

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
}

-(void)setUrlStrData:(NSMutableArray *)dataArray{
    self.isUrlDataSource = YES;
    _dataArray = dataArray;
    [self.collectionView reloadData];
}

-(void)setData:(NSMutableArray *)dataArray{
    self.isUrlDataSource = NO;
    _dataArray = dataArray;
    [self.collectionView reloadData];
    if (self.selectStaffLayout.scrollDirection == UICollectionViewScrollDirectionHorizontal) {
        self.pageControl.numberOfPages = self.collectionView.contentSize.width/SCREEN_W;
    }else{
        self.pageControl.numberOfPages = self.collectionView.contentSize.height/SCREEN_H;
    }
}

- (void)hideDeleteImage:(BOOL)isShow AndShake:(BOOL)isShake{
    self.isHideDeleteImage = isShow;
    self.isShake = isShake;
    [self.collectionView reloadData];
}

-(instancetype)init{
    if (self = [super init]) {
        self.collectionView.delegate = self;
        self.collectionView.dataSource = self;
        self.isHideDeleteImage = YES;
        self.isShake = NO;
        [self addSubview:self.collectionView];
        [self addSubview:self.pageControl];
        [self setConstraint];
    }
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.isHideDeleteImage = YES;
    self.isShake = NO;
    [self addSubview:self.collectionView];
    [self addSubview:self.pageControl];
    [self setConstraint];
    return self;
}

- (void)setConstraint{
    __weak __typeof(self)weakSelf  = self;
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.mas_top).offset(0);
        make.bottom.mas_equalTo(weakSelf.mas_bottom).offset(0);
        make.left.mas_equalTo(weakSelf.mas_left).offset(0);
        make.right.mas_equalTo(weakSelf.mas_right).offset(0);
    }];
    
    [_pageControl mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo (30);
        make.bottom.mas_equalTo(weakSelf.mas_bottom).offset(0);
        make.left.mas_equalTo(weakSelf.mas_left).offset(0);
        make.right.mas_equalTo(weakSelf.mas_right).offset(0);
    }];
    [self updateConstraintsIfNeeded];

}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    JoyCellBaseModel *cellModel = [self.dataArray objectAtIndex:indexPath.row];
    [self registCellWithCellModel:cellModel];
    LWBaseCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellModel.cellName forIndexPath:indexPath];

    __weak __typeof (&*self)weakSelf = self;
    if (self.dataArray.count > indexPath.row) {
        [cell setCellWithModel:[self.dataArray objectAtIndex:indexPath.row]];
        cell.imageClickBlock =^(BOOL isLongPress){
            weakSelf.imageClickBlock?weakSelf.imageClickBlock(isLongPress,indexPath):nil;
        };
        cell.deleteImageBlock =^(TapImageView *tapImageView){
            weakSelf.deleteImageBlock?weakSelf.deleteImageBlock(indexPath):nil;
        };
        [cell showOrHideDeleteBtn:self.isHideDeleteImage AndShake:self.isShake];
    }
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    [self registHeadFootWithCellModel:nil viewForSupplementaryElementOfKind:(NSString *)kind];
    if(kind ==UICollectionElementKindSectionHeader){
    UICollectionReusableView * headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"JoyScrollView" forIndexPath:indexPath];
    [headerView setViewWithModel:nil];
    [headerView setPicSource:@[@"lw_inteligence_livingRoom.jpg",@"lw_inteligence_Bathroom.jpg",@"lw_inteligence_bedroom.jpg",@"lw_inteligence_kitchen.jpg",@"lw_inteligence_garage.jpg"]];
    [headerView setPicInfoSource:@[@"客厅",@"卫生间",@"卧室",@"厨房",@"车库"]];
    return headerView;
    }
    return nil;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    JoyCellBaseModel *cellModel = [self.dataArray objectAtIndex:indexPath.row];
    [cellModel didSelect];
    self.cellDidSelectBlock?self.cellDidSelectBlock(indexPath,cellModel.tapAction):nil;
}

-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _dataArray.count;
}


-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger  contentofsetPage = 0;
    if (self.selectStaffLayout.scrollDirection == UICollectionViewScrollDirectionHorizontal) {
        contentofsetPage = (int)(scrollView.contentOffset.x/SCREEN_W)?:0;
    }else{
        contentofsetPage = (int)(scrollView.contentOffset.y/SCREEN_H)?:0;
    }
    self.pageControl.currentPage  = contentofsetPage;
}

- (void)registCellWithCellModel:(JoyCellBaseModel *)cellModel{
    if (![_registDict objectForKey:cellModel.cellName])
    {
        cellModel.cellType == ECellCodeType?[_collectionView registerClass:NSClassFromString(cellModel.cellName) forCellWithReuseIdentifier:cellModel.cellName]:[_collectionView registerNib:[UINib nibWithNibName:cellModel.cellName bundle:nil] forCellWithReuseIdentifier:cellModel.cellName];
        [_registDict setObject:cellModel.cellName forKey:cellModel.cellName];
    }
}

- (void)registHeadFootWithCellModel:(JoySectionBaseModel *)sectionModel viewForSupplementaryElementOfKind:(NSString *)kind{
    if (![_registDict objectForKey:@"JoyScrollView"])
    {
        [_collectionView registerNib:[UINib nibWithNibName:@"JoyScrollView" bundle:nil] forSupplementaryViewOfKind:(kind ==UICollectionElementKindSectionHeader)?UICollectionElementKindSectionHeader:UICollectionElementKindSectionFooter withReuseIdentifier:@"JoyScrollView"];
        [_registDict setObject:sectionModel.sectionTitle forKey:sectionModel.sectionTitle];
    }
}

@end
