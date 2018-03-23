//
//  LCNetworking.m
//  LCNetWork
//
//  Created by lichao on 2017/6/12.
//  Copyright © 2017年 lichao. All rights reserved.
//

#import "LCNetworking.h"
#import "LCNetManager.h"
#import <MBProgressHUD.h>

@implementation LCNetworking

#pragma mark -- 网络请求接口
+ (NSURLSessionDataTask *)getWithURL:(NSString *)url
                          parameters:(NSDictionary *)parameters
                              isShow:(BOOL)isShow
                    downloadProgress:(loadProgress)downloadProgress
                             success:(SuccessBlock)success
                             failure:(FailureBlock)failure
{
    return [self requestWithMethodType:HTTPMethodTypeGET URL:url parameters:parameters constructinBody:nil image:nil showHUD:isShow requestTimeout:kDefaultRequestTimeOut loadProgress:downloadProgress success:success failure:failure];
}

+ (NSURLSessionDataTask *)postWithURL:(NSString *)url
                           parameters:(NSDictionary *)parameters
                               isShow:(BOOL)isShow
                     downloadProgress:(loadProgress)downloadProgress
                              success:(SuccessBlock)success
                              failure:(FailureBlock)failure
{
    return [self requestWithMethodType:HTTPMethodTypePOST URL:url parameters:parameters constructinBody:nil image:nil showHUD:isShow requestTimeout:kDefaultRequestTimeOut loadProgress:downloadProgress success:success failure:failure];
}

+ (NSURLSessionDataTask *)uploadWithURL:(NSString *)url
                             parameters:(NSDictionary *)parameters
                                 isShow:(BOOL)isShow
              constructingBodyWithBlock:(constructingBody)constructingBody
                         uploadProgress:(loadProgress)loadProgress
                                success:(SuccessBlock)success
                                failure:(FailureBlock)failure
{
    return [self requestWithMethodType:HTTPMethodTypeUpload URL:url parameters:parameters constructinBody:constructingBody image:nil showHUD:isShow requestTimeout:kDefaultRequestTimeOut loadProgress:loadProgress success:success failure:failure];
}

+ (NSURLSessionDataTask *)uploadWithImage:(UIImage *)image
                                      URL:(NSString *)url
                                   isShow:(BOOL)isShow
                           uploadProgress:(loadProgress)loadProgress
                                  success:(SuccessBlock)success
                                  failure:(FailureBlock)failure
{
    return [self requestWithMethodType:HTTPMethodTypeUpload URL:url parameters:nil constructinBody:nil image:image showHUD:isShow requestTimeout:kDefaultRequestTimeOut loadProgress:loadProgress success:success failure:failure];
}




#pragma mark -- 统一网络请求
+ (NSURLSessionDataTask *)requestWithMethodType:(HTTPMethodType)methodType
                                            URL:(NSString *)url
                                     parameters:(NSDictionary *)parameters
                                constructinBody:(constructingBody)constructinBody
                                          image:(UIImage *)image
                                        showHUD:(BOOL)isShow
                                 requestTimeout:(NSTimeInterval)requestTimeout
                                   loadProgress:(loadProgress)loadProgress
                                        success:(SuccessBlock)success
                                        failure:(FailureBlock)failure
{
    //处理中文和空格问题
    url = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    MBProgressHUD *hud;
    if (isShow) {
        UIWindow *window = [[UIApplication sharedApplication].delegate window];
        hud = [MBProgressHUD showHUDAddedTo:window animated:YES];
        hud.label.text = @"正在加载..";
        //提示框的模式(Ring-shaped progress view 环形)
        hud.mode = MBProgressHUDModeAnnularDeterminate;
        //提示框的颜色
        hud.bezelView.color = [UIColor blackColor];
        //字体颜色
        hud.label.textColor = [UIColor whiteColor];
    }
    
    LCNetManager *manager = [LCNetManager shareManager];
    manager.requestSerializer.timeoutInterval = (requestTimeout > 0) ? requestTimeout : kDefaultRequestTimeOut;

    NSURLSessionDataTask *task = nil;
    switch (methodType) {
        case HTTPMethodTypeGET: {
            
            task = [manager GET:url parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
                if (loadProgress) {
                    loadProgress((float)downloadProgress.completedUnitCount / (float)downloadProgress.totalUnitCount);
                }
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                
                if (isShow) [hud hideAnimated:YES];
                if (!responseObject) {
                    if (failure) failure(task.originalRequest.URL, @"数据为空");
                    return ;
                }
                //成功返回数据
                if (success) {
                    success(task.originalRequest.URL, responseObject);
                }
                
                //返回状态码 错误的提示
                /*
                 if ([responseObject[kResponseStatusCode] integerValue] == kResponseSuccessDomain) {
                 if (success) success(task.originalRequest.URL, responseObject[kResponseDataNode]);
                 }else {
                 [self errorWithMessage:responseObject[kResponseMessageNode] errorCode:responseObject[kResponseStatusCode]];
                 }
                 */
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                
                if (isShow) [hud hideAnimated:YES];
                if (failure) {
                    failure(task.originalRequest.URL, error.localizedDescription);
                }
            }];
            
            break;
        }
        case HTTPMethodTypePOST: {
        
            task = [manager POST:url parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
                
                if (loadProgress) {
                    loadProgress((float)uploadProgress.completedUnitCount / (float)uploadProgress.totalUnitCount);
                }
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                
                if (isShow) [hud hideAnimated:YES];
                if (!responseObject) {
                    if (failure) failure(task.originalRequest.URL, @"数据为空");
                    return ;
                }
                
                //成功返回数据
                if (success) {
                    success(task.originalRequest.URL, responseObject);
                }
                //返回状态码 错误的提示
                /*
                 if ([responseObject[kResponseStatusCode] integerValue] == kResponseSuccessDomain) {
                 if (success) success(task.originalRequest.URL, responseObject[kResponseDataNode]);
                 }else {
                 [self errorWithMessage:responseObject[kResponseMessageNode] errorCode:responseObject[kResponseStatusCode]];
                 success(task.originalRequest.URL, responseObject);
                 }
                 */
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                
                if (isShow) [hud hideAnimated:YES];
                if (failure) failure(task.originalRequest.URL, error.localizedDescription);
            }];
            break;
        }
        case HTTPMethodTypeUpload: {
            
            task = [manager POST:url parameters:parameters constructingBodyWithBlock:constructinBody progress:^(NSProgress * _Nonnull uploadProgress) {
                
                if (loadProgress) {
                    loadProgress((float)uploadProgress.completedUnitCount / (float)uploadProgress.totalUnitCount);
                }
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                
                if (isShow) [hud hideAnimated:YES];
                if (success) success(task.originalRequest.URL, responseObject);
                
                //返回状态码 错误的提示
                /*
                 if ([responseObject[kResponseStatusCode] integerValue] == kResponseSuccessDomain) {
                 if (success) success(task.originalRequest.URL, responseObject[kResponseDataNode]);
                 }else {
                 [self errorWithMessage:responseObject[kResponseMessageNode] errorCode:responseObject[kResponseStatusCode]];
                 }
                 */
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                
                if (isShow)  [hud hideAnimated:YES];
                if (failure) {
                    failure(task.originalRequest.URL, error.localizedDescription);
                }
            }];
            
            
            break;
        }
        case HTTPMethodTypeUploadImage: {
        
            task = [manager POST:url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
                
                NSString *name = @"file";//服务器定好的上传字段
                NSString *filename; //保存为 文件名(如果为nil,默认为当前日期时间,格式yyyyMMddHHmmss.jpg)
                NSString *mimeType; //图片格式 默认为image/jpeg

                NSData *imageData = UIImageJPEGRepresentation(image, 1);

                NSString *imageFileName = filename;
                if (filename == nil || ![filename isKindOfClass:[NSString class]] || filename.length == 0) {
                    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                    formatter.dateFormat = @"yyyyMMddHHmmss";
                    NSString *str = [formatter stringFromDate:[NSDate date]];
                    imageFileName = [NSString stringWithFormat:@"%@.jpg", str];
                }
                //上传图片，以文件流的格式
                [formData appendPartWithFileData:imageData name:name fileName:imageFileName mimeType:mimeType];
                
            } progress:^(NSProgress * _Nonnull uploadProgress) {
                
                if (loadProgress) {
                    loadProgress((float)uploadProgress.completedUnitCount / (float)uploadProgress.totalUnitCount);
                }
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                
                if (isShow) [hud hideAnimated:YES];
                if (success) success(task.originalRequest.URL, responseObject);
                
                //返回状态码 错误的提示
                /*
                 if ([responseObject[kResponseStatusCode] integerValue] == kResponseSuccessDomain) {
                 if (success) success(task.originalRequest.URL, responseObject[kResponseDataNode]);
                 }else {
                 [self errorWithMessage:responseObject[kResponseMessageNode] errorCode:responseObject[kResponseStatusCode]];
                 }
                 */

            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                
                if (isShow)  [hud hideAnimated:YES];
                if (failure) {
                    failure(task.originalRequest.URL, error.localizedDescription);
                }
            }];
        }
        default: break;
    }
    return task;
}


#pragma mark -- 错误信息处理
- (void)errorWithMessage:(NSString *)message errorCode:(NSString *)errorCode
{
    UIWindow *windown = [[UIApplication sharedApplication].delegate window];
    if (![message isKindOfClass:[NSNull class]])
    {
        if (message.length > 0)
        {
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:windown animated:YES];
            hud.mode = MBProgressHUDModeText;
            hud.label.text = message;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [hud hideAnimated:YES];
            });
        }
    }
}





@end
