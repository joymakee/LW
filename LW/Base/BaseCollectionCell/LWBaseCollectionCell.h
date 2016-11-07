//
//  LWBaseCollectionCell.h
//  LW
//
//  Created by joymake on 16/7/6.
//  Copyright © 2016年 joymake. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TapImageView.h"

@interface LWBaseCollectionCell : UICollectionViewCell
@property (nonatomic,copy)void (^imageClickBlock)(BOOL isLongTap);
@property (nonatomic,copy)void (^deleteImageBlock)(TapImageView *tapView);
@property (nonatomic,copy)void (^addImageBlock)();

- (void)setCellWithModel:(id)cellModel;
- (void)showOrHideDeleteBtn:(BOOL)isHideDelete AndShake:(BOOL)isShake;

@end
