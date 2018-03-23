//
//  LCUUIDTool.m
//  LcTools
//
//  Created by lichao on 2017/5/16.
//  Copyright © 2017年 lichao. All rights reserved.
//

#import "LCUUIDTool.h"
#import <AdSupport/AdSupport.h>


@implementation LCUUIDTool

+ (NSString *)getUUID1
{
    /*
     从iOS2.0开始，CFUUID就已经出现了。它是CoreFoundatio包的一部分，因此API属于C语言风格。CFUUIDCreate 方法用来创建CFUUIDRef，并且可以获得一个相应的NSString，如下
     获得的这个CFUUID值系统并没有存储。每次调用CFUUIDCreate，系统都会返回一个新的唯一标示符。如果你希望存储这个标示符，那么需要自己将其存储到NSUserDefaults, Keychain, Pasteboard或其它地方。

     */
    CFUUIDRef uuid = CFUUIDCreate(NULL);
    CFStringRef string = CFUUIDCreateString(NULL, uuid);
    CFRelease(uuid);
    NSString *uuidStr = (__bridge NSString *)string;
    
    NSLog(@"UUID : %@", uuidStr);
    return uuidStr;
}

+ (NSString *)getUUID2
{
    /*
     NSUUID在iOS 6中才出现，这跟CFUUID几乎完全一样，只不过它是Objective-C接口。+ (id)UUID 是一个类方法，调用该方法可以获得一个UUID
     */
    NSString *uuidStr = [[NSUUID UUID] UUIDString];
    NSString *uuid = [uuidStr stringByReplacingOccurrencesOfString:@"-" withString:@""];
    
    NSLog(@"UUID : %@", uuid);
    return uuidStr;
}

+ (NSString *)getIDFV
{
    //2.
    //IDFV(identifierForVendor),可用于唯一地标识该设备,在相同应用程序从一个供应商。(官方)
    /**
     
     *在同一个设备上不同的 vendor 下的应用获取到的 IDFV 是不一样的，而同一个 vendor 下的不同应用获取的 IDFV 都是一样的。但如果用户删除了这个 vendor 的所有应用，再重新安装它们，IDFV 就会被重置，和之前的不一样，也不是设备唯一的。
     
     * 顾名思义，是给Vendor标识用户用的，每个设备在所属同一个Vender的应用里，都有相同的值。其中的Vender是指应用提供商，但准确点说，是通过BundleID的反转的前两部分进行匹配，如果相同就是同一个Vender，例如对于com.taobao.app1, com.taobao.app2 这两个BundleID来说，就属于同一个Vender，共享同一个idfv的值。和idfa不同的是，idfv的值是一定能取到的，所以非常适合于作为内部用户行为分析的主id，来标识用户，替代OpenUDID。
     
     *Vendor 是 CFBundleIdentifier——应用标识符的前缀
     */
    NSString *IDFVStr = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    
    NSLog(@"IDFV : %@", IDFVStr);
    return IDFVStr;
}

+ (NSString *)getIDFA
{
    //3.
    //IDFA(advertisingIdentifier)
    /**
     直译就是广告id， 在同一个设备上的所有App都会取到相同的值，是苹果专门给各广告提供商用来追踪用户而设的，用户可以在 设置|隐私|广告追踪 里重置此id的值，或限制此id的使用，故此id有可能会取不到值，但好在Apple默认是允许追踪的，而且一般用户都不知道有这么个设置，所以基本上用来监测推广效果，是戳戳有余了。
     */
    
    NSString *IDFAStr = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    
    NSLog(@"IDFA : %@", IDFAStr);
    return IDFAStr;
}




@end
