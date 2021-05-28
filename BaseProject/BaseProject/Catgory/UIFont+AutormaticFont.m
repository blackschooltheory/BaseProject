//
//  UIFont+AutormaticFont.m
//  BaseProject
//
//  Created by dlk on 2021/5/28.
//  Copyright © 2021 DLK. All rights reserved.
//

#import "UIFont+AutormaticFont.h"
#import <objc/runtime.h>

@implementation UIFont (AutormaticFont)
+(void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        SEL originalSEL = @selector(systemFontOfSize:);
        
        SEL swizzlingSEL = @selector(swizzlingFontWithSize:);
        
        Class nowClass = object_getClass((id)self);
//        Class nowClass = [self class];
        
        Method original = class_getClassMethod(nowClass, originalSEL);
        Method swizzling = class_getClassMethod(nowClass, swizzlingSEL);
        
        BOOL isSupsel = class_addMethod( nowClass, originalSEL, method_getImplementation(swizzling), method_getTypeEncoding(swizzling));
        if (isSupsel) {
            //直接在当前类中添加该方法（该方法在父类中存在）
            class_replaceMethod(nowClass, swizzlingSEL, method_getImplementation(original), method_getTypeEncoding(original));
        }else{
            method_exchangeImplementations(original, swizzling);
        }
    
    });
}
//注意若是原本调用的类方法 要记得加 + 号是方法开头
+(UIFont *)swizzlingFontWithSize:(CGFloat )fontSize{
    UIFont *changeFont = nil;
    changeFont = [self swizzlingFontWithSize:fontSize+5];
    return changeFont;
}
@end
