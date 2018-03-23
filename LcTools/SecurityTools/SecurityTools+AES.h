//
//  SecurityTools+AES.h
//  EncryptDemo
//
//  Created by 周顺 on 2017/4/10.
//  Copyright © 2017年 AIRWALK. All rights reserved.
//

#import "SecurityTools.h"

@interface SecurityTools (AES)

+ (NSString *)stringWithAES256EncodedData:(NSData *)sourceData key:(NSString *)key;
+ (NSString *)stringWithAES256DecodedData:(NSData *)sourceData key:(NSString *)key;

+ (NSData *)dataWithAES256EncodedData:(NSData *)sourceData key:(NSString *)key;
+ (NSData *)dataWithAES256DecodedData:(NSData *)sourceData key:(NSString *)key;

@end
