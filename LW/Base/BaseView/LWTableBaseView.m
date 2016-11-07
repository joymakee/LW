//
//  TNATableBaseView.m
//  Toon
//
//  Created by Joymake on 16/4/22.
//  Copyright © 2016年 Joymake. All rights reserved.
//

#import "LWTableBaseView.h"
#import "LWCellBaseModel.h"
#import "LWTableSectionBaseModel.h"

@implementation LWTableBaseView

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [[self.dataArrayM[indexPath.section] rowArrayM][indexPath.row] cellH];
}

@end
