//
//  LCNetworkManager.m
//  LCNetWork
//
//  Created by lichao on 2017/6/12.
//  Copyright © 2017年 lichao. All rights reserved.
//

#import "LCNetManager.h"

@implementation LCNetManager

+ (instancetype)shareManager {
    static LCNetManager *shareManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareManager = [LCNetManager manager];
        shareManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain" ,@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    });
    return shareManager;
}

@end
