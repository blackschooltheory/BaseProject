//
//  UITableView+StabceImage.m
//  BaseProject
//
//  Created by 邓烈康 on 2021/5/11.
//  Copyright © 2021 DLK. All rights reserved.
//

/*
 通过  method  swizzling  的方式给 tableView 设置无数据时的站位图；
 
 */



#import "UITableView+StabceImage.h"
#import <objc/runtime.h>

@implementation UITableView (StabceImage)

+(void)load{
    // 在load中到底要不要调用 [super load];调用了又会导致什么问题（涉及到父类，子类，父类分类，子类分类的执行顺序问题：并没有正确的顺序关于父类分类与子类分类(按照编译顺序来实现)）；若想执行继承体系上的load 则需要调用  [super load]

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class selfClass = [self class];

        SEL originalSel = @selector(reload);
        SEL swizzlingSel = @selector(reloadSwizzling);
        
        
        Method originalMethod = class_getInstanceMethod(selfClass, @selector(reload));
        Method swizzlingMethod = class_getInstanceMethod(selfClass, @selector(reloadSwizzling));

        /*
        通过  class_addMethod  给当前的类添加SEL对应的IMP 是否成功；若成功则说明IMP是父类中的方法（本类中添加父类的方法并将SEL与父类的IMP绑定）
            若失败则说明 本类已经有了该IMP，添加不了；
         */
        
        BOOL addMethod = class_addMethod(selfClass, originalSel, method_getImplementation(swizzlingMethod), method_getTypeEncoding(swizzlingMethod));
        if (addMethod) {
            //父类中有该方法
            //已经将original的方法的IMP换成了Swizzling 的了
            
            //我们只需将 swizzlingSel的IMP更换下即可
            class_replaceMethod(selfClass, swizzlingSel, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
        }else{
            //只在本类中有该方法
            method_exchangeImplementations(originalMethod, swizzlingMethod);
        }
    });
    
   
}
#pragma mark-------交换的方法
-(void)reloadSwizzling{
    
    
    
    [self reloadSwizzling];// 该方法执行的是 reload 方法
}


@end
