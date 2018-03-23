//
//  LCLocation.h
//  LcTools
//
//  Created by 李超 on 2017/12/15.
//  Copyright © 2017年 lichao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface LCLocation : NSObject

//经度
@property (nonatomic, assign) CLLocationDegrees longitude;
//纬度
@property (nonatomic, assign) CLLocationDegrees latitude;

//国家
@property (nonatomic, copy) NSString * country;
//省 直辖市
@property (nonatomic, copy) NSString * administrativeArea;
// 地级市 直辖市区
@property (nonatomic, copy) NSString * locality;
//县 区
@property (nonatomic, copy) NSString * subLocality;

@end


////街道
//@property (nonatomic, copy) NSString * thoroughfare;
////子街道
//@property (nonatomic, copy) NSString * subThoroughfare;

