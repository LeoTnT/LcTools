//
//  LCComonModel.m
//  LCNetWork
//
//  Created by 李超 on 2018/1/23.
//  Copyright © 2018年 lichao. All rights reserved.
//

#import "LCCommonModel.h"
#import <MJExtension.h>

@implementation LCCommonModel

- (BOOL)isSuccess {
    return [self.resCode isEqualToString:@"00000"];
}

+ (instancetype)commonModelWithKeyValues:(id)keyValues dataDictClass:(Class)dataDictClass {
   
    return [self commonModelWithKeyValues:keyValues dataDictClass:dataDictClass dataArrayClass:nil];
}

+ (instancetype)commonModelWithKeyValues:(id)keyValues dataArrayClass:(Class)dataArrayClass {
  
    return [self commonModelWithKeyValues:keyValues dataDictClass:nil dataArrayClass:dataArrayClass];
}


+ (instancetype)commonModelWithKeyValues:(id)keyValues dataDictClass:(Class)dataDictClass dataArrayClass:(Class)dataArrayClass {
    
    
    LCCommonModel *model = [LCCommonModel mj_objectWithKeyValues:keyValues];

    if (model.record && dataDictClass) {//
        model.record = [dataDictClass mj_objectWithKeyValues:model.record];
    }
    if (model.records && dataArrayClass) {
        model.records = [dataArrayClass mj_keyValuesArrayWithObjectArray:model.records];
    }
    
    return model;
}

@end
