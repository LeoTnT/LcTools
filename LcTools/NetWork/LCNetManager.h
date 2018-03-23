//
//  LCNetworkManager.h
//  LCNetWork
//
//  Created by lichao on 2017/6/12.
//  Copyright © 2017年 lichao. All rights reserved.
//


#import <AFNetworking/AFNetworking.h>

@interface LCNetManager : AFHTTPSessionManager

/** LCNetManager的初始化 */
+ (instancetype)shareManager;

@end
