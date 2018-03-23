//
//  NSString+LCRegex.m
//  LcTools
//
//  Created by lichao on 2017/4/20.
//  Copyright © 2017年 lichao. All rights reserved.
//

#import "NSString+LCRegex.h"

@implementation NSString (LCRegex)
#pragma mark -- 正则
- (BOOL)lc_isValidateByRegex:(NSString *)regex{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [predicate evaluateWithObject:self];
}

#pragma mark -- 判断号码的有效性
/** 手机号码的有效性 */
- (BOOL)lc_isPhoneNumber{
    NSString *phoneNumRegex = @"^(0|86|17951)?(13[0-9]|15[012356789]|17[0678]|18[0-9]|14[57])[0-9]{8}$";

    return [self lc_isValidateByRegex:phoneNumRegex];
}

/** 手机号的有效性(包含三网及固话) */
- (BOOL)lc_isPhoneNumberClassification{
    
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188,1705
     * 联通：130,131,132,152,155,156,185,186,1709
     * 电信：133,1349,153,180,189,1700
     */
    //    NSString * MOBILE = @"^1((3//d|5[0-35-9]|8[025-9])//d|70[059])\\d{7}$";//总况
    
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188，1705
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d|705)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186,1709
     17         */
    NSString * CU = @"^1((3[0-2]|5[256]|8[56])\\d|709)\\d{7}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,189,1700
     22         */
    NSString * CT = @"^1((33|53|8[09])\\d|349|700)\\d{7}$";
    
    
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    
    //    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    
    if (([self lc_isValidateByRegex:CM])
        || ([self lc_isValidateByRegex:CU])
        || ([self lc_isValidateByRegex:CT])
        || ([self lc_isValidateByRegex:PHS]))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}


/** 邮箱地址的有效性 */
- (BOOL)lc_isEmailAddress{
    NSString *emailRegex = @"[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    
    return [self lc_isValidateByRegex:emailRegex];
}

/** 身份证号码的有效性 */
- (BOOL)lc_simpleIDCardNumber{
    NSString *IDCardRegex = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    return [self lc_isValidateByRegex:IDCardRegex];
}

/** 车牌号的有效性 */
- (BOOL)lc_isCarNumber{
    //车牌号:湘K-DE829 香港车牌号码:粤Z-J499港
    NSString *carRegex = @"^[\u4e00-\u9fff]{1}[a-zA-Z]{1}[-][a-zA-Z_0-9]{4}[a-zA-Z_0-9_\u4e00-\u9fff]$";//其中\u4e00-\u9fa5表示unicode编码中汉字已编码部分，\u9fa5-\u9fff是保留部分，将来可能会添加
    return [self lc_isValidateByRegex:carRegex];
}

/** 邮政编码的有效性 */
- (BOOL)lc_isValidPostalcode{
    NSString *postalRegex = @"^[0-8]\\d{5}(?!\\d)$";
    return [self lc_isValidateByRegex:postalRegex];
}

/** 工商税号的有效性 */
- (BOOL)lc_isValidTaxNumber{
    NSString *taxNumRegex = @"[0-9]\\d{13}([0-9]|X)$";
    return [self lc_isValidateByRegex:taxNumRegex];
}

/** 银行卡号是否有效 */
- (BOOL)lc_isBankCardNumber{
    /*
     *现行16位银联卡卡号开头6位是 622126 ~ 622926之间的,7~15位是银行自定义,可能是发卡分行,发卡网点,发卡序号     第16位是校验码
     *16位卡号校验位采用 Luhm 校验方法计算
     *1.将未带校验位的15位卡号从右一次编号 1 到 15, 位于奇数位号上的数字乘以 2
      2.将奇位乘积的个十位全部相加, 再加上所有偶数位上的数字
      3.将加法和加上校验位能被 10 整除
     */
    
    //取出最后一位
    NSString *lastNum = [[self substringFromIndex:(self.length - 1)] copy];
    //前15位或者18位
    NSString *forwardNum = [[self substringToIndex:(self.length - 1)] copy];
    
    NSMutableArray *forwardArr = [[NSMutableArray alloc] initWithCapacity:0];
    for (int i = 0; i < forwardNum.length; i++) {
        NSString *subStr = [forwardNum substringWithRange:NSMakeRange(i, 1)];
        [forwardArr addObject:subStr];
    }
    
    NSMutableArray *forwardDescArr = [[NSMutableArray alloc] initWithCapacity:0];
    //前15位或者18位倒序存进数组
    for (int i = (int)(forwardArr.count - 1); i > -1; i--) {
        [forwardDescArr addObject:forwardArr[i]];
    }
    
    //奇数位*2的积 < 9
    NSMutableArray *arrOddNum = [[NSMutableArray alloc] initWithCapacity:0];
    //奇数位*2的积 > 9
    NSMutableArray *arrOddNum2 = [[NSMutableArray alloc] initWithCapacity:0];
    //偶数位数组
    NSMutableArray *arrEvenNum = [[NSMutableArray alloc] initWithCapacity:0];
    
    for (int i = 0; i < forwardDescArr.count; i++) {
        NSInteger num = [forwardDescArr[i] intValue];
        if (i%2) {//偶数位
            [arrEvenNum addObject:[NSNumber numberWithInteger:num]];
        }else{//奇数位
            if (num * 2 < 9) {
                [arrOddNum addObject:[NSNumber numberWithInteger:num * 2]];
            }else{
                NSInteger decadeNum = (num * 2) / 10;
                NSInteger unitNum = (num * 2) % 10;
                [arrOddNum2 addObject:[NSNumber numberWithInteger:unitNum]];
                [arrOddNum2 addObject:[NSNumber numberWithInteger:decadeNum]];
            }
        }
    }

    __block NSInteger sumOddNumTotal = 0;
    [arrOddNum enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        sumOddNumTotal += [obj integerValue];
    }];
    
    __block NSInteger sumOddnum2Total = 0;
    [arrOddNum2 enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        sumOddnum2Total += [obj integerValue];
    }];

    __block NSInteger sumEvenNumTotal = 0;
    [arrEvenNum enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        sumEvenNumTotal += [obj integerValue];
    }];
    
    NSInteger lastNumber = [lastNum integerValue];
    NSInteger luhmTotal = lastNumber + sumEvenNumTotal + sumOddnum2Total + sumOddNumTotal;
    
    return (luhmTotal % 10 == 0) ? YES : NO;
}

#pragma mark -- 其他判断
/** 验证是否为纯汉字 */
- (BOOL)lc_isValidChinese{
    NSString *chineseRegex = @"^[\u4e00-\u9fa5]+$";
    return [self lc_isValidateByRegex:chineseRegex];
}

/** URL的有效性 */
- (BOOL)lc_isValidURL{
    NSString *URLRegex = @"^((http)|(https))+:[^\\s]+\\.[^\\s]*$";
    return [self lc_isValidateByRegex:URLRegex];
}



/** 验证IP的有效性 */
- (BOOL)lc_isValidIP{
    NSString *regex = [NSString stringWithFormat:@"^(\\d{1,3})\\.(\\d{1,3})\\.(\\d{1,3})\\.(\\d{1,3})$"];
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    BOOL rc = [pre evaluateWithObject:self];
    
    if (rc) {
        NSArray *componds = [self componentsSeparatedByString:@","];
        
        BOOL v = YES;
        for (NSString *s in componds) {
            if (s.integerValue > 255) {
                v = NO;
                break;
            }
        }
        
        return v;
    }
    
    return NO;
}

/** mac地址的有效性 */
- (BOOL)lc_isMacAddress{
    NSString *macAddRegex = @"([A-Fa-f\\d]{2}:){5}[A-Fa-f\\d]{2}";
    return [self lc_isValidateByRegex:macAddRegex];
}

#pragma mark -- 账号规则的判断
/**
 containChinese YES/NO      YES:规定账号中必须有中文          NO:必须没有中文
 containLetter  YES/NO  YES:规定账号中必须有数字,字母     NO:可有可无
 containString  需要就传入被判断的字符串  不需要就传入空字符串 @""
 firstNum       首字母是否可以为数字
 */

/** 判断账号是否符合规定的规则 */
- (BOOL)lc_isValidWithMaxLength:(NSInteger)maxLength minLength:(NSInteger)minLength containChinese:(BOOL)containChinese containNumber:(BOOL)containNum containLetter:(BOOL)containLetter containString:(NSString *)containString firstNumber:(BOOL)firstNum{
    
    
    NSString *ChineseRegex = containChinese ? @"\u4e00-\u9fa5" : @"";
    NSString *firstRegex = firstNum ? @"^[a-zA-Z_]" : @"";
    NSString *lengthRegex = [NSString stringWithFormat:@"(?=^.{%@,%@}$)", @(minLength), @(maxLength)];
    NSString *numberRegex = containNum ? @"(?=(.*\\d.*){1})" : @"";
    NSString *letterRegex = containLetter ? @"(?=(.*[a-zA-Z].*){1})" : @"";
    NSString *stringRegex = [NSString stringWithFormat:@"(?:%@[%@A-Za-z0-9%@]+)", firstRegex, ChineseRegex,  containString ? containString : @""];
    NSString *regex = [NSString stringWithFormat:@"%@%@%@%@", lengthRegex, numberRegex, letterRegex, stringRegex];
    
    return [self lc_isValidateByRegex:regex];
}

/** 自定义判断规则 */
- (BOOL)lc_isValidWithMaxLength:(NSInteger)maxLength minLength:(NSInteger)minLength containChinese:(BOOL)containChinese containNumber:(BOOL)containNum{
    
    NSString *ChineseRegex = containChinese ? @"\u4e00-\u9fa5" : @"";
    NSString *lengthRegex = [NSString stringWithFormat:@"(?=^.{%@,%@}$)", @(minLength), @(maxLength)];
    NSString *numberRegex = containNum ? @"(?=(.*\\d.*){1})" : @"";
    NSString *stringRegex = [NSString stringWithFormat:@"(?:[%@A-Za-z0-9]+)", ChineseRegex];
    NSString *regex = [NSString stringWithFormat:@"%@%@%@", lengthRegex, numberRegex, stringRegex];
    
    return [self lc_isValidateByRegex:regex];
}


@end
