//
//  UIImage+FileManager.h
//  LibItools
//
//  Created by lichao on 2017/3/28.
//  Copyright © 2017年 lichao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (FileManager)

/**
 保存图片到相册胶卷
 */
- (void)saveToPhotoAlubm;

/**
 保存图片到相册
 
 @param ablumTitle 自定义相册的名字
 @param comletion error回调
 */
- (void)saveToPhotoAlubmWithTitle:(NSString *)ablumTitle mpletionHandler:(void(^)(NSError *error))comletion;


/**
 保存图片到沙盒

 @param name 图片的名字
 @param competion 路径的回调
 */
- (void)writeTofileWithName:(NSString *)name completionHandler: (void(^)(NSString *filePath))competion;

@end
