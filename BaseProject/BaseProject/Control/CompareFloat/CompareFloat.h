//
//  CompareFloat.h
//  BaseProject
//
//  Created by dlk on 2021/5/20.
//  Copyright © 2021 DLK. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum  CompareStatus{
    Ascend = 1,
    Same = 0,
    Descend = -1
} compareStatus;
// Ascend  a大于b 的情况
// Same    a等于b 的情况
// Descend  a小于b 的情况

@interface CompareFloat : NSObject
//直接比较两个数字字符串的大小
+(compareStatus)compareA:(NSString *) a withB:(NSString *)b;
+(NSDecimalNumber *)compareA:(NSString *)a addB:(NSString *)b;
@end

NS_ASSUME_NONNULL_END
