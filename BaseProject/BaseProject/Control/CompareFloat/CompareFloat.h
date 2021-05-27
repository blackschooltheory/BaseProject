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
//上面的设置实际上是有问题的 a 大于 b 应该是降序  ； a 小于 b 应该是升序 (需要重新修改下)

@interface CompareFloat : NSObject
//直接比较两个数字字符串的大小
+(compareStatus)compareA:(NSString *) a withB:(NSString *)b;
+(NSDecimalNumber *)compareA:(NSString *)a addB:(NSString *)b;
@end

NS_ASSUME_NONNULL_END
