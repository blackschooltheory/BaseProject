//
//  Carsh.m
//  BaseProject
//
//  Created by dlk on 2021/5/17.
//  Copyright © 2021 DLK. All rights reserved.
//

#import "Carsh.h"
#import "sys/utsname.h"

@implementation Carsh

//当carsh 是会触发的函数
void  caughtExceptionHandler(NSException *exception){
    NSLog(@"exception==%@",exception); //崩溃的具体信息，有函数名称，崩溃的原因，用户信息等...
    NSLog(@"Stack Trace: %@",[exception callStackSymbols]);//崩溃栈信息
    
    /*
     写成文件方式缓存
     NSArray *stackArry= [exception callStackSymbols];
    NSString *reason = [exception reason];
    NSString *name = [exception name];
    NSString *exceptionInfo = [NSString stringWithFormat:@"Exception name:%@\nException reatoin:%@\nException stack :%@",name,reason,stackArry];
     
     NSMutableString *string=[[NSMutableString alloc]initWithString:exceptionInfo];
 //    NSLog(@"%@",exceptionInfo);
     //保存到本地沙盒中
     [string writeToFile:[NSString stringWithFormat:@"%@/Library/Caches/eror.log",NSHomeDirectory()] atomically:YES encoding:NSUTF8StringEncoding error:nil];
     
     */
    
}



#pragma mark---处理carsh，在这个方法中可以对保留的carsh数据上传或者其他处理
-(void)dispositonCarsh{
    
}


@end
