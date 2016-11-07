//
//  LWTableSectionBaseModel
//  Toon
//
//  Created by Joymake on 16/3/23.
//  Copyright © 2016年 Joymake. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface LWTableSectionBaseModel : NSObject
@property (nonatomic,strong)NSMutableArray *rowArrayM;
@property (nonatomic,assign)CGFloat sectionH;
@property (nonatomic,assign)CGFloat sectionFootH;
@property (nonatomic,copy) NSString *sectionTitle;
@property (nonatomic,copy) NSString *sectionSubTitle;
@property (nonatomic,copy) NSString *sectionFootTitle;
@property (nonatomic,copy) NSString *sectionKey;
@property (nonatomic,assign) CGFloat sectionLeadingOffSet;

+ (instancetype)sectionWithHeaderModel:(id)sectionHeaderModel footerModel:(id)sectionFooterModel cellModels:(NSArray *)cellModels sectionH:(CGFloat)sectionH sectionTitle:(NSString *)sectionTitle;
@end
