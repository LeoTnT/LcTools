//
//  UIImage+ScreenShot.h
//  LcTools
//
//  Created by lichao on 2017/3/31.
//  Copyright © 2017年 lichao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ScreenShot)

/**
 全屏截图

 @return image
 */
+ (UIImage *)shotScreen;


/**
 截图view生成一张图片

 @param view 要截取的view
 @return UIImage
 */
+ (UIImage *)shotWithView:(UIView *)view;


/**
 截取rect区域的图

 @param rect 需要截取的区域
 @return 图
 */
- (UIImage *)cutImageinRect:(CGRect)rect;


@end
