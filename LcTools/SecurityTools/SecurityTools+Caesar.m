
//
//  SecurityTools+Caesar.m
//  EncryptDemo
//
//  Created by 周顺 on 2017/4/10.
//  Copyright © 2017年 AIRWALK. All rights reserved.
//

#import "SecurityTools+Caesar.h"

@implementation SecurityTools (Caesar)

+ (NSString *)stringWithCaesarEncodedString:(NSString *)sourceString {
    
    if (!sourceString) return nil;
    
    NSMutableArray *arr = [NSMutableArray array];
    for (int i = 0; i < sourceString.length; i++) {
        unichar asciiCode = [sourceString characterAtIndex:i];
        asciiCode += 3;
        NSString *encryptStr = [NSString stringWithFormat:@"%C", asciiCode];
        [arr addObject:encryptStr];
    }
    
    NSString *encodedStr = [arr componentsJoinedByString:@""];
    
    return encodedStr;
    
}

+ (NSString *)stringWithCaesarDecodedString:(NSString *)sourceString {
    
    if (!sourceString) return nil;
    
    NSMutableArray *arr = [NSMutableArray array];
    for (int i = 0; i < sourceString.length; i++) {
        unichar asciiCode = [sourceString characterAtIndex:i];
        asciiCode -= 3;
        NSString *encryptStr = [NSString stringWithFormat:@"%C", asciiCode];
        [arr addObject:encryptStr];
    }
    
    NSString *decodedStr = [arr componentsJoinedByString:@""];
    
    return decodedStr;
}


@end
