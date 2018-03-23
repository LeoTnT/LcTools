//
//  SecurityTools+DES.h
//  EncryptDemo
//
//  Created by 周顺 on 2017/4/10.
//  Copyright © 2017年 AIRWALK. All rights reserved.
//

#import "SecurityTools.h"

@interface SecurityTools (DES)

/**
 常用于name加解密
 */

/** base64 加密*/
+ (NSString *)stringWithDESEncodedString:(NSString *)sourceString key:(NSString *)key;
/** base64 解密*/
+ (NSString *)stringWithDESDecodedString:(NSString *)sourceString key:(NSString *)key;

@end
