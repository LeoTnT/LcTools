//
//  LCLocationManager.m
//  LcTools
//
//  Created by 李超 on 2017/12/15.
//  Copyright © 2017年 lichao. All rights reserved.
//

#import "LCLocationManager.h"

@interface LCLocationManager () <CLLocationManagerDelegate>

@property(nonatomic, strong) CLLocationManager *locationManager;

@end

@implementation LCLocationManager

- (void)beginUpdatingLocation {
    
    [self.locationManager startUpdatingLocation];
}

#pragma mark -- locationDelegate
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    
    //获取新的位置
    CLLocation *newLocation = locations.lastObject;
    //创建自定制位置对象
    LCLocation *location = [[LCLocation alloc] init];
    //经纬度
    location.longitude = newLocation.coordinate.longitude;
    location.latitude = newLocation.coordinate.latitude;
    
    //根据经纬度反向地理编译出地址信息
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    
    
    [geocoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        
        if (placemarks.count > 0) {
            CLPlacemark *placemark = placemarks.firstObject;
            
            //存储位置信息
            location.country = placemark.country;
            location.administrativeArea = placemark.administrativeArea;
            location.locality = placemark.locality;
            location.subLocality = placemark.subLocality;
            
            if ([self.delegate respondsToSelector:@selector(locationDidEndUpdatingLocation:)]) {
                [self.delegate locationDidEndUpdatingLocation:location];
            }
        }

    }];
    
    [manager stopUpdatingLocation];
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
        
        //获取定位权限
        // 一个是 requestAlwaysAuthorization
        // 一个是 requestWhenInUseAuthorization
//        [_locationManager requestAlwaysAuthorization];//iOS8以上使用
    }
    return _locationManager;
}


@end
