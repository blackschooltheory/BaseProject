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
#import "KVOModel.h"

@interface Performance ()<UIDocumentPickerDelegate>
@property(nonatomic,assign)NSInteger index;
@property(nonatomic,strong)UIDocumentPickerViewController *documentVC;

@end

@implementation Performance

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
    button.backgroundColor = [UIColor grayColor];
    [button addTarget:self action:@selector(click2) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}
-(UIDocumentPickerViewController *)documentVC{
    if (!_documentVC ){
        NSArray *typeArr = @[@"public.content",@"public.text"];
        
        _documentVC = [[UIDocumentPickerViewController alloc]initWithDocumentTypes:typeArr inMode:UIDocumentPickerModeOpen];
        _documentVC.delegate = self;
        _documentVC.modalPresentationStyle = UIModalPresentationFullScreen;
    }
        return _documentVC;
}
-(void)click2{
    
    
    [self presentViewController:self.documentVC animated:YES completion:nil];
    
}

#pragma  mark------选中文档回调
-(void)documentPicker:(UIDocumentPickerViewController *)controller didPickDocumentsAtURLs:(NSArray<NSURL *> *)urls{
    // 获取授权
       BOOL fileUrlAuthozied = [urls.firstObject startAccessingSecurityScopedResource];
       if (fileUrlAuthozied) {
           // 通过文件协调工具来得到新的文件地址，以此得到文件保护功能
           NSFileCoordinator *fileCoordinator = [[NSFileCoordinator alloc] init];
           NSError *error;
           
           [fileCoordinator coordinateReadingItemAtURL:urls.firstObject options:0 error:&error byAccessor:^(NSURL *newURL) {
               // 读取文件
               NSString *fileName = [newURL lastPathComponent];
               NSError *error = nil;
               NSData *fileData = [NSData dataWithContentsOfURL:newURL options:NSDataReadingMappedIfSafe error:&error];
               if (error) {
                   // 读取出错
               } else {
                   // 上传
                   NSLog(@"fileName : %@", fileName);
                   // [self uploadingWithFileData:fileData fileName:fileName fileURL:newURL];
                   
                   NSString *base64string = [fileData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];

               }
               [self dismissViewControllerAnimated:YES completion:NULL];
           }];
           [urls.firstObject stopAccessingSecurityScopedResource];
       } else {
           // 授权失败
       }
}

#pragma mark-----上传APP文档到系统中
- (void)downLoadWithFilePath:(NSString *)filePath {
    float version = [[[UIDevice currentDevice] systemVersion] floatValue];
    if (version >= 11) {
        
    } else {
//        [MBProgressHUD showError:@"下载文件要求手机系统版本在11.0以上"];
        return;
    }
    /**
    /// 保存网络文件到沙盒一
    NSURLRequest *req = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:filePath]];
    NSData *fileData = [NSURLConnection sendSynchronousRequest:req returningResponse:nil error:nil];
    NSString *temp = NSTemporaryDirectory();
    NSFileManager *fm = [NSFileManager defaultManager];
    NSString *fullPath = [self getNativeFilePath:[filePath componentsSeparatedByString:@"/"].lastObject];
    BOOL downResult = [fm createFileAtPath:fullPath contents:fileData attributes:nil];
    */
    /// 保存网络文件到沙盒二
    NSData *fileData = [NSData dataWithContentsOfURL:[NSURL URLWithString:filePath]];
    NSString *fullPath = [self getNativeFilePath:[filePath componentsSeparatedByString:@"/"].lastObject];
    BOOL downResult = [fileData writeToFile:fullPath atomically:YES];
    
    if (downResult) {
        UIDocumentPickerViewController *documentPickerVC = [[UIDocumentPickerViewController alloc] initWithURL:[NSURL fileURLWithPath:fullPath] inMode:UIDocumentPickerModeExportToService];
        // 设置代理
        documentPickerVC.delegate = self;
        // 设置模态弹出方式
        documentPickerVC.modalPresentationStyle = UIModalPresentationFormSheet;
        [self.navigationController presentViewController:documentPickerVC animated:YES completion:nil];
    }
}
 
// 获得文件沙盒地址
- (NSString *)getNativeFilePath:(NSString *)fileName {
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *munu = [NSString stringWithFormat:@"%@/%@",@"downLoad",fileName];
    NSString *filePath = [path stringByAppendingPathComponent:munu];
    // 判断是否存在,不存在则创建
    NSFileManager *fileManager = [NSFileManager defaultManager];
    // fileExistsAtPath 判断一个文件或目录是否有效，isDirectory判断是否一个目录
    BOOL isDir = NO;
    NSMutableArray *theArr = [[filePath componentsSeparatedByString:@"/"] mutableCopy];
    [theArr removeLastObject];
    NSString *thePath = [theArr componentsJoinedByString:@"/"];
    BOOL existed = [fileManager fileExistsAtPath:thePath isDirectory:&isDir];
    if ( !(isDir == YES && existed == YES) ) { // 如果文件夹不存在
        [fileManager createDirectoryAtPath:thePath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return filePath;
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
    
//    AddChildVC * vc = [AddChildVC new];
//    [self.navigationController pushViewController:vc animated:YES];
    
    KVOModel *model = [[KVOModel alloc]init];

    //监听 Model 对象的属性 name 的赋值，
    [ model addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:(__bridge void * _Nullable)(@{@"obj":@"对象"})];
    model.name = @"我的名字是ddd";
    /*
     移除观察
     [self removeObserver:self forKeyPath:@“name"];
     */
    
}

#pragma  mark -------- KVO 监听事件执行方法
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"name"]) {
        NSLog(@"change==%@",change);
        NSString *name =(NSString *) change[@"new"];//赋值的新数据
        
        NSString *oldName =(NSString *) change[@"old"];//老数据
        [PublicMethodManager alertTitle:name];
        
    }
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
