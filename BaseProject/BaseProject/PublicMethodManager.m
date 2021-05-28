//
//  PublicMethodManager.m
//  BaseProject
//
//  Created by DLK on 2021/1/25.
//  Copyright © 2021 DLK. All rights reserved.
//

#import "PublicMethodManager.h"

@implementation PublicMethodManager

+(CGFloat)screenWith{
    return [UIScreen mainScreen].bounds.size.width;
}
+(CGFloat)screenHeight{
    return [UIScreen mainScreen].bounds.size.height;
}
+ (BOOL)isPhoneX {
    BOOL iPhoneX = NO;
    if (UIDevice.currentDevice.userInterfaceIdiom != UIUserInterfaceIdiomPhone) {//判断是否是手机
        return iPhoneX;
    }
    if (@available(iOS 11.0, *)) {
        UIWindow *mainWindow = [[[UIApplication sharedApplication] delegate] window];
        if (mainWindow.safeAreaInsets.bottom > 0.0) {
            iPhoneX = YES;
        }
    }
    return iPhoneX;
}
#pragma mark-------获取当前显示的VC
+(UIViewController *)currentVC{
    
    UIViewController * mainVc = [[UIApplication sharedApplication].delegate.window rootViewController];
    
//UIViewController * mainVc = [[UIApplication sharedApplication].delegate.keywindow rootViewController];  keyWindow 也是可以的
    
    if ([mainVc isKindOfClass:[UITabBarController class]]) {
        UITabBarController * tabVc = (UITabBarController *)mainVc;
        
        UIViewController *vc = [tabVc selectedViewController];
        while ([vc presentedViewController]) {
            vc = vc.presentedViewController;
        }
        return vc;
    }else if ([mainVc isKindOfClass:[UINavigationController class]]) {
        UINavigationController *navVC = (UINavigationController *)mainVc;
        UIViewController *vc = [navVC topViewController];
        while (vc.presentedViewController) {
            vc = vc.presentedViewController;
        }
        return vc;
    }else{
        while ([mainVc presentedViewController]) {
            mainVc = mainVc.presentedViewController;
        }
        return mainVc;
    }
}

+(void)alertTitle:(NSString *)title{
    
    //同样的标题的 alert弹框不能弹出
    if ([[PublicMethodManager currentVC] isKindOfClass:[UIAlertController class]]) {
        UIAlertController *alertVC = (UIAlertController *)[PublicMethodManager currentVC] ;
        if ([alertVC.title isEqualToString:title]) {
            return;
        }
    }
    UIAlertController * alertCon = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alertCon setValue:@[alertAction] forKey:@"actions"];
    
    [[PublicMethodManager currentVC] presentViewController:alertCon animated:YES completion:nil];
}
#pragma mark------获取URL的入参信息

+(NSDictionary *)getURLParamsWithUrlStr:(NSString *)urlStr{
    NSRange range = [urlStr rangeOfString:@"?"];
    if(range.location==NSNotFound) {
        return nil;
    }
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    NSString *parametersString = [urlStr substringFromIndex:range.location+1];
    
    if([parametersString containsString:@"&"]) {
        NSArray *urlComponents = [parametersString componentsSeparatedByString:@"&"];
        for(NSString *keyValuePair in urlComponents) {
            //生成key/value
            NSArray *pairComponents = [keyValuePair componentsSeparatedByString:@"="];
            NSString *key = [pairComponents.firstObject stringByRemovingPercentEncoding];
            NSString *value = [pairComponents.lastObject stringByRemovingPercentEncoding];
            //key不能为nil
            if(key==nil|| value ==nil) {
                continue;
            }
            id existValue = [params valueForKey:key];
            if(existValue !=nil) {
                //已存在的值，生成数组。
                if([existValue isKindOfClass:[NSArray class]]) {
                    //已存在的值生成数组
                    NSMutableArray*items = [NSMutableArray arrayWithArray:existValue];
                    
                    [items addObject:value];
                    
                    [params setValue:items forKey:key];
                    
                }else{
                    //非数组
                    [params setValue:@[existValue,value]forKey:key];
                }
            }else{
                //设置值
                [params setValue:value forKey:key];
            }
        }
        
    }else{
        //单个参数生成key/value
        NSArray *pairComponents = [parametersString componentsSeparatedByString:@"="];
        
        if(pairComponents.count==1) {
            return nil;
        }
        //分隔值
        NSString *key = [pairComponents.firstObject stringByRemovingPercentEncoding];
        
        NSString *value = [pairComponents.lastObject stringByRemovingPercentEncoding];
        //key不能为nil
        if(key ==nil|| value ==nil) {
            return nil;
        }
        //设置值
        [params setValue:value forKey:key];
    }
    return params;
}


@end
