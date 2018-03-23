//
//  UIImage+ScreenShot.m
//  LcTools
//
//  Created by lichao on 2017/3/31.
//  Copyright © 2017年 lichao. All rights reserved.
//

#import "UIImage+ScreenShot.h"

@implementation UIImage (ScreenShot)


#pragma mark -- 全屏截图
+ (UIImage *)shotScreen{
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    UIGraphicsBeginImageContext(window.bounds.size);
    [window.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

#pragma mark -- 截取view生成一张图片
+ (UIImage *)shotWithView:(UIView *)view{
    
    UIGraphicsGetImageFromCurrentImageContext();
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

#pragma mark -- 截取某个区域的图片
- (UIImage *)cutImageinRect:(CGRect)rect{
    
    //把像 素rect 转化为点rect（如无转化则按原图像素取部分图片）
    CGFloat scale = [UIScreen mainScreen].scale;
    CGFloat x = rect.origin.x * scale, y = rect.origin.y * scale, w = rect.size.width * scale, h = rect.size.height * scale;
    CGRect dianRect = CGRectMake(x, y, w, h);
    
    //截取部分图片并生成新图片
    CGImageRef sourceImageRef = [self CGImage];
    CGImageRef newImageRef = CGImageCreateWithImageInRect(sourceImageRef, dianRect);
    UIImage *newImage = [UIImage imageWithCGImage:newImageRef scale:[UIScreen mainScreen].scale orientation:UIImageOrientationUp];
    CGImageRelease(newImageRef);
    return newImage;
}


@end
