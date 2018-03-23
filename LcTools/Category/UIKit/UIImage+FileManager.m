//
//  UIImage+FileManager.m
//  LibItools
//
//  Created by lichao on 2017/3/28.
//  Copyright © 2017年 lichao. All rights reserved.
//

#import "UIImage+FileManager.h"
#import <Photos/Photos.h>

@implementation UIImage (FileManager)


#pragma mark -- 保存图片到相册

//保存到相册胶卷
- (void)saveToPhotoAlubm{
    [self saveToPhotoAlubmWithTitle:@"" mpletionHandler:^(NSError *error){
        NSLog(@"error : %@", error);
    }];
}


/**
 *  保存图片
 */
- (void)saveToPhotoAlubmWithTitle:(NSString *)ablumTitle mpletionHandler:(void(^)(NSError *error))comletion{
    
    if (self.isCanUsePhotos) {
        NSError *error = nil;
        
        // 1.保存图片到【相机胶卷】
        __block NSString *assetID = nil;
        [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
            assetID = [PHAssetCreationRequest creationRequestForAssetFromImage:self].placeholderForCreatedAsset.localIdentifier;
        } error:&error];
        
        if (ablumTitle && ![ablumTitle  isEqual: @""]) {
            // 2.添加图片到相簿
            [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
                // 利用request对象添加图片到相簿中
                PHAssetCollectionChangeRequest *request = nil;
                
                // 先尝试获取之前创建过的相簿
                PHAssetCollection *createdCollection = nil;
                // 拿到所有的自定义相簿
                PHFetchResult<PHAssetCollection *> *collections = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
                // 遍历所有的自定义相簿
                for (PHAssetCollection *collection in collections) {
                    if ([collection.localizedTitle isEqualToString:ablumTitle]) {
                        createdCollection = collection;
                        break;
                    }
                }
                if (createdCollection) { // 曾经创建过相簿
                    request = [PHAssetCollectionChangeRequest changeRequestForAssetCollection:createdCollection];
                } else { // 没有创建过相簿
                    // 创建【自定义相簿】
                    request = [PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle:ablumTitle];
                }
                
                // 添加刚才保存成功的图片到【自定义相簿】
                [request addAssets:[PHAsset fetchAssetsWithLocalIdentifiers:@[assetID] options:nil]];
                
            } error:&error];
        }

        
        if (error) {
            //        [SVProgressHUD showErrorWithStatus:@"保存失败"];
            comletion(error);
        }else {
            //        [SVProgressHUD showSuccessWithStatus:@"保存成功"];
            NSLog(@"保存成功");
        }

    }else{
        NSLog(@"请打开权限");
    }
    
}

#pragma mark -- 判断是否有权限使用相册
- (BOOL)isCanUsePhotos{
    
    __block BOOL isCan;
    //    UIImageWriteToSavedPhotosAlbum(self.imageV.image, self, @selector(image:didFinishSaveingWithError:contextInfo:), nil);
    
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    switch (status) {
        case PHAuthorizationStatusRestricted : { //家长控制(系统限制该应用访问photo)
            //            [SVProgressHUD showErrorWithStatus:@"系统拒绝访问相册,保存失败"];
            NSLog(@"系统拒绝访问相册,保存失败");
            isCan = NO;
            break;
        }
        case PHAuthorizationStatusNotDetermined : { //用户还未做出选择
            //弹框让用户进行选择
            [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
                //如果用户拒绝访问
                if (status == PHAuthorizationStatusDenied) {
                    NSLog(@"用户拒绝访问");
                    isCan = NO;
                }else if (status == PHAuthorizationStatusAuthorized) { //如果用户同意访问
                    //直接进行保存图片
                    //                    [self saveImageWithLibraryTitle:libraryTitle];
                    isCan = YES;
                }
            }];
            break;
        }
        case PHAuthorizationStatusAuthorized :{//当前用户允许访问相册,直接进行保存
            //            [self saveImageWithLibraryTitle:libraryTitle];
            isCan = YES;
            break;
        }
        case PHAuthorizationStatusDenied :{//用户已经拒绝访问,
            NSLog(@"提醒用户打开权限");
            isCan = NO;
            break;
        }
    }
    
    return isCan;
}

#pragma mark -- 图片写入沙盒
//将图片写入沙盒
- (void)writeTofileWithName:(NSString *)name completionHandler: (void(^)(NSString *filePath))competion{
    //将图片转为data类型
    NSData *imageData = UIImagePNGRepresentation(self);
    //将图片写入沙盒
    NSString *filePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png", name]];
    //回调图片所在的路径
    competion(filePath);
    [imageData writeToFile:filePath atomically:YES];
}

#pragma mark -- 从bundle中读取图片

//从指定bundle路径读取图片
+ (UIImage *)imageWithFileName:(NSString *)fileName inBundle:(NSString *)bundle{
    
    NSString *extension = @"png";
    
    NSArray *components = [fileName componentsSeparatedByString:@"."];
    if (components.count >= 2) {
        NSUInteger lastIndex = components.count - 1;
        extension = [components objectAtIndex:lastIndex];
    }
    
    return nil;
}

@end
