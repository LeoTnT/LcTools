//
//  HYZLocationManager.h
//  LcTools
//
//  Created by 李超 on 2017/12/15.
//  Copyright © 2017年 lichao. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@protocol HYZLocationDelegate;

@interface HYZLocationManager : NSObject

@property (nonatomic, weak) id<HYZLocationDelegate> delegate;

//开始定位
- (void)beginUpdatingLocation;

@end

@protocol HYZLocationDelegate <NSObject>


/**
 代理方法, 获取经纬度以及地方名

 @param location 获取经纬度
 @param placemark 获取地名
 */
- (void)locationDidEndUpdatingLocation:(CLLocation *)location placemark:(CLPlacemark *)placemark;

@end
