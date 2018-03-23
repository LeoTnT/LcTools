//
//  NSString+LCContains.m
//  LcTools
//
//  Created by lichao on 2017/4/20.
//  Copyright © 2017年 lichao. All rights reserved.
//

#import "NSString+LCContains.h"

@implementation NSString (LCContains)


/** Unicode编码的字符串转成NSString */
+ (NSString *)lc_replaceUnicode:(NSString *)unicodeStr{
    
    NSString *tempStr1 = [unicodeStr stringByReplacingOccurrencesOfString:@"\\u" withString:@"\\U"];
    NSString *tempStr2 = [tempStr1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    NSString *tempStr3 = [[@"\"" stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    
    NSString *returnStr = [NSPropertyListSerialization propertyListWithData:tempData options:NSPropertyListMutableContainersAndLeaves format:NULL error:NULL];
    
    return [returnStr stringByReplacingOccurrencesOfString:@"\\r\\n" withString:@"\n"];
}


/** 判断是否包含空格 */
- (BOOL)lc_isContainBlank{
    
    NSRange range = [self rangeOfString:@" "];
    if (range.location != NSNotFound) {
        return YES;
    }
    return NO;
}

/** 判断URL是否包含中文 */
- (BOOL)lc_isContainChinese{
    
    NSUInteger length = [self length];
    for (NSUInteger i = 0; i < length; i++) {
        NSRange range = NSMakeRange(i, 1);
        NSString *subString = [self substringWithRange:range];
        const char *cString = [subString UTF8String];
        if (strlen(cString) == 3) {
            return YES;
        }
    }
    return NO;
}

/** 是否包含某段字符 */
- (BOOL)lc_isContainString:(NSString *)string{
   
    NSRange range = [self rangeOfString:string];
    if (range.location == NSNotFound) {
        return NO;
    }else{
        return YES;
    }
}

/** 获取字符的数量 */
- (int)lc_getWordsCount{

    NSInteger n = self.length;
    int i;
    int l = 0, a = 0, b = 0;
    unichar c;
    
    for (i = 0; i < n; i++) {
        
        c = [self characterAtIndex:i];
        if (isblank(c)) {
            b++;
        }else if (isascii(c)){
            a++;
        }else{
            l++;
        }
    }
    if (a == 0 && l == 0) {
        return 0;
    }
    
    return l + (int)ceilf((float)(a + b) / 2.0);
}

/** 判断字符串的数量 */
-  (int)lc_getStringsCount{
    
    int strlength = 0;
    char* p = (char*)[self cStringUsingEncoding:NSUTF8StringEncoding];
    for (int i=0 ; i<[self lengthOfBytesUsingEncoding:NSUTF8StringEncoding] ;i++) {
        if (*p) {
            if(*p == '\xe4' || *p == '\xe5' || *p == '\xe6' || *p == '\xe7' || *p == '\xe8' || *p == '\xe9')
            {
                strlength--;
            }
            p++;
            strlength++;
        }
        else {
            p++;
        }
    }
    return strlength;
}


@end
