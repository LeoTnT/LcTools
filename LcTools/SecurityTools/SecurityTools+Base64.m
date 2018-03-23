//
//  SecurityTools+Base64.m
//  EncryptDemo
//
//  Created by 周顺 on 2017/3/26.
//  Copyright © 2017年 AIRWALK. All rights reserved.
//

#import "SecurityTools+Base64.h"

@implementation SecurityTools (Base64)

/** Base64Encoded   NSString -> NSString */
+ (NSString *)stringWithBase64EncodedString:(NSString *)sourceString {
    
    if (!sourceString) return nil;
    
    NSData *data = [sourceString dataUsingEncoding:NSUTF8StringEncoding];
    
    return [self stringWithBase64EncodedData:data];
}


+ (NSString *)stringWithBase64DecodedString:(NSString *)sourceString {
    
    if (!sourceString) return nil;
    
    NSData *data = [self dataWithBase64DecodedString:sourceString];
    
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

+ (NSString *)stringWithBase64EncodedData:(NSData *)sourceData {
    
    if (!sourceData) return nil;
    
    return [sourceData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
}

+ (NSString *)stringWithBase64DecodedData:(NSData *)sourceData {
    
    if (!sourceData) return nil;
    
    NSData *data = [self dataWithBase64EncodedData:sourceData];
    
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

+ (NSData *)dataWithBase64EncodedString:(NSString *)sourceString {
    
    if (!sourceString) return nil;
    
    NSData *data = [sourceString dataUsingEncoding:NSUTF8StringEncoding];
    
    return [self dataWithBase64EncodedData:data];
}

+ (NSData *)dataWithBase64DecodedString:(NSString *)sourceString {
    
    if (!sourceString) return nil;
    
    return [[NSData alloc] initWithBase64EncodedString:sourceString options:NSDataBase64DecodingIgnoreUnknownCharacters];
}

+ (NSData *)dataWithBase64EncodedData:(NSData *)sourceData {
    
    if (!sourceData) return nil;
    
    return [sourceData base64EncodedDataWithOptions:NSDataBase64Encoding64CharacterLineLength];
}

+ (NSData *)dataWithBase64DecodedData:(NSData *)sourceData {
    
    if (!sourceData) return nil;
    
    return [[NSData alloc] initWithBase64EncodedData:sourceData options:NSDataBase64DecodingIgnoreUnknownCharacters];
}

@end
