//
//  SecurityTools+Base64.h
//  EncryptDemo
//
//  Created by 周顺 on 2017/3/26.
//  Copyright © 2017年 AIRWALK. All rights reserved.
//

#import "SecurityTools.h"

@interface SecurityTools (Base64)

/**
 常用于name加解密
 */

/** base64加密 */
+ (NSString *)stringWithBase64EncodedString:(NSString *)sourceString;
/** base64解密 */
+ (NSString *)stringWithBase64DecodedString:(NSString *)sourceString;
+ (NSString *)stringWithBase64EncodedData:(NSData *)sourceData;
+ (NSString *)stringWithBase64DecodedData:(NSData *)sourceData;

+ (NSData *)dataWithBase64EncodedString:(NSString *)sourceString;
+ (NSData *)dataWithBase64DecodedString:(NSString *)sourceString;
+ (NSData *)dataWithBase64EncodedData:(NSData *)sourceData;
+ (NSData *)dataWithBase64DecodedData:(NSData *)sourceData;

@end
