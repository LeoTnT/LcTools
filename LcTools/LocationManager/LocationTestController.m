//
//  LocationTestController.m
//  LcTools
//
//  Created by 李超 on 2017/12/15.
//  Copyright © 2017年 lichao. All rights reserved.
//

#import "LocationTestController.h"
#import <CoreLocation/CoreLocation.h>

@interface LocationTestController ()<CLLocationManagerDelegate>

@property(nonatomic, strong) CLLocationManager *locationManager;

@end

@implementation LocationTestController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark -- locationDelegate
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    
    //获取新的位置
    CLLocation *newLocation = locations.lastObject;
    
    //经纬度
    CLLocationDegrees longitude = newLocation.coordinate.longitude;
    CLLocationDegrees latitude = newLocation.coordinate.latitude;
    
    NSLog(@"经纬度:%f-%f", longitude, latitude);
    
    //根据经纬度反向地理编译出地址信息
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    
    [geocoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        
        if (placemarks.count > 0) {
            CLPlacemark *placemark = placemarks.firstObject;
            
            //国家
            NSString *country = placemark.country;
            //省
            NSString *administrativeArea = placemark.administrativeArea;
            //市
            NSString *locality = placemark.locality;
            //县区
            NSString *subLocality = placemark.subLocality;
            
            if (administrativeArea) {
                NSLog(@"定位信息%@%@%@%@", country, administrativeArea, locality, subLocality);
            }else {
                NSLog(@"定位信息%@%@%@", country, locality, subLocality);
            }
        }
    }];
    
    [manager stopUpdatingLocation];
}


//弹框回调
- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    if (status == kCLAuthorizationStatusAuthorizedWhenInUse || status == kCLAuthorizationStatusAuthorizedAlways) {//允许
        NSLog(@"用户已经允许");
    }
    if (status == kCLAuthorizationStatusDenied) {//用户已拒绝
        NSLog(@"用户已拒绝");
    }
}

//获取定位权限
- (void)requestLocationAuthorization {
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    
    if (status == kCLAuthorizationStatusNotDetermined) {//用户未作出选择
        
        //判断info.plist文件知否配置相关配置
        BOOL hasWhenKey = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"NSLocationWhenInUseUsageDescription"];
        BOOL hasAlwaysKey = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"NSLocationAlwaysAndWhenInUseUsageDescription"];
        
        if (hasWhenKey && hasAlwaysKey) {
            
            [_locationManager requestAlwaysAuthorization];
        }else if (hasAlwaysKey) {
            
            [_locationManager requestAlwaysAuthorization];
        }else if (hasWhenKey) {
            
            [_locationManager requestWhenInUseAuthorization];
        }
        
    }else if (([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedWhenInUse || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedAlways)){//用户允许
        
        //定位功能可用
        NSLog(@"------");
    }else {//kCLAuthorizationStatusDenied 用户拒绝
        
        //定位不能用
        NSLog(@"======");
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
        
        [self requestLocationAuthorization];
    }
    return _locationManager;
}



@end
