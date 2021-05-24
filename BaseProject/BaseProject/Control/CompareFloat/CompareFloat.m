//
//  CompareFloat.m
//  BaseProject
//
//  Created by dlk on 2021/5/20.
//  Copyright © 2021 DLK. All rights reserved.
//

#import "CompareFloat.h"

@implementation CompareFloat
#pragma mark-----比较a,b数字字符串大小
+(compareStatus)compareA:(NSString *) a withB:(NSString *)b{
    //比较a字符串数字与b字符串数字的大小；a大返回YES 否则返回NO
    //判断a,b是否含有小数点
    if ([a containsString:@"."]) {
        // a 是浮点类型
        
        NSInteger aNum = [a integerValue];
        NSInteger bNum = [b integerValue];
        
        if ([b containsString:@"."]) {
            //b 是浮点类型
            if (aNum > bNum) {
                return YES; //a 大于 b
            }else if (aNum == bNum) {
                // a b 的整数位相等 比较小数位
                NSArray *aArr = [a componentsSeparatedByString:@"."];
                NSArray *bArr = [b componentsSeparatedByString:@"."];
                NSString * afloat = aArr[1];
                NSString * bfloat = bArr[1];
                
                if ([afloat compare:bfloat] == 1 ) {
                    return  Ascend; //a大于b
                }else if([afloat compare:bfloat] == 0){
                    return Same; //a等于b
                }else{
                    return Descend;//a小于b
                }
            }else{
                // (aNum<bNum)
                return Descend; // a小于b
            }
        }else{
            // a 是浮点类型 b 不是
            if (aNum > bNum) {
                return Ascend; //a 大于 b
            }else if (aNum == bNum){
                NSArray *aArr = [a componentsSeparatedByString:@"."];
                NSString * afloat = aArr[1];
                NSInteger afloatNum = [afloat integerValue];
                
                if(afloatNum == 0){
                    return Same; //a 等于 b
                }
                return Ascend; //由于a是浮点型 a b 的浮点位对比是 a 大
            }else{
                return Descend; //a小于b
            }
        }
        
    }else{
        // a 不是浮点型
        NSInteger aNum = [a integerValue];
        NSInteger bNum = [b integerValue];
        
        if ([b containsString:@"."]) {
            //b 是浮点型
            if (aNum > bNum) {
                return Ascend; //a大于b
            }else if(aNum == bNum){
                NSArray *bArr = [b componentsSeparatedByString:@"."];
                NSString * bfloat = bArr[1];
                NSInteger bfloatNum = [bfloat integerValue];
                if (bfloatNum == 0) {
                    return Same;//a等于b
                }
                return Descend;//a小于b
            }

        }else{
            //a b 都不为浮点型
            if (aNum > bNum) {
                return Ascend; //a 大于b
            }else if(aNum == bNum) {
                return Same; //a等于b
            }else{
                return Descend;//a小于b
            }
            
        }
    }
    return Descend;
}
#pragma mark-----比较数字字符串的大小可以加减乘除
+(NSDecimalNumber *)compareA:(NSString *)a addB:(NSString *)b{
    NSDecimalNumber *decimalANumber = [NSDecimalNumber decimalNumberWithString:a];
    NSDecimalNumber *decimalBNumber = [NSDecimalNumber decimalNumberWithString:b];
    //小数相加
    NSDecimalNumber *addDecimal = [decimalANumber decimalNumberByAdding:decimalBNumber];
    //小数相乘
    NSDecimalNumber *multiplyDecimal = [decimalANumber decimalNumberByMultiplyingBy:decimalBNumber];
    //小数相除
    NSDecimalNumber *dividDecimal = [decimalANumber decimalNumberByDividingBy:decimalBNumber];
    //小数相减
    NSDecimalNumber *subtractDecimal = [decimalANumber decimalNumberBySubtracting:decimalBNumber];
    NSLog(@"subtract==%@",[subtractDecimal stringValue]);
    NSLog(@"add==%@",[addDecimal stringValue]);
    NSLog(@"multiply==%@",[multiplyDecimal stringValue]);
    NSLog(@"divid==%@",[dividDecimal stringValue]);
    
    //比较大小
   NSComparisonResult compareResult = [subtractDecimal compare:addDecimal];
    if (compareResult == NSOrderedAscending) {
//        subtractDecimal 小于 addDecimal  表示升序 NSOrderedAscending
        NSLog(@"Ascending");
        
        // subtractDecimal 大于 addDecimal  表示降序 NSOrderedDescending
        
        // subtractDecimal 等于 addDecimal  表示相等 NSOrderedSame
    }
    /*
     NSComparisonResult 有三个值来表示对象的大小关系
     
    {
        NSOrderedAscending = -1L,
        NSOrderedSame,
        NSOrderedDescending
    };
     */
    return addDecimal;
}

@end
