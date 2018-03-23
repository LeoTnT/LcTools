//
//  UIImage+ColorImage.m
//  LcTools
//
//  Created by lichao on 2017/4/6.
//  Copyright © 2017年 lichao. All rights reserved.
//

#import "UIImage+ColorImage.h"

@implementation UIImage (ColorImage)

#pragma mark -- 将color转换为image
+ (UIImage *)getImageWithColor:(UIColor *)color size:(CGSize)imageSize{
    
    CGRect rect = CGRectMake(0, 0, imageSize.width, imageSize.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

#pragma mark -- 获取图片主色调
- (UIColor *)getMostColor{

#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_6_1
    int bitmapInfo = kCGBitmapByteOrderDefault | kCGImageAlphaPremultipliedLast;
#else
    int bitmapInfo = kCGImageAlphaPremultipliedLast;
#endif
    
    
    //第一步 先把图片缩小, 加快计算速度, 但越小结果误差可能越大
    CGSize thumbSize = CGSizeMake(50, 50);
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(NULL, thumbSize.width, thumbSize.height, 8, thumbSize.width * 4, colorSpace, bitmapInfo);
    
    CGRect drawRect = CGRectMake(0, 0, thumbSize.width, thumbSize.height);
    
    CGContextDrawImage(context, drawRect, self.CGImage);
    CGColorSpaceRelease(colorSpace);
    
    //第二步 取每个点的像素值
    unsigned char *data = CGBitmapContextGetData(context);
    if (data == NULL) return nil;
    
    NSCountedSet *cls = [NSCountedSet setWithCapacity:thumbSize.width*thumbSize.height];
    
    for (int x = 0; x < thumbSize.width; x++) {
        for (int y = 0; y < thumbSize.height; y++) {
            int offset = 4*(x*y);
            
            int red = data[offset];
            int green = data[offset + 1];
            int blue = data[offset + 2];
            int alpha = data[offset + 3];
            
            NSArray *clarr = @[@(red), @(green), @(blue), @(alpha)];
            [cls addObject:clarr];
        }
    }
    CGContextRelease(context);
    
    //第三步, 找到次数最多的那个颜色
    NSEnumerator *enumerator = [cls objectEnumerator];
    NSArray *curColor = nil;
    NSArray *maxColor= nil;
    NSUInteger maxCount = 0;
    
    while ((curColor = [enumerator nextObject]) != nil) {
        NSUInteger tmpCount = [cls countForObject:curColor];
        if (tmpCount < maxCount) continue;
        
        maxCount = tmpCount;
        maxColor = curColor;
            
    }
    
    UIColor *theColor = [UIColor colorWithRed:([maxColor[0] intValue] / 255.0f) green:([maxColor[1] intValue] / 255.0f) blue:([maxColor[2] intValue] / 255.0f) alpha:([maxColor[3] intValue] / 255.0f)];
    
    return  theColor;
}

@end
