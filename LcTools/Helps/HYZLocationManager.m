//
//  HYZLocationManager.m
//  LcTools
//
//  Created by 李超 on 2017/12/15.
//  Copyright © 2017年 lichao. All rights reserved.
//

#import "HYZLocationManager.h"

@interface HYZLocationManager () <CLLocationManagerDelegate>

@property(nonatomic, strong) CLLocationManager *locationManager;

@end

@implementation HYZLocationManager

- (void)beginUpdatingLocation {
    
    [self requestLocationAuthorization];
}

#pragma mark -- locationDelegate
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    
    //获取新的位置
    CLLocation *newLocation = locations.lastObject;
    
    //经纬度
//    CLLocationDegrees longitude = newLocation.coordinate.longitude;
//    CLLocationDegrees latitude = newLocation.coordinate.latitude;
    
    //根据经纬度反向地理编译出地址信息
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    
    
    [geocoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        
        if (placemarks.count > 0) {
            CLPlacemark *placemark = placemarks.firstObject;
            
            //存储位置信息
            //placemark.country;             国家
            //placemark.administrativeArea;  省份
            //placemark.locality;            城市
            //placemark.subLocality;         县区
            
            if ([self.delegate respondsToSelector:@selector(locationDidEndUpdatingLocation:placemark:)]) {
                [self.delegate locationDidEndUpdatingLocation:newLocation placemark:placemark];
            }
        }else {
            
            if ([self.delegate respondsToSelector:@selector(locationDidEndUpdatingLocation:placemark:)]) {
                [self.delegate locationDidEndUpdatingLocation:newLocation placemark:nil];
            }
        }
    
    }];
    
    [manager stopUpdatingLocation];
}

//获取定位权限
- (void)requestLocationAuthorization {
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    
    if (status == kCLAuthorizationStatusNotDetermined) {//用户未作出选择
        
        //判断info.plist文件知否配置相关配置
        BOOL hasWhenKey = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"NSLocationWhenInUseUsageDescription"];
        BOOL hasAlwaysKey = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"NSLocationAlwaysAndWhenInUseUsageDescription"];
        
        if (hasWhenKey && hasAlwaysKey) {
            
            [self.locationManager requestWhenInUseAuthorization];
        }else if (hasAlwaysKey) {
            
            [self.locationManager requestAlwaysAuthorization];
        }else if (hasWhenKey) {
            
            [self.locationManager requestWhenInUseAuthorization];
        }else {
            NSLog(@"未配置相关配置文件");
        }
        
    }else if (([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedWhenInUse || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedAlways)){//用户允许
        //启动定位
        [self.locationManager startUpdatingLocation];
    }else {//kCLAuthorizationStatusDenied 用户拒绝
        //定位不能用
        NSLog(@"用户拒绝使用定位");
    }
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    if (status == kCLAuthorizationStatusAuthorizedWhenInUse || status == kCLAuthorizationStatusAuthorizedAlways) {//允许
//        NSLog(@"用户已经允许");
        [self.locationManager startUpdatingLocation];
    }
    if (status == kCLAuthorizationStatusDenied) {//用户已拒绝
        NSLog(@"用户已拒绝,请前往设置打开定位");
    }
}

#pragma mark -- 懒加载
- (CLLocationManager *)locationManager {
    if (!_locationManager) {
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate = self;
        
        //设置定位精度
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        //设置过滤器为无
        _locationManager.distanceFilter = kCLDistanceFilterNone;
        
    }
    return _locationManager;
}


@end
