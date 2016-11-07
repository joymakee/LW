//
//  CommonImageCollectView.m
//  Toon
//
//  Created by joymake on 16/2/18.
//  Copyright © 2016年 Joymake. All rights reserved.
//
#define SCREEN_W [UIScreen mainScreen].bounds.size.width
#define CELL_W  80

#import "CommonImageCollectView.h"
#import "LWBaseCollectionCell.h"
#import "Masonry.h"
#import "LWCellBaseModel.h"
const int KCommon_min_cellSpace = 20;
const int KCommon_min_cellInset = 10;

@interface CommonImageCollectView ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,strong)NSMutableArray *dataArray;
@property (nonatomic,assign) BOOL isUrlDataSource;
@property (nonatomic,assign) BOOL isHideDeleteImage;
@property (nonatomic,assign) BOOL isShake;

@end

@implementation CommonImageCollectView
@synthesize selectStaffLayout = _selectStaffLayout;

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

-(void)setSelectStaffLayout:(UICollectionViewFlowLayout *)selectStaffLayout{
    _selectStaffLayout = selectStaffLayout;
    [_collectionView setCollectionViewLayout:_selectStaffLayout];
}

-(UICollectionViewFlowLayout *)selectStaffLayout{
    if (!_selectStaffLayout) {
        _selectStaffLayout = [[UICollectionViewFlowLayout alloc]init];
        _selectStaffLayout.itemSize = CGSizeMake(CELL_W, CELL_W);//cell的大小
        _selectStaffLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;//滑动方式
        _selectStaffLayout.minimumLineSpacing = KCommon_min_cellSpace;//每行的间距
        _selectStaffLayout.minimumInteritemSpacing = KCommon_min_cellInset;//每行cell内部的间距
//        _selectStaffLayout.sectionInset = UIEdgeInsetsMake(KCommon_min_cellSpace, KCommon_min_cellInset, KCommon_min_cellSpace, KCommon_min_cellInset);
    }
    return _selectStaffLayout;
}

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    __weak __typeof(self)weakSelf  = self;
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.mas_top).offset(0);
        make.bottom.mas_equalTo(weakSelf.mas_bottom).offset(0);
        make.left.mas_equalTo(weakSelf.mas_left).offset(0);
        make.right.mas_equalTo(weakSelf.mas_right).offset(0);
    }];
    [self updateConstraintsIfNeeded];
}

-(void)setUrlStrData:(NSMutableArray *)dataArray{
    self.isUrlDataSource = YES;
    _dataArray = dataArray;
    [self.collectionView reloadData];
//    self.frame = CGRectMake(0, 0, SCREEN_W, self.collectionView.frame.size.height);
}

-(void)setData:(NSMutableArray *)dataArray{
    self.isUrlDataSource = NO;
    _dataArray = dataArray;
    [self.collectionView reloadData];
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
    return self;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    LWCellBaseModel *cellModel = [self.dataArray objectAtIndex:indexPath.row];
    [_collectionView registerNib:[UINib nibWithNibName:cellModel.cellName bundle:nil] forCellWithReuseIdentifier:cellModel.cellName];
    LWBaseCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellModel.cellName forIndexPath:indexPath];
//
//    //最后一张加号
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

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    LWCellBaseModel *cellModel = [self.dataArray objectAtIndex:indexPath.row];
    [cellModel didSelect];
    self.cellDidSelectBlock?self.cellDidSelectBlock(indexPath,collectionView):nil;
}

-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _dataArray.count;
}

@end
