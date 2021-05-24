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
#import "CompareFloat.h"
#import "AddChildVC.h"

@interface Performance ()
@property(nonatomic,assign)NSInteger index;
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

// imp 即 implementation ，表示由编译器生成的、指向实现方法的指针

// C 语言的函数 若 class_addMethod() 方法中 IMP 是直接写了 （IMP）cFun 方式且参数类型的值为“@@:@” 的样式 需要用下面的方式来接
NSString * cFunc (id self , SEL _cmd ,NSString *params) {
    return @"cFun";
}
void startEngine(id self, SEL _cmd, NSString *brand) {
NSLog(@"my %@ car starts the engine", brand);
}


-(void)click{
//给当前的对象执行一个不存在的函数（方法动态解析）
//  NSString   *sss =   [self performSelector:@selector(good) withObject:@"1234"];
//    NSLog(@"%@",sss);
    
    //比较a,b字符串的大小
//    compareStatus type = [CompareFloat compareA:@"1000.01" withB:@"1000.01"];
    
//    NSString *str1 = @"1000.023";
//    NSString *str2 = @"1000.066";
//
//    float a = [str1 floatValue];
//    float b = [str2 floatValue];
//    float c = a+b ;
//    NSLog(@"float===%f",c);
//
//    NSDecimalNumber *decimalNum = [CompareFloat compareA:@"1000.023" addB:@"1000.066"];
//
//    NSLog(@"123");
    
    
    //创建alert
    _index = 0;
    
//    [self createAlert];
//    [self createAlert];
//    [self createAlert];
//    [self createAlert];
    
//    [self performSelector:@selector(createAlert) withObject:nil afterDelay:0.5];
//    [self performSelector:@selector(createAlert) withObject:nil afterDelay:2];
//    [self performSelector:@selector(createAlert) withObject:nil afterDelay:3];
//    [self performSelector:@selector(createAlert) withObject:nil afterDelay:6];
    
    AddChildVC * vc = [AddChildVC new];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)createAlert{
    
    _index ++;
    NSString *str = [NSString stringWithFormat:@"测试%i",_index];
    UIAlertController * alertCon = [UIAlertController alertControllerWithTitle:str message:@"测试弹出" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alertCon addAction:alertAction];
    dispatch_async(dispatch_get_main_queue(), ^{
        [[PublicMethodManager currentVC] presentViewController:alertCon animated:YES completion:nil];
    });
  
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


static NSString * const prive_Per = @"goo";

-(void)assicotion{
    objc_setAssociatedObject(self, &prive_Per, @"tinti", OBJC_ASSOCIATION_COPY);
    
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
