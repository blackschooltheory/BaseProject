//
//  PublicMethodManager.h
//  BaseProject
//
//  Created by DLK on 2021/1/25.
//  Copyright © 2021 DLK. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PublicMethodManager : NSObject

+(CGFloat)screenWith;

+(CGFloat)screenHeight;

// 判断iphoneX
+ (BOOL)isPhoneX;

//获取当前最上面的VC
+(UIViewController *)currentVC;

+(float)nativeTopHeight;
//系统的弹框
+(void)alertTitle:(NSString *)title;
//解析url 入参信息
+( nullable NSDictionary *)getURLParamsWithUrlStr:(NSString *)urlStr;
@end

NS_ASSUME_NONNULL_END
