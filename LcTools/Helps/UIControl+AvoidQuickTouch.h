//
//  UIControl+AvoidQuickTouch.h
//  AvoidButtonQuickClick
//
//  Created by 刘威振 on 11/30/15.
//  Copyright © 2015 LiuWeiZhen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIControl (AvoidQuickTouch)

@property (nonatomic) NSTimeInterval minimumEventInterval; // 用以标识最短间隔时间

@end

/** 
 使用方法
 */
//    self.button.minimumEventInterval = 2; // 设置最小间隔时间，在2秒内多次点击只会响应第一次点击
