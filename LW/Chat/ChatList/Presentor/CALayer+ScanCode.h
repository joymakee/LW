//
//  CALayer+ScanCode.h
//  bei
//
//  Created by Joymake on 2019/6/24.
//  Copyright © 2019 IB. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

NS_ASSUME_NONNULL_BEGIN

@interface CALayer (ScanCode)

- (void)addScanLayerScanW:(CGFloat)scanW scanH:(CGFloat)scanH cornerWidth:(CGFloat)cornerW;

@end

NS_ASSUME_NONNULL_END
