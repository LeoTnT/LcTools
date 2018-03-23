//
//  LCComonModel.h
//  LCNetWork
//
//  Created by 李超 on 2018/1/23.
//  Copyright © 2018年 lichao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LCCommonModel : NSObject
/**
 公共类model的属性, 需根据json返回的数据字段进行匹配修改
 */
@property (nonatomic, copy) NSString *resCode;
@property (nonatomic, copy) NSString *resMsg;

@property (nonatomic, strong) id record; // record
@property (nonatomic, strong) id records; // records

@property (nonatomic, assign, readonly, getter = isSuccess) BOOL success;

/**
 * 根据返回数据生成HYZCommonModel对象
 * cls: 对应的data所属的类, data不为单纯的数组，若为单纯的数组，调用commonModelWithKeyValues:dataArrayClass:
 */
+ (instancetype)commonModelWithKeyValues:(id)keyValues dataDictClass:(Class)dataDictClass;

/**
 * 根据返回数据生成HYZCommonModel对象
 * data为单纯数组中元素所对应的类
 */
+ (instancetype)commonModelWithKeyValues:(id)keyValues dataArrayClass:(Class)dataArrayClass;

/**
 *  解析服务器数据
 *
 *  @param keyValues        服务器数据
 *  @param dataDictClass    record
 *  @param dataArrayClass   records
 *
 *  @return 根据返回数据生成HYZCommonModel对象
 */
+ (instancetype)commonModelWithKeyValues:(id)keyValues dataDictClass:(Class)dataDictClass dataArrayClass:(Class)dataArrayClass;

@end
