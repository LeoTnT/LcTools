//
//  SecurityTools+TripleDES.h
//  EncryptDemo
//
//  Created by 周顺 on 2017/4/10.
//  Copyright © 2017年 AIRWALK. All rights reserved.
//

#import "SecurityTools.h"

/**
 3DES
 */
@interface SecurityTools (TripleDES)

+ (NSString *)stringWith3DESEncodedString:(NSString *)sourceString key:(NSString *)key;

+ (NSString *)stringWith3DESDecodedString:(NSString *)sourceString key:(NSString *)key;

@end
