//
//  LCNetworking.h
//  LCNetWork
//
//  Created by lichao on 2017/6/12.
//  Copyright © 2017年 lichao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFURLRequestSerialization.h>

typedef void (^SuccessBlock)(NSURL *requestURL, NSDictionary *responseObject);
typedef void (^FailureBlock)(NSURL *requestURL, NSString *error);
typedef void (^constructingBody)(id<AFMultipartFormData> formData);
typedef void (^loadProgress)(float progress);

/**
 * 默认的超时时间
 */
static const NSTimeInterval kDefaultRequestTimeOut = 10;

/**
 *  HTTP请求方式
 */
typedef NS_ENUM(NSUInteger, HTTPMethodType) {
    HTTPMethodTypeGET,
    HTTPMethodTypePOST,
    HTTPMethodTypeUpload,
    HTTPMethodTypeUploadImage
};

#define kResponseStatusCode       @"statusCode"     // 返回的状态码
#define kResponseSuccessDomain    200               // 正常数据下发的状态码
#define kResponseDataNode         @"data"           // 成功返回的数据字段
#define kResponseMessageNode      @"message"        // 成功但参数错误返回的数据字段
#define kResponseErrorCodeNode    @"message"        // 成功但参数错误返回的数据字段

@interface LCNetworking : NSObject

/**
 GET请求

 @param url url
 @param parameters 参数字典
 @param isShow 是否需要加载框
 @param downloadProgress 下载Progress
 @param success success回调
 @param failure failure回调
 @return NSURLSessionDataTask
 */
+ (NSURLSessionDataTask *)getWithURL:(NSString *)url
                          parameters:(NSDictionary *)parameters
                              isShow:(BOOL)isShow
                    downloadProgress:(loadProgress)downloadProgress
                             success:(SuccessBlock)success
                             failure:(FailureBlock)failure;



/**
 POST请求

 @param url url
 @param parameters 参数字典
 @param isShow 是否需要加载框
 @param downloadProgress 下载Progress
 @param success success回调
 @param failure failure回调
 @return NSURLSessionDataTask
 */
+ (NSURLSessionDataTask *)postWithURL:(NSString *)url
                           parameters:(NSDictionary *)parameters
                               isShow:(BOOL)isShow
                     downloadProgress:(loadProgress)downloadProgress
                              success:(SuccessBlock)success
                              failure:(FailureBlock)failure;


/**
 upload请求

 @param url url
 @param parameters 参数字典
 @param isShow 是否需要加载框
 @param constructingBody constructingBody回调
 @param loadProgress 加载Progress
 @param success success回调
 @param failure failure回调
 @return NSURLSessionDataTask
 */
+ (NSURLSessionDataTask *)uploadWithURL:(NSString *)url
                             parameters:(NSDictionary *)parameters
                                 isShow:(BOOL)isShow
              constructingBodyWithBlock:(constructingBody)constructingBody
                         uploadProgress:(loadProgress)loadProgress
                                success:(SuccessBlock)success
                                failure:(FailureBlock)failure;


/**
 uploadImage请求

 @param image 需要上传的图片对象
 @param url url
 @param isShow 是否需要加载框
 @param loadProgress 上传进度
 @param success success回调
 @param failure failure回调
 @return NSURLSessionDataTask
 */
+ (NSURLSessionDataTask *)uploadWithImage:(UIImage *)image
                                      URL:(NSString *)url
                                   isShow:(BOOL)isShow
                           uploadProgress:(loadProgress)loadProgress
                                  success:(SuccessBlock)success
                                  failure:(FailureBlock)failure;

@end
