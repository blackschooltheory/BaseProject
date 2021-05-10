//
//  Performance.m
//  BaseProject
//
//  Created by DLK on 2020/12/22.
//  Copyright © 2020 DLK. All rights reserved.
//

#import "Performance.h"
#import <objc/runtime.h>
#import "GCDVC.h"

@interface Performance ()

@end

@implementation Performance

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
    button.backgroundColor = [UIColor grayColor];
    [button addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}
-(void)click{
//给当前的对象执行一个不存在的函数（方法动态解析）
  NSString   *sss =   [self performSelector:@selector(good) withObject:@"1234"];
    NSLog(@"%@",sss);
}

-(NSString *)goodFun:(NSString *)str{
    NSLog(@"调用动态方法解析good方法");
    return [NSString stringWithFormat:@"我是给goodFun传递的参数%@",str];
}


#pragma  mark--------动态解析（当调用的方法寻找不到是添加对于的执行方法）
+(BOOL)resolveClassMethod:(SEL)sel{
    //给类添加方法（动态方法解析）
    Class selfClass = [self class];
  
    SEL goodSel = @selector(goodFun:);
    Method goodMethod = class_getInstanceMethod(selfClass, goodSel);
    IMP goodIMP = method_getImplementation(goodMethod);
    
    if ( [NSStringFromSelector(sel) isEqualToString:@"goodFun:"]) {
        //符合我们需要做动态方法解析的对象
        class_addMethod([self class], sel, (IMP)  goodIMP, method_getTypeEncoding(goodMethod));
        return YES;
    }
    return NO;
    
}

+(BOOL)resolveInstanceMethod:(SEL)sel{
    //给对象添加方法（动态方法解析）
    Class selfClass = [self class];
  
    SEL goodSel = @selector(goodFun:);
    Method goodMethod = class_getInstanceMethod(selfClass, goodSel);
    IMP goodIMP = method_getImplementation(goodMethod);
    
    if ( [NSStringFromSelector(sel) isEqualToString:@"good"]) {
        //符合我们需要做动态方法解析的对象
        class_addMethod([self class], sel, (IMP)  goodIMP, method_getTypeEncoding(goodMethod));
        return YES;
    }
    return NO;
    
}

#pragma  mark-------消息接受者重定向（将接受的消息转发到某个对象去处理）
//-(id)forwardingTargetForSelector:(SEL)aSelector{
//    //给对象执行的方法时，添加消息转发的对象处理 （直接 return 对象就会直接执行方法）
//}
//
//+(id)forwardingTargetForSelector:(SEL)aSelector{
//    //给类执行方法时，添加消息转发对象处理（直接 return 对象就会直接执行方法）
//}


#pragma  mark------消息重定向
//对象发送消息
-(NSMethodSignature *) methodSignatureForSelector:(SEL)aSelector{
    //返回一个方法签名 会重新调用一个 forwardInvocation 的方法传递   invocation （让某些对象消息执行）
    if ([NSStringFromSelector(aSelector) isEqualToString:@"redirectFun"]) {
        //以ObjCTypes 方式生成的 NSMethodSignature
       // return  [NSMethodSignature  signatureWithObjCTypes:"v@:"];
//        以选择子的方式创建 NSMethodSignature  以选择子的方式更加好直观
      return  [NSMethodSignature  methodSignatureForSelector:@selector(redirectFun)];
    }
    return [super methodSignatureForSelector:aSelector];
}
// 返回 NSMethodSignature  后执行的方法，最终用Invocation 去执行任意对象
-(void)forwardInvocation:(NSInvocation *)anInvocation{
    SEL sel = anInvocation.selector;// 获取函数调用的选择子
    GCDVC *vc = [GCDVC new];
    if ([GCDVC respondsToSelector:sel]) {//判断对象是否响应当前函数
        [anInvocation invokeWithTarget:vc];//满足条件的话让该对象调用该选择子；
        //消息接收者重定向与消息重定向有什么区别；消息重定向可以给多个对象发送消息
    }else{
        [self doesNotRecognizeSelector:sel];
    }
}
//给类发送消息
+(NSMethodSignature *) methodSignatureForSelector:(SEL)aSelector{
    //返回一个方法签名 会重新调用一个 forwardInvocation 的方法传递   invocation （让某些对象消息执行）
    if ([NSStringFromSelector(aSelector) isEqualToString:@"redirectFun"]) {
        //以ObjCTypes 方式生成的 NSMethodSignature
       // return  [NSMethodSignature  signatureWithObjCTypes:"v@:"];
//        以选择子的方式创建 NSMethodSignature  以选择子的方式更加好直观
      return  [NSMethodSignature  methodSignatureForSelector:@selector(redirectFun)];
    }
    return [super methodSignatureForSelector:aSelector];
}
// 返回 NSMethodSignature  后执行的方法，最终用Invocation 去执行任意对象
+(void)forwardInvocation:(NSInvocation *)anInvocation{
    SEL sel = anInvocation.selector;// 获取函数调用的选择子
    GCDVC *vc = [GCDVC new];
    if ([GCDVC respondsToSelector:sel]) {//判断对象是否响应当前函数
        [anInvocation invokeWithTarget:vc];//满足条件的话让该对象调用该选择子；
        //消息接收者重定向与消息重定向有什么区别；消息重定向可以给多个对象发送消息
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
