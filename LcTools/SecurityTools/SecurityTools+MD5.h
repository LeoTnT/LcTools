//
//  SecurityTools+MD5.h
//  EncryptDemo
//
//  Created by 周顺 on 2017/4/10.
//  Copyright © 2017年 AIRWALK. All rights reserved.
//

#import "SecurityTools.h"

@interface SecurityTools (MD5)

+ (NSString *)md5String:(NSString *)sourceString;
+ (NSString *)md5Data:(NSData *)sourceData;

/**
 计算大文件的MD5值
 
 @param path 文件的路径
 @param dataLength 文件分段MD5加密的字节长
 @return 文件的MD5值
 */
+ (NSString *)fileMD5withFilePath:(NSString *)path readingDataLength:(NSInteger)dataLength;

+ (NSString *)sha1String:(NSString *)sourceString;

@end
