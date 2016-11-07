//
//  LWTableSectionBaseModel
//  Toon
//
//  Created by Joymake on 16/3/23.
//  Copyright © 2016年 Joymake. All rights reserved.
//

#import "LWTableSectionBaseModel.h"

@implementation LWTableSectionBaseModel
-(NSMutableArray *)rowArrayM{
    if (!_rowArrayM) {
        _rowArrayM = [NSMutableArray arrayWithCapacity:0];
    }
    return _rowArrayM;
}

+ (instancetype)sectionWithHeaderModel:(id)sectionHeaderModel footerModel:(id)sectionFooterModel cellModels:(NSArray *)cellModels sectionH:(CGFloat)sectionH sectionTitle:(NSString *)sectionTitle{
    LWTableSectionBaseModel *sectionModel = [[LWTableSectionBaseModel alloc]init];
    sectionModel.sectionH = sectionH;
    sectionModel.sectionTitle = sectionTitle;
    [sectionModel.rowArrayM addObjectsFromArray:cellModels];
    return sectionModel;
}
@end
