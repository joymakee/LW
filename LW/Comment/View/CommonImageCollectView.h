//
//  CommonImageCollectView.h
//  Toon
//
//  Created by joymake on 16/2/18.
//  Copyright © 2016年 Joymake. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommonImageCollectView : UIView
@property(nonatomic,strong)UICollectionView *collectionView;
@property (nonatomic,strong)UICollectionViewFlowLayout *selectStaffLayout;
@property (nonatomic,assign)BOOL canAdd;
@property (nonatomic,copy)void (^addImageBlock)();
@property (nonatomic,copy)void (^imageClickBlock)(BOOL isLongPress,NSIndexPath *indexPath);
@property (nonatomic,copy)void (^deleteImageBlock)(NSIndexPath *indexPath);
@property (nonatomic,copy)void (^cellDidSelectBlock)(NSIndexPath *indexPath,UICollectionView *collectionView);

-(void)setUrlStrData:(NSMutableArray *)dataArray;

-(void)setData:(NSMutableArray *)dataArray;

- (void)hideDeleteImage:(BOOL)isShow AndShake:(BOOL)isShake;

@end
