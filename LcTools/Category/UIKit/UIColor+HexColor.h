//
//  UIColor+HexColor.h
//  LcTools
//
//  Created by lichao on 16/8/2.
//  Copyright © 2016年 lichao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (HexColor)

/**
 *  传入一个16进制的字符串，返回该16进制代表的颜色（默认alpha位1
 */
+ (UIColor *)lc_colorWithHexString:(NSString *)hexColor;

@end
