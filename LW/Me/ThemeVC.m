//
//  ThemeVC.m
//  LW
//
//  Created by Joymake on 2019/7/4.
//  Copyright © 2019 joymake. All rights reserved.
//

#import "ThemeVC.h"
#import <JoyKit/JoyKit.h>
#import "JoyBaseVC+LWCategory.h"

@interface ThemeVC ()
@property (nonatomic,strong)JoyCollectionView *themeView;
@property (nonatomic,strong)JoyCollectionFlowLayout *flowLayout;
@property (nonatomic,strong)NSMutableArray *dataArrayM;
@end

@implementation ThemeVC

-(void)viewDidLoad{
    [super viewDidLoad];
    [self setBackViewWithImageName:nil bundleName:nil];
    [self setDefaultConstraintWithView:self.themeView andTitle:@"个性换肤"];
    @LwWeak(self);
    self.themeView.setDataSource(self.dataArrayM).reloadCollection().cellDidSelect(^(NSIndexPath *indexPath, NSString *tapAction) {
        @LwStrong(self);
        JoySectionBaseModel *section = [self.dataArrayM objectAtIndex:indexPath.section];
        JoyImageCellBaseModel *model = [section.rowArrayM objectAtIndex:indexPath.row];
        [[NSNotificationCenter defaultCenter]postNotificationName:@"LW_THEME_EXCHANGE" object:model.placeHolderImageStr];
    });
}


-(JoyCollectionView *)themeView{
    if (!_themeView) {
        _themeView = [[JoyCollectionView alloc]initWithFrame:self.view.bounds layout:self.flowLayout];
        _themeView.backgroundColor = _themeView.collectionView.backgroundColor  = [UIColor clearColor];
    }
    return _themeView;
}

-(JoyCollectionFlowLayout *)flowLayout{
    if (!_flowLayout){
        _flowLayout= [[JoyCollectionFlowLayout alloc]initWithType:AlignWithLeft];
        _flowLayout.minimumLineSpacing = 5;
        _flowLayout.minimumInteritemSpacing = 5;
        _flowLayout.sectionInset = UIEdgeInsetsMake(10, 5, 10, 5);
        _flowLayout.estimatedItemSize = CGSizeMake(100, 150);
        _flowLayout.scrollDirection = UICollectionViewScrollPositionCenteredHorizontally;
//        _flowLayout.headerReferenceSize = CGSizeMake(0, 40);
        //        _flowLayout.footerReferenceSize = CGSizeMake(0, 40);
    }
    return _flowLayout;
}

-(NSMutableArray *)dataArrayM{
    if (!_dataArrayM) {
        _dataArrayM = [NSMutableArray array];
        JoySectionBaseModel *section = [JoySectionBaseModel new];
        
        for (NSDictionary *dict in @[@{@"title":@"青青夏日",@"icon":@"shuye.jpg"},
                                     @{@"title":@"简约舒适",@"icon":@"launchScreen.jpg"},
                                     @{@"title":@"酷炫科技",@"icon":@"loginBack.jpg"},
                                     @{@"title":@"拂晓之光",@"icon":@"lw_sky.JPG"},
                                     @{@"title":@"日间黄昏",@"icon":@"lw_dusk.JPG"},
                                     @{@"title":@"可爱香猪",@"icon":@"lw_pig.JPG"},
                                     @{@"title":@"微笑",@"icon":@"lw_smile.JPG"},
                                     @{@"title":@"盖世英雄",@"icon":@"lw_hero.JPG"},
                                     @{@"title":@"蜘蛛侠",@"icon":@"lw_dark.JPG"},
                                     @{@"title":@"调皮粉",@"icon":@"lw_pink.JPG"},
                                     @{@"title":@"灰色都市",@"icon":@"lw_city.JPG"},
                                     @{@"title":@"非你莫属",@"icon":@"lw_hand.JPG"},
                                     @{@"title":@"简搭女生",@"icon":@"lw_girl.JPG"}]) {
            JoyImageCellBaseModel *model = [JoyImageCellBaseModel new];
            model.cellName = @"LWImageTitleCollectionCell";
            model.title = dict[@"title"];
            model.placeHolderImageStr = dict[@"icon"];
            [section.rowArrayM addObject:model];
        }
       
        [_dataArrayM addObject:section];
    }
    return _dataArrayM;
}

@end
