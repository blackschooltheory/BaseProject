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

+ (BOOL)isPhoneX;

+(UIViewController *)currentVC;
@end

NS_ASSUME_NONNULL_END
