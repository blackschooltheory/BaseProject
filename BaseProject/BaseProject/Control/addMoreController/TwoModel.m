//
//  TwoModel.m
//  BaseProject
//
//  Created by 邓烈康 on 2021/5/11.
//  Copyright © 2021 DLK. All rights reserved.
//

#import "TwoModel.h"
#import <objc/runtime.h>

@implementation TwoModel
+(void)load{
    [super load];
    NSLog(@"my name is  twoModel");
    
    Method mm = class_getInstanceMethod([self class], @selector(addTwoFun));
    IMP addFunIMP = method_getImplementation(mm);
    
    BOOL addStatus = class_addMethod([self class], @selector(addTwoFun), addFunIMP, method_getTypeEncoding(mm));
    NSString *status = addStatus ? @"添加成功" : @"添加失败";
    
    NSLog(status);
}
-(void)addTwoFun{
    NSLog(@"添加方法");
}

@end
