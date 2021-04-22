//
//  RunLoopFunctionVC.m
//  BaseProject
//
//  Created by dlk on 2021/4/13.
//  Copyright © 2021 DLK. All rights reserved.
//

#import "RunLoopFunctionVC.h"

@interface RunLoopFunctionVC (){
    NSThread *thread ;
}
@property(nonatomic,assign) BOOL isStoploop;
@end

@implementation RunLoopFunctionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
 
    
    UIButton *button1 = [[UIButton alloc]initWithFrame:CGRectMake(100, 100, 100, 50)];
    button1.backgroundColor = [UIColor blueColor];
    [self.view addSubview:button1];
    [button1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button1 setTitle:@"线程保活" forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(btnClick1) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *button2 = [[UIButton alloc]initWithFrame:CGRectMake(100, 200, 100, 50)];
    button2.backgroundColor = [UIColor blueColor];
    [self.view addSubview:button2];
    [button2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button2 setTitle:@"runloop 监听模式切换" forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(btnClick2) forControlEvents:UIControlEventTouchUpInside];
    
//    UIButton *button3 = [[UIButton alloc]initWithFrame:CGRectMake(100, 300, 100, 50)];
//    button3.backgroundColor = [UIColor blueColor];
//    [self.view addSubview:button3];
//    [button3 addTarget:self action:@selector(btnClick3) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
    
}

-(void)btnClick1{
    
    thread = [[NSThread alloc]initWithTarget:self selector:@selector(threadSelect) object:nil];
    thread.name = @"线程RC";
    [thread start];
    
    
}
-(void)threadSelect{
    NSLog(@"%@",thread);
    [[NSRunLoop currentRunLoop] addPort:[NSPort port] forMode:NSDefaultRunLoopMode];
//    [[NSRunLoop currentRunLoop] run];
    __weak typeof(self) weakSelf = self;
    while (weakSelf && !_isStoploop) {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
        NSLog(@"当前线程=======%@",[NSThread currentThread]);
    }
    
    
//    NSLog(@"线程跑来拉");
}
-(void)btnClick2{
    NSLog(@"%@",thread);
    
    [self performSelector:@selector(callSelect) onThread:thread withObject:nil waitUntilDone:YES];
    NSLog(@"end=====");
//waitUntilDone:NO 不阻塞当前线程，会先打印出 end=====
}
-(void)callSelect{
//    NSLog(@"22222===%@",thread);
    _isStoploop = YES;
    CFRunLoopStop(CFRunLoopGetCurrent());
    
}

-(void)createObserver{
    //对runloop 的运行模式中的状态进行监听
    CFRunLoopRef runloop = CFRunLoopGetCurrent();
    CFRunLoopObserverContext context = {
        0,
        (__bridge void *)(self),
        &CFRetain,
        &CFRelease,
        NULL
    };
    CFRunLoopObserverRef observerCF = CFRunLoopObserverCreate(kCFAllocatorDefault, kCFRunLoopAllActivities, YES, 0, &obserCall, &context);
    CFRunLoopAddObserver(runloop, observerCF, kCFRunLoopDefaultMode);
    CFRelease(observerCF);
}

static void obserCall (CFRunLoopObserverRef observer, CFRunLoopActivity activity, void *info ){
    UIViewController *vc = (__bridge UIViewController *)(info);
    
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
