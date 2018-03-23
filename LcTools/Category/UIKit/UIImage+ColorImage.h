//
//  UIImage+ColorImage.h
//  LcTools
//
//  Created by lichao on 2017/4/6.
//  Copyright © 2017年 lichao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ColorImage)


/**
 将color转换为image

 @param color 需要转换的color
 @param imageSize 图片的size
 @return 图
 */
+ (UIImage *)getImageWithColor:(UIColor *)color size:(CGSize)imageSize;

@end
