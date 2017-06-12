//
//  JoyLocationManager.m
//  LW
//
//  Created by wangguopeng on 2017/6/9.
//  Copyright © 2017年 joymake. All rights reserved.
//

#import "JoyLocationManager.h"
#import <CoreLocation/CoreLocation.h>
#import <JoyAlert.h>
#import <objc/runtime.h>

@interface JoyLocationManager ()<CLLocationManagerDelegate>
@property (nonatomic,strong)CLLocationManager *locationManager;
@end

@implementation JoyLocationManager
-(CLLocationManager *)locationManager{
    if (!_locationManager){
        _locationManager = [[CLLocationManager alloc]init];
        _locationManager.delegate = self;
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        _locationManager.distanceFilter = 10.0f;        
    }
    return _locationManager;
}

/*
 pausesLocationUpdatesAutomatically  如果这个属性设置成YES（默认的也是YES），那么系统会检测如果设备有一段时间没有移动，就会自动停掉位置更新服务。这里需要注意的是，一旦定位服务停止了，只有当用户再次开启App的时候定位服务才会重新启动。
 这里的一段时间是系统自动判定的，可以通过设置activityTypeproperty这个属性来决定这个时间的长短。
 API的意思是，类似导航类的App,系统检验的时间会稍长一点，想运动类的App，就会比导航类的短一点。但是具体时间还是由系统来决定
 */
- (void)setInUseAuthorizationMode{
    if([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]){
        [self.locationManager requestWhenInUseAuthorization];
    }
    _locationManager.pausesLocationUpdatesAutomatically = YES;

}

- (void)setAlwaysAuthorizationMode{
    if ([self.locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
        [self.locationManager requestAlwaysAuthorization];
    }
    _locationManager.pausesLocationUpdatesAutomatically = NO;
    if ([self.locationManager respondsToSelector:@selector(setAllowsBackgroundLocationUpdates:)]) {
        [self.locationManager setAllowsBackgroundLocationUpdates:YES];
    }
}

#pragma mark 检查权限
-(JoyLocationManager *(^)(BOOL))checkAuthorization{
    __weak __typeof(&*self)weakSelf = self;
    return ^(BOOL backGroundModel){
        [weakSelf checkAuthorStateAndSetBackModel:backGroundModel];
        return weakSelf;
    };
}

#pragma mark 开始定位
-(JoyLocationManager *(^)())startLocation{
    __weak __typeof(&*self)weakSelf = self;
    return ^(){
        [weakSelf startManagerLocation];
        return weakSelf;
    };
}

#pragma mark 结束定位
-(JoyLocationManager *(^)())stopLocation{
    __weak __typeof(&*self)weakSelf = self;
    return ^(){
        [weakSelf stopManagerLocation];
        return weakSelf;
    };
}

#pragma mark 定位成功
-(JoyLocationManager *(^)(IDBLOCK block))locationSuccess{
    __weak __typeof(&*self)weakSelf = self;
    return ^(IDBLOCK block){
        objc_setAssociatedObject(weakSelf, _cmd, block, OBJC_ASSOCIATION_COPY);
        return weakSelf;
    };
}
#pragma mark 定位失败
-(JoyLocationManager *(^)(ERRORBLOCK))locationError{
    __weak __typeof(&*self)weakSelf = self;
    return ^(ERRORBLOCK block){
        objc_setAssociatedObject(weakSelf, _cmd, block, OBJC_ASSOCIATION_COPY);
        return weakSelf;
    };
}

#pragma mark 更新角度
-(JoyLocationManager *(^)())startUpdateHeading{
    __weak __typeof(&*self)weakSelf = self;
    return ^(){
        [weakSelf.locationManager startUpdatingHeading];
        return weakSelf;
    };
}

#pragma mark 更新角度成功
-(JoyLocationManager *(^)(FLOATBLOCK))headUpdateSuccess{
    __weak __typeof(&*self)weakSelf = self;
    return ^(FLOATBLOCK block){
        objc_setAssociatedObject(weakSelf, _cmd, block, OBJC_ASSOCIATION_COPY);
        return weakSelf;
    };
}

#pragma mark 停止更新角度
-(JoyLocationManager *(^)())stopUpdateHeading{
    __weak __typeof(&*self)weakSelf = self;
    return ^(){
        [weakSelf.locationManager stopUpdatingHeading];
        return weakSelf;
    };
}

- (void)checkAuthorStateAndSetBackModel:(BOOL)backModel{
    switch ([CLLocationManager authorizationStatus]) {
        case kCLAuthorizationStatusNotDetermined:
            backModel?[self setAlwaysAuthorizationMode]:[self setInUseAuthorizationMode];
            [self.locationManager requestWhenInUseAuthorization];
            break;
        case kCLAuthorizationStatusDenied:
            [JoyAlert showWithMessage:@"请在设置中开启授权"];
            break;
        default:
            break;
    }
}

#pragma mark 开始更新定位
- (void)startManagerLocation{
    [self.locationManager startUpdatingLocation];
    [self.locationManager startUpdatingHeading];
}

#pragma mark 定位代理   
//CLLocation这个类里面包括的一些常用的位置信息有经度、纬度、海拔、速度、精确度
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    [self reverseGEOCodeLocation:locations.firstObject];
//    [self stopManagerLocation];
}

#pragma mark 定位失败
-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    ERRORBLOCK successBlock = objc_getAssociatedObject(self, @selector(locationError));
    successBlock?successBlock(error):nil;
}

#pragma mark 角度更新成功
-(void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading{
    CGFloat rotation = -newHeading.magneticHeading/180 * M_PI;
    FLOATBLOCK rotationBlock = objc_getAssociatedObject(self, @selector(headUpdateSuccess));
    rotationBlock?rotationBlock(rotation):nil;
}

- (void)reverseGEOCodeLocation:(CLLocation *)location{
    CLGeocoder *revGeo = [[CLGeocoder alloc] init];
    [revGeo reverseGeocodeLocation:location
                 completionHandler:^(NSArray *placemarks, NSError *error) {
                     if (!error && [placemarks count] > 0)
                     {
                         NSDictionary *dict =
                         [[placemarks objectAtIndex:0] addressDictionary];
                         IDBLOCK successBlock = objc_getAssociatedObject(self, @selector(locationSuccess));
                         successBlock?successBlock(dict):nil;
                     }else{
                         NSLog(@"ERROR: %@", error);
                     }
                 }];
}

- (void)stopManagerLocation{
    [self.locationManager stopUpdatingLocation];
}
@end
