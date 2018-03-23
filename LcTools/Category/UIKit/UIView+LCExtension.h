//
//  NSObject+LCExtension.h
//
//  Created by lichao on 15/11/29.
//  Copyright © 2015年 lichao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (LCExtension)

@property(nonatomic, assign) CGFloat lc_width;
@property(nonatomic, assign) CGFloat lc_height;

@property(nonatomic, assign) CGFloat lc_x;
@property(nonatomic, assign) CGFloat lc_y;

@property(nonatomic, assign) CGFloat lc_centerX;
@property(nonatomic, assign) CGFloat lc_centerY;

+ (instancetype)lc_viewFromNib;

/**
 *  判断self和view是否重叠
 */
- (BOOL)lc_intersectsWithView:(UIView *)view;

@end
