//
//  LWCollectionReusableView.m
//  LW
//
//  Created by Joymake on 2019/6/26.
//  Copyright © 2019 joymake. All rights reserved.
//

#import "LWCollectionReusableView.h"
#import <JoyKit/JoySectionBaseModel.h>

@implementation LWCollectionReusableView

- (void)setHeaderFooterWithModel:(JoySectionBaseModel *)sectinModel isHeader:(BOOL)isHeader;{
    self.textLabel.text = isHeader?sectinModel.sectionTitle:sectinModel.sectionFootTitle;
    self.textLabel.textColor = [UIColor darkGrayColor];
}
@end
