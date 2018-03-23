//
//  NSString+LCRegex.h
//  LcTools
//
//  Created by lichao on 2017/4/20.
//  Copyright © 2017年 lichao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (LCRegex)


#pragma mark ----- <号码有效性的判断> -----

/**
 验证手机号码的有效性

 @return BOOL
 */
- (BOOL)lc_isPhoneNumber;

/**
 手机号的有效性(包含三网及固话)
 
 @return BOOL
 */
- (BOOL)lc_isPhoneNumberClassification;


/**
 验证邮箱地址的有效性

 @return BOOL
 */
- (BOOL)lc_isEmailAddress;

/**
 验证身份证号码的有效性

 @return BOOL
 */
- (BOOL)lc_simpleIDCardNumber;

/**
 验证车牌号码的有效性

 @return BOOL
 */
- (BOOL)lc_isCarNumber;

/**
 验证邮政编码的有效性
 
 @return BOOL
 */
- (BOOL)lc_isValidPostalcode;


/**
 验证工商税号的有效性

 @return BOOL
 */
- (BOOL)lc_isValidTaxNumber;

/**
 验证银行卡号的有效性

 @return BOOL
 */
- (BOOL)lc_isBankCardNumber;


#pragma mark ----- <其他规则的判断> -----

/**
 验证是否为纯汉字
 
 @return BOOL
 */
- (BOOL)lc_isValidChinese;

/**
 验证URL的有效性

 @return BOOL
 */
- (BOOL)lc_isValidURL;

/**
 验证IP的有效性

 @return BOOL
 */
- (BOOL)lc_isValidIP;

/**
 验证mac地址的有效性

 @return BOOL
 */
- (BOOL)lc_isMacAddress;



/**
 判断账号是否符合规定的规则

 @param maxLength 账号最大长度
 @param minLength 账号最小长度
 @param containChinese 是否包含中文
 @param containNum 是否包含数字
 @param containLetter 是否包含字母
 @param containString 是否包含其他字符
 @param firstNum 首字母不为数字
 @return BOOL
 */
- (BOOL)lc_isValidWithMaxLength:(NSInteger)maxLength minLength:(NSInteger)minLength containChinese:(BOOL)containChinese containNumber:(BOOL)containNum containLetter:(BOOL)containLetter containString:(NSString *)containString firstNumber:(BOOL)firstNum;


/**
 自定义判断账号是否符合规则

 @param maxLength 账号最大长度
 @param minLength 账号最小长度
 @param containChinese 是否包含中文
 @param containNum 是否包含数字
 @return BOOL
 */
- (BOOL)lc_isValidWithMaxLength:(NSInteger)maxLength minLength:(NSInteger)minLength containChinese:(BOOL)containChinese containNumber:(BOOL)containNum;


@end
