
//
//  SecurityTools+AES.m
//  EncryptDemo
//
//  Created by 周顺 on 2017/4/10.
//  Copyright © 2017年 AIRWALK. All rights reserved.
//

#import "SecurityTools+AES.h"
#import <CommonCrypto/CommonCryptor.h>

@implementation SecurityTools (AES)

+ (NSString *)stringWithAES256EncodedData:(NSData *)sourceData key:(NSString *)key {
    if (!key) return nil;
    if (!sourceData) return nil;
    
    NSData *data = [self dataWithAES256EncodedData:sourceData key:key];
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

+ (NSString *)stringWithAES256DecodedData:(NSData *)sourceData key:(NSString *)key {
    if (!key) return nil;
    if (!sourceData) return nil;
    
    NSData *data = [self dataWithAES256DecodedData:sourceData key:key];
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

+ (NSData *)dataWithAES256EncodedData:(NSData *)sourceData key:(NSString *)key {
    if (!key) return nil;
    if (!sourceData) return nil;
    
    char keyPtr[kCCKeySizeAES256 + 1];
    bzero(keyPtr, sizeof(keyPtr));
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    NSUInteger dataLength = [sourceData length];
    size_t bufferSize = dataLength + 100;
    void *buffer = malloc(bufferSize);
    if (!buffer) return nil;
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmAES128,
                                          kCCOptionPKCS7Padding | kCCOptionECBMode,
                                          keyPtr, kCCKeySizeAES256,
                                          NULL,
                                          [sourceData bytes], dataLength,
                                          buffer, bufferSize,
                                          &numBytesEncrypted);
    if (cryptStatus == kCCSuccess) {
        
        return [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
    }
    free(buffer);
    return nil;
}

+ (NSData *)dataWithAES256DecodedData:(NSData *)sourceData key:(NSString *)key {
    if (!key) return nil;
    if (!sourceData) return nil;
    
    char keyPtr[kCCKeySizeAES256 + 1];
    bzero(keyPtr, sizeof(keyPtr));
    
    BOOL suc = [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    if (!suc) return [NSData data];
    NSUInteger dataLength = [sourceData length];
    size_t bufferSize = dataLength + 100;
    void *buffer = malloc(bufferSize);
    if (!buffer) return nil;
    
    size_t numBytesDecrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt, kCCAlgorithmAES,
                                          kCCOptionPKCS7Padding | kCCOptionECBMode,
                                          keyPtr, kCCKeySizeAES256,
                                          NULL,
                                          [sourceData bytes], dataLength,
                                          buffer, bufferSize,
                                          &numBytesDecrypted);
    if (cryptStatus == kCCSuccess) {
        
        return [NSData dataWithBytesNoCopy:buffer length:numBytesDecrypted];
    }
    free(buffer);
    return nil;
}


@end
