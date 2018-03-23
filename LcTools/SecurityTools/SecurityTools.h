//
//  SecurityTools.h
//  EncryptDemo
//
//  Created by 周顺 on 2017/3/24.
//  Copyright © 2017年 AIRWALK. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 加密工具类
 */
@interface SecurityTools : NSObject

@end

#pragma mark -- SecurityTools使用方法
/* ============================================= */

//#import "SecurityToolsDefine.h"

//- (void)viewDidLoad {
//    [super viewDidLoad];
//    // Do any additional setup after loading the view, typically from a nib.
//    
//    [self testMD5];
//    [self testBase64];
//    [self testCaesar];
//
//}
//
//- (void)testCaesar {
//    
//    NSString * enString = [SecurityTools stringWithCaesarEncodedString:@"adfadf"];
//    NSLog(@"%@", enString);
//    
//    
//    NSString *deString = [SecurityTools stringWithCaesarDecodedString:enString];
//    NSLog(@"%@", deString);
//}
//
//- (void)testBase64 {
//    
//    NSString * enString = [SecurityTools stringWithBase64EncodedString:@"我是谁"   ];
//    NSLog(@"%@", enString);
//    
//    
//    NSString *deString = [SecurityTools stringWithBase64DecodedString:enString];
//    NSLog(@"%@", deString);
//    
//    
//    NSString *enString1 = @"我是谁";
//    NSData *enData = [enString1 dataUsingEncoding:NSUTF8StringEncoding];
//    
//    NSString *enString2 = [SecurityTools stringWithBase64EncodedData:enData];
//    NSLog(@"%@", enString2);
//    
//    NSData *deData = [SecurityTools dataWithBase64DecodedString:enString2];
//    NSString *deString2 = [[NSString alloc] initWithData:deData encoding:NSUTF8StringEncoding];
//    NSLog(@"%@", deString2);
//    
//}
//
//- (void)testMD5 {
//    NSString *enString = [SecurityTools md5String:@"真是666"];
//    NSLog(@"%@", enString);
//}
/* ============================================= */
