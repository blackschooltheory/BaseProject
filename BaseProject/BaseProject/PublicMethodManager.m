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

@end
