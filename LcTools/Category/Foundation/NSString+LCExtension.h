//
//  NSString+LCExtension.h
//  LcTools
//
//  Created by lichao on 2017/5/22.
//  Copyright © 2017年 lichao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (LCExtension)

#pragma mark ----------- 判断特殊字符 -------------
/**
 *  判断字符串是否为空
 */
- (BOOL)lc_empty;

/**
 *  判断是否为整型
 */
- (BOOL)lc_isInteger;

/**
 *  判断是否为浮点型
 */
- (BOOL)lc_isFloat;

/**
 *  判断是否含有数字
 */
- (BOOL)lc_isHasNumder;

/**
 *  判断是否有特殊字符
 */
- (BOOL)lc_isHasSpecialcharacters;


#pragma mark ----------- 时间字符处理 -------------
/**
 *  秒级时间戳转日期
 *
 *  @return 日期
 */
- (NSDate *)lc_dateValueWithTimeIntervalSince1970;

/**
 *  毫秒级时间戳转日期
 *
 *  @return 日期
 */
- (NSDate *)lc_dateValueWithMillisecondsSince1970;

/**
 *  时间戳转格式化的时间字符串
 *
 *  @param formatString 时间格式
 *
 *  @return 格式化的时间字符串
 */
- (instancetype)lc_timestampToTimeStringWithFormatString:(NSString *)formatString;

#pragma mark ----------- 常用方法 -------------

/**
 *  日期+随机数的字符串（比如为文件命名）
 *
 *  @return 得到的字符串
 */
+ (NSString*)lc_getTimeAndRandomString;


#pragma mark ----------- 正则匹配判断 -------------

/**
 *  匹配Email
 *
 *  @return YES 成功 NO 失败
 */
- (BOOL)lc_isEmail;

/**
 *  匹配URL
 *
 *  @return YES 成功 NO 失败
 */
- (BOOL)lc_isUrl;

/**
 *  匹配电话号码
 *
 *  @return YES 成功 NO 失败
 */
- (BOOL)lc_isTelephone;

/**
 *  由英文、字母或数字组成 6-18位
 *
 *  @return YES 验证成功 NO 验证失败
 */
- (BOOL)lc_isPassword;

/**
 *  匹配数字
 *
 *  @return YES 成功 NO 失败
 */
- (BOOL)lc_isNumbers;

/**
 *  匹配英文字母
 *
 *  @return YES 成功 NO 失败
 */
- (BOOL)lc_isLetter;

/**
 *  匹配大写英文字母
 *
 *  @return YES 成功 NO 失败
 */
- (BOOL)lc_isCapitalLetter;

/**
 *  匹配小写英文字母
 *
 *  @return YES 成功 NO 失败
 */
- (BOOL)lc_isSmallLetter;

/**
 *  匹配小写英文字母和数字
 *
 *  @return YES 成功 NO 失败
 */
- (BOOL)lc_isLetterAndNumbers;

/**
 *  匹配中文，英文字母和数字及_(下划线)
 *
 *  @return YES 成功 NO 失败
 */
- (BOOL)lc_isChineseAndLetterAndNumberAndBelowLine;

/**
 *  匹配中文，英文字母和数字及_(下划线) 并限制字数
 *
 *  @return YES 成功 NO 失败
 */
- (BOOL)lc_isChineseAndLetterAndNumberAndBelowLine4to10;

/**
 *  匹配含有汉字、数字、字母、下划线不能以下划线开头和结尾
 *
 *  @return YES 成功 NO 失败
 */
- (BOOL)lc_isChineseAndLetterAndNumberAndBelowLineNotFirstOrLast;


#pragma mark ----------- Emoji相关 -------------

/**
 *  判断是否是Emoji
 *
 *  @return YES 是 NO 不是
 */
- (BOOL)lc_isEmoji;

/**
 *  判断字符串时候含有Emoji
 *
 *  @return YES 是 NO 不是
 */
- (BOOL)lc_isIncludingEmoji;

/**
 *  移除掉字符串中得Emoji
 *
 *  @return 得到移除后的Emoji
 */
- (instancetype)lc_removedEmojiString;

#pragma mark ----------- 计算字符串长度或者高度 -------------

/**
 *  计算字符串高度 （多行）
 *
 *  @param width 字符串的宽度
 *  @param font  字体大小
 *
 *  @return 字符串的尺寸
 */
- (CGSize)lc_heightWithWidth:(CGFloat)width andFont:(CGFloat)font;

/**
 *  计算字符串宽度
 *
 *  @param height 字符串的高度
 *  @param font  字体大小
 *
 *  @return 字符串的尺寸
 */
- (CGSize)lc_widthWithHeight:(CGFloat)height andFont:(CGFloat)font;




@end
