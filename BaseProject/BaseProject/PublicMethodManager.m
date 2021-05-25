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
    UIAlertController * alertCon = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
     
    }];
    [alertCon setValue:@[alertAction] forKey:@"actions"];
    
    [[PublicMethodManager currentVC] presentViewController:alertCon animated:YES completion:nil];
}


@end
