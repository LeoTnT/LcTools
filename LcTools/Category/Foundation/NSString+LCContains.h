//
//  NSString+LCContains.h
//  LcTools
//
//  Created by lichao on 2017/4/20.
//  Copyright © 2017年 lichao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (LCContains)


/**
 Unicode编码的字符串转成NSString(类方法)

 @param unicodeStr Unicode字符
 @return NSString
 */
+ (NSString *)lc_replaceUnicode:(NSString *)unicodeStr;

/**
 判断是否包含空格
 
 @return 返回BOOL值
 */
- (BOOL)lc_isContainBlank;

/**
 判断URL是否包含中文

 @return 返回BOOL值
 */
- (BOOL)lc_isContainChinese;

/**
 判断是否包含特定的字符

 @param string 特点的字符
 @return 返回BOOL值
 */
- (BOOL)lc_isContainString:(NSString *)string;



/**
 获取字符的数量

 @return 返回int
 */
- (int)lc_getWordsCount;


/**
 获取字符串的数量

 @return 返回int
 */
-  (int)lc_getStringsCount;

@end
