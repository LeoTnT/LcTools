//
//  SecurityTools+Caesar.h
//  EncryptDemo
//
//  Created by 周顺 on 2017/4/10.
//  Copyright © 2017年 AIRWALK. All rights reserved.
//

#import "SecurityTools.h"

@interface SecurityTools (Caesar)

// 凯撒加密是一种简单的文字替换加密。比如所有的字母都向后3位替换，a换d，b换位e，以此类推（最后几位是x换位a， y换位b， z换位c）。考虑到加密内容不只是英文字母。此处改进使用ASCII码偏移进行加密解密。

+ (NSString *)stringWithCaesarEncodedString:(NSString *)sourceString;
+ (NSString *)stringWithCaesarDecodedString:(NSString *)sourceString;

@end
