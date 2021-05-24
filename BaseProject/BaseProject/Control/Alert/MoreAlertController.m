//
//  MoreAlertController.m
//  BaseProject
//
//  Created by dlk on 2021/5/21.
//  Copyright © 2021 DLK. All rights reserved.
//

#import "MoreAlertController.h"
#import "PublicMethodManager.h"

@implementation MoreAlertController

/*
 关于在一个页面上弹出多个 UIAlert 的方法 不用封装专门的对象来实现，我们可以通过获取当前项目中最上面的VC来做跳转
 */


+ (instancetype)defaultAlert
{
    static MoreAlertController *alertController;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        alertController = [[MoreAlertController alloc]init];
        alertController.alertList = [[NSMutableArray alloc]init];
    });
    return  alertController;
}
-(BOOL)judgeNilOrEmptyToString:(NSString *)str{
    if (str) {
        if ([str isEqualToString:@""]) {
            return YES; //是空或者nil返回 YES
        }
        return NO;
    }else{
        return YES;
    }
    
}

#pragma mark------完全的创建alert的方法
-(void)alertWithTitle:(NSString *)title withContent:(NSString *)content withSureTitle:(NSString *)sureTitle withCancleTitle:(NSString *)cancleTitle sureBlock:(void (^)(void))sureBlock  cancleBlock:(void (^)(void))cancleBlock{
    if ([self judgeNilOrEmptyToString:title] && [self judgeNilOrEmptyToString:content] ) {
        //若标题和内容都是空或nil的情况下可以默认不弹框
        return;
    }
    
    UIAlertController * alertCon = [UIAlertController alertControllerWithTitle:title message:content preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *alertAction = [UIAlertAction actionWithTitle:sureTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        sureBlock();
    }];
    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:cancleTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        cancleBlock();
    }];
    UIAlertAction *cancle2Action = [UIAlertAction actionWithTitle:cancleTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        cancleBlock();
    }];
    
    [alertCon setValue:@[alertAction,cancleAction,cancle2Action] forKey:@"actions"];
    
    if ([self.alertList count]==0) {
        [[PublicMethodManager currentVC] presentViewController:alertCon animated:YES completion:nil];
        
    }else{
        
    }
    
}

@end
