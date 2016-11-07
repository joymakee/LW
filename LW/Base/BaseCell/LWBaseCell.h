//
//  TNAStaffSetBaseCell.h
//  Toon
//
//  Created by Joymake on 16/3/16.
//  Copyright © 2016年 Joymake. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LWCellBaseModel.h"

@protocol LWBaseCellDelegate <NSObject>
@optional
#pragma mark 编辑结束时 子类选调
- (void)textChanged:(NSIndexPath *)selectIndex andText:(NSString *)content andChangedKey:(NSString *)changeTextKey;
#pragma mark 字符发生变化时
- (void)textHasChanged:(NSIndexPath *)selectIndex andText:(NSString *)content andChangedKey:(NSString *)changeTextKey;

- (void)textshouldBeginEditWithTextContainter:(id)textContainer andIndexPath:(NSIndexPath *)indexPath;

- (void)textshouldEndEditWithTextContainter:(id)textContainer andIndexPath:(NSIndexPath *)indexPath;

- (void)textViewDidChange:(UITextView *)textView andIndex:(NSIndexPath *)indexPath;

- (void)cellDidSelectWithIndexPath:(NSIndexPath *)indexPath;

- (void)viewAction:(NSString *)action IndexPath:(NSIndexPath *)indexPath object:(id)obj;

@end
@interface LWBaseCell : UITableViewCell
//子类实现
- (void)setCellWithModel:(NSObject *)model;

@property (strong, nonatomic) NSIndexPath * index;

@property (nonatomic,weak) id<LWBaseCellDelegate> delegate;

@property (assign, nonatomic) NSInteger maxNum;

@property (nonatomic,copy)void (^beginUpdatesBlock)();

@property (nonatomic,copy)void (^endUpdatesBlock)();

@property (nonatomic,copy)void (^scrollBlock)(NSIndexPath *indexPath,UITableViewScrollPosition scrollPosition,BOOL animated);

@end
