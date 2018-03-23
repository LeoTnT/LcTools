//
//  LCLocationManager.h
//  LcTools
//
//  Created by 李超 on 2017/12/15.
//  Copyright © 2017年 lichao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LCLocation.h"

@protocol LCLocationDelegate;

@interface LCLocationManager : NSObject

@property (nonatomic, weak) id<LCLocationDelegate> delegate;

//开始定位
- (void)beginUpdatingLocation;

@end

@protocol LCLocationDelegate <NSObject>

- (void)locationDidEndUpdatingLocation:(LCLocation *)location;

@end
