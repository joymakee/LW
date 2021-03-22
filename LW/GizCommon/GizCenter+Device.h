//
//  GizCenter+Device.h
//  LW
//
//  Created by Joymake on 2021/3/4.
//  Copyright © 2021 joymake. All rights reserved.
//

#import "GizCenter.h"

NS_ASSUME_NONNULL_BEGIN

@interface GizCenter (Device)

- (void)bindDeviceByQRContent:(NSString *)QRContent;
@end

NS_ASSUME_NONNULL_END
