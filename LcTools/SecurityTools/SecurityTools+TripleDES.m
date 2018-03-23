
//
//  SecurityTools+TripleDES.m
//  EncryptDemo
//
//  Created by 周顺 on 2017/4/10.
//  Copyright © 2017年 AIRWALK. All rights reserved.
//

#import "SecurityTools+TripleDES.h"
#import <CommonCrypto/CommonCryptor.h>
#import "SecurityTools+Base64.h"

// 密匙key
#define DESKEY @"D6D2402F1C98E208FF2E863AA29334BD65AE1932A821502D9E5673CDE3C713ACFE53E2103CD40ED6BEBB101B484CAE83D537806C6CB611AEE86ED2CA8C97BBE95CF8476066D419E8E833376B850172107844D394016715B2E47E0A6EECB3E83A361FA75FA44693F90D38C6F62029FCD8EA395ED868F9D718293E9C0E63194E87"

@implementation SecurityTools (TripleDES)

+ (NSString *)stringWith3DESEncodedString:(NSString *)sourceString key:(NSString *)key {
    return [self stringWith3DESString:sourceString key:key encryptOrDecrypt:kCCEncrypt];
}

+ (NSString *)stringWith3DESDecodedString:(NSString *)sourceString key:(NSString *)key {
    return [self stringWith3DESString:sourceString key:key encryptOrDecrypt:kCCDecrypt];
}


+ (NSString*)stringWith3DESString:(NSString*)sourceString key:(NSString *)key encryptOrDecrypt:(CCOperation)encryptOrDecrypt {
    
    const void *vplainText;
    size_t plainTextBufferSize;
    
    if (encryptOrDecrypt == kCCEncrypt) { // 加密
        
        NSData *EncryptData = [self dataWithBase64DecodedString:sourceString];
        plainTextBufferSize = [EncryptData length];
        vplainText = [EncryptData bytes];
        
    } else { // 解密
        
        NSData* data = [sourceString dataUsingEncoding:NSUTF8StringEncoding];
        plainTextBufferSize = [data length];
        vplainText = (const void *)[data bytes];
        
    }
    
    CCCryptorStatus ccStatus;
    uint8_t *bufferPtr = NULL;
    size_t bufferPtrSize = 0;
    size_t movedBytes = 0;
    
    bufferPtrSize = (plainTextBufferSize + kCCBlockSize3DES) & ~(kCCBlockSize3DES - 1);
    bufferPtr = malloc( bufferPtrSize * sizeof(uint8_t));
    memset((void *)bufferPtr, 0x0, bufferPtrSize);
    
    const void *vkey = (const void *)[key UTF8String];
    
    // 偏移量
//    NSString *initVec = @"init Vec";
//    const void *vinitVec = (const void *) [initVec UTF8String];
    
    ccStatus = CCCrypt(encryptOrDecrypt,
                       kCCAlgorithm3DES,
                       kCCOptionPKCS7Padding | kCCOptionECBMode,
                       vkey,
                       kCCKeySize3DES,
                       nil,
                       vplainText,
                       plainTextBufferSize,
                       (void *)bufferPtr,
                       bufferPtrSize,
                       &movedBytes);
    
//    ccStatus = CCCrypt(encryptOrDecrypt,
//                       kCCAlgorithm3DES,
//                       kCCOptionPKCS7Padding | kCCOptionECBMode,
//                       vkey,
//                       kCCKeySize3DES,
//                       vinitVec,//偏移量，不用的话，必须为nil,不可以为@“”
//                       vplainText,
//                       plainTextBufferSize,
//                       (void *)bufferPtr,
//                       bufferPtrSize,
//                       &movedBytes);
    
    NSString *result;
    
    if (encryptOrDecrypt == kCCDecrypt) {
        
        result = [[NSString alloc] initWithData:[NSData dataWithBytes:(const void *)bufferPtr length:(NSUInteger)movedBytes] encoding:NSUTF8StringEncoding];
        
    } else {
        
        NSData *myData = [NSData dataWithBytes:(const void *)bufferPtr length:(NSUInteger)movedBytes];
        result = [self stringWithBase64EncodedData:myData];
    }
    
    return result;
}


@end
