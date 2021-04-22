//
//  GCDVC.m
//  BaseProject
//
//  Created by dlk on 2021/3/17.
//  Copyright © 2021 DLK. All rights reserved.
//

#import "GCDVC.h"
#import "OneVC.h"
#import "ThreeVC.h"

@interface GCDVC ()
@property(nonatomic,strong)NSThread *thread;
#import <UIKit/UIKit.h>
#import <objc/runtime.h>
#import <objc/message.h>


@interface GCDVC ()
{
    NSThread *thread ;
}
@property(nonatomic,assign)BOOL isStop;
@end

@implementation GCDVC


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.barTintColor = [UIColor blueColor];
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
//    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
//    [self preferredStatusBarStyle];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   
    
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(100, 100, 100, 50)];
    button.backgroundColor = [UIColor blueColor];
    [self.view addSubview:button];
    [button addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];

    
}


#pragma mark-------NSOperation 的用法

-(void)operationxxx{
    [NSThread sleepForTimeInterval:2];
    NSLog(@"%@",[NSThread currentThread]);
}



- (void) createOperation{
    //两种operation  invocation  blockOperation
    
    
    NSLog(@"start===");
    NSInvocationOperation *operation1 = [[NSInvocationOperation alloc]initWithTarget:self selector:@selector(operationxxx) object:nil];
    
    
//    [operation1 cancel];//取消掉要执行的operation
//    BOOL isCancle =  operation1.isCancelled ;// 是否取消
//    BOOL isFinish = operation1.isFinished ; //是否结束
//    BOOL isExecuting = operation1.isExecuting ; //是否正在执行中
//    BOOL isRead = operation1.isReady;// 是否正在准备中
    
//    [NSOperationQueue mainQueue]
    
    NSBlockOperation *blockOperation1 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"1======%@",[NSThread currentThread]);
    }];
    
    NSBlockOperation *blockOperation2 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"2======%@",[NSThread currentThread]);
    }];
    NSBlockOperation *blockOperation3 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"3======%@",[NSThread currentThread]);
    }];
    NSBlockOperation *blockOperation4 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"4======%@",[NSThread currentThread]);
    }];
    NSBlockOperation *blockOperation5 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"5======%@",[NSThread currentThread]);
    }];
    
    [blockOperation2 addDependency: blockOperation4];
    
    
//      blockOperation4 addExecutionBlock:<#^(void)block#>
    NSOperationQueue *queue = [[NSOperationQueue alloc]init];
    [queue addOperation:operation1];
    
    queue.maxConcurrentOperationCount =1;
    blockOperation5.queuePriority = NSOperationQueuePriorityVeryHigh;
    
    [queue addOperation:blockOperation1];
    [queue addOperation:blockOperation2];
    [queue addOperation:blockOperation3];
    [queue addOperation:blockOperation4];
    [queue addOperation:blockOperation5];
    
    
    NSLog(@"read1=====%i",blockOperation1.isReady);
    NSLog(@"read2=====%i",blockOperation2.isReady);
    NSLog(@"read3=====%i",blockOperation3.isReady);
    NSLog(@"read4=====%i",blockOperation4.isReady);
    NSLog(@"read5=====%i",blockOperation5.isReady);
    
    

//    [operation1 start] ;// 直接启动operation 开启线程执行函数
//
    NSLog(@"end==="); //用 start 启动方式 end 是最后执行的因为主线程中执行
    //用 queue 方式 end 不是最后输出,确实开辟了新的线程
    
    
    
    
/*
    NSBlockOperation *blockOperation = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"10======%@",[NSThread currentThread]);
//        任务执行可能在当前线程下也可能在开辟新的线程（当执行了多个addExecution后由系统决定），一般多个的话就会开辟新的线程
    }];

    [blockOperation addExecutionBlock:^{
        for (int i=0; i<5; i++) {
            NSLog(@"%i========%@",i,[NSThread currentThread]);
        }
    }];
    [blockOperation addExecutionBlock:^{
        [NSThread sleepForTimeInterval:2];
        for (int i=0; i<5; i++) {
            NSLog(@"%i========%@",i,[NSThread currentThread]);
        }
    }];
    
    [blockOperation addExecutionBlock:^{
//        [NSThread sleepForTimeInterval:2];
        for (int i=0; i<5; i++) {
            NSLog(@"%i========%@",i,[NSThread currentThread]);
        }
    }];
    [blockOperation start];
    NSLog(@"end=====");  //发现End 是最后执行，不管是否开辟新的线程都说最后执行的
 */

    
}










#pragma mark ------ runloop 用法

-(void)runloop1{

    //模式监听 ，可以监听模式的变化简单的功能
    
    //观察对象
    CFRunLoopObserverRef  observer = CFRunLoopObserverCreateWithHandler(CFAllocatorGetDefault(), kCFRunLoopAllActivities, YES, 0, ^(CFRunLoopObserverRef observer, CFRunLoopActivity activity) {
        NSLog(@"当前的状态===%zd",activity);
        
    });
    
    //给当前的runloop 添加观察者对象
    CFRunLoopAddObserver(CFRunLoopGetCurrent(), observer, kCFRunLoopDefaultMode);
    
    //C语言需要释放内存
    CFRelease(observer);
    
    
}
-(void)runloop2{
    //当前的 RunLoop
    CFRunLoopRef  currentLoop = CFRunLoopGetCurrent();
    
    //创建观察者上下文
//
//    typedef struct {
//        CFIndex    version;
//        void *    info;
//        const void *(*retain)(const void *info);
//        void    (*release)(const void *info);
//        CFStringRef    (*copyDescription)(const void *info);
//    } CFRunLoopObserverContext;
    
    CFRunLoopObserverContext  contex = {
        0,
        (__bridge void *)(self) ,//桥接 给contex 添加当前对象
        &CFRetain,
        &CFRelease,
        NULL
    };
    
    CFRunLoopObserverRef observer = CFRunLoopObserverCreate(CFAllocatorGetDefault(), kCFRunLoopAllActivities, YES, 0, &ObserverCallback, &contex);
    
    CFRunLoopAddObserver(currentLoop, observer, kCFRunLoopDefaultMode);
    
    CFRelease(observer);
    

}

static void ObserverCallback (CFRunLoopObserverRef observerRef , CFRunLoopActivity activity , void  * info){
    
    //观察的回调函数与参数
    UIViewController *viewC = (__bridge UIViewController  *)(info);
    
     
}

-(void)hdsavfs{
    
}

-(void)btnClick{
    ThreeVC *vc = [[ThreeVC alloc]init];
    vc.modalPresentationStyle =  0 ;
    [self presentViewController:vc animated:YES completion:nil];
    
    
//    NSLog(@"%@", OneVCTitleStr);
//    NSLog(@"%f",OneVCTime);
//    [self operationCreate];
    if (activity == kCFRunLoopBeforeWaiting) {
        //即将进入休眠模式
    }
}

-(void)runloop3{
    //线程保活，或者保活后去除保活状态
    
    __weak typeof(self) weakSelf  = self;
    thread = [[NSThread alloc]initWithBlock:^{
        NSRunLoop *runloop = [NSRunLoop currentRunLoop];
        [runloop addPort:[NSPort port] forMode:NSDefaultRunLoopMode];
        
        while (weakSelf && !weakSelf.isStop) {
            [runloop runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
        }
    }];
    thread.name  = @"线程C";
    [thread start];
    
}

-(void)operaction1{
    NSLog(@"invocation =====%@",[NSThread currentThread]);
}

- (void) moreBlockOper{
    NSBlockOperation *opreation = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"block1====%@",[NSThread currentThread]);
    }];
    for (int i =0; i<40; i++) {
        [opreation addExecutionBlock:^{
            NSLog(@"block%i====%@",i,[NSThread currentThread]);
            if (![NSThread currentThread].isMainThread) {
                
                NSLog(@"block%i====%@",i,@"子线程");
                sleep(1);
            }
        }];
    }
    [opreation start];
}


- (void)operationCreate{
//    NSInvocationOperation * operaction1 = [[NSInvocationOperation alloc]initWithTarget:self selector:@selector(operation1) object:nil];
//
//    [operaction1 start];
    
 
    
    
    NSLog(@"start");
   
//    [self moreBlockOper];  不光blockOperation 添加多少execution  end 是最后输出的（即使block内部的是子线程执行的）

    
    NSBlockOperation *opreation2 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"block1====%@",[NSThread currentThread]);
    }];
    
    NSOperationQueue *queue = [[NSOperationQueue alloc]init];
    [queue addOperation:opreation2];
    queue.maxConcurrentOperationCount =1 ;
    
    NSLog(@"end");
    
}


-(void)sound{
    UIImpactFeedbackGenerator *impactLight = [[UIImpactFeedbackGenerator alloc]initWithStyle:UIImpactFeedbackStyleLight];
    [impactLight impactOccurred];
}

-(void)createThread{
    self.thread = [[NSThread alloc]initWithBlock:^{
        NSLog(@"当前线程========%@",[NSThread currentThread]);
        NSRunLoop *loop = [NSRunLoop currentRunLoop];
        [loop addPort:[NSMachPort port] forMode:NSRunLoopCommonModes];
        [loop run];
    }];
}

-(void)ttt123{
    NSLog(@"start======%@",[NSThread currentThread]);
    dispatch_queue_t queue = dispatch_queue_create("com.ddd", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_async(queue, ^{
        NSLog(@"1======%@",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"2======%@",[NSThread currentThread]);
        [NSThread sleepForTimeInterval:2];
    });
    dispatch_barrier_sync(queue, ^{
        NSLog(@"100======%@",[NSThread currentThread]);
    });
    
    dispatch_async(queue, ^{
        NSLog(@"3======%@",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"4======%@",[NSThread currentThread]);
    });
    NSLog(@"end==========");
    
//    [NSRunLoop currentRunLoop]
=======
//-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    [self performSelector:@selector(clickSome) onThread:thread withObject:nil waitUntilDone:YES];
//}
-(void)clickSome{
    NSLog(@"当前线程====%@",[NSThread currentThread]);
}


-(void)btnClick{
    [self createOperation];
}

-(void)semphore1{
    //信号量用法
    
    NSLog(@"1======%@",[NSThread currentThread]);
    dispatch_queue_t  queue = dispatch_get_global_queue(0, 0);
    
    dispatch_semaphore_t semm = dispatch_semaphore_create(0);
    dispatch_async(queue, ^{
        //创建子线程
        NSLog(@"3=======%@",[NSThread currentThread]);
        dispatch_semaphore_signal(semm);
    });
    
    dispatch_semaphore_wait(semm, DISPATCH_TIME_FOREVER);
    
    NSLog(@"2======%@",[NSThread currentThread]);
}

-(void)operation1{
    
    NSBlockOperation * blockOp1 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"1-------%@",[NSThread currentThread]);
    }];
    NSBlockOperation * blockOp2 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"2-------%@",[NSThread currentThread]);
    }];
    NSBlockOperation * blockOp3 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"3-------%@",[NSThread currentThread]);
    }];
    NSBlockOperation * blockOp4 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"4-------%@",[NSThread currentThread]);
    }];
    [blockOp4 addExecutionBlock:^{
        NSLog(@"block4------%@",[NSThread currentThread]);
    }];
    
    blockOp3.queuePriority = NSOperationQueuePriorityVeryHigh;
    [blockOp1 addDependency:blockOp4];
   
    
    NSOperationQueue *queue = [[NSOperationQueue alloc]init];
    
    [queue addOperation:blockOp1];
    [queue addOperation:blockOp2];
    [queue addOperation:blockOp3];
    [queue addOperation:blockOp4];
    
    
    
}



-(void)test2{
    //串行队列+异步
    
    NSLog(@"%@",[NSThread currentThread]);
    dispatch_queue_t queue = dispatch_queue_create("com.dlk.queue.serial", DISPATCH_QUEUE_SERIAL);
    dispatch_async(queue, ^{
        
        NSLog(@"%@",[NSThread currentThread]);
    });
    NSLog(@"1");
    dispatch_async(queue, ^{
        NSLog(@"%@",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"%@",[NSThread currentThread]);
    });
    NSLog(@"2");
    

}

-(void)test3{
    //串队列+ 同步
    NSLog(@"%@",[NSThread currentThread]);
    dispatch_queue_t queue = dispatch_queue_create("com.dlk.queue.serial", DISPATCH_QUEUE_SERIAL);
    dispatch_sync(queue, ^{
        
        NSLog(@"%@",[NSThread currentThread]);
    });
    NSLog(@"1");
    dispatch_sync(queue, ^{
        NSLog(@"%@",[NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"%@",[NSThread currentThread]);
    });
    NSLog(@"2");
    
}
-(void)test4{
    //在子线程中 用同步+ 主队列
    dispatch_queue_t queue = dispatch_queue_create("com.dlk.queue.serial", DISPATCH_QUEUE_SERIAL);
    dispatch_async(queue, ^{
        
        NSLog(@"%@",[NSThread currentThread]);
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            
            NSLog(@"%@",[NSThread currentThread]);
        });
    });
    
}

- (void) test5{
    //同步+串行队列在主线程运行
    
    dispatch_queue_t queue = dispatch_queue_create("come.dlk.serial", DISPATCH_QUEUE_SERIAL);
    dispatch_sync(queue, ^{
        NSLog(@"%@",[NSThread currentThread]);
    });
}

-(void)test6{
    //GCD group
    
    dispatch_group_t  group = dispatch_group_create();
    
    dispatch_group_async(group, dispatch_get_global_queue(0, 0), ^{
        
        NSLog(@"1-------%@",[NSThread currentThread]);
    });
    
    dispatch_group_async(group, dispatch_get_global_queue(0, 0), ^{
        
        NSLog(@"2-------%@",[NSThread currentThread]);
    });
    
    dispatch_group_async(group, dispatch_get_global_queue(0, 0), ^{
       
//        [NSThread sleepForTimeInterval:2];
        
        NSLog(@"3-------%@",[NSThread currentThread]);
    });
    
    dispatch_group_enter(group);
    dispatch_async(dispatch_get_global_queue(0, 0 ), ^{
        // 在 group 中 dispatch_async + main_queue  是主线程
        NSLog(@"enter--leave ------- %@",[NSThread currentThread]);
        
    });
    
//    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
    
    dispatch_group_async(group, dispatch_get_global_queue(0, 0), ^{
        
        NSLog(@"4-------%@",[NSThread currentThread]);
    });
    
    dispatch_group_async(group, dispatch_get_global_queue(0, 0), ^{
        
        NSLog(@"5-------%@",[NSThread currentThread]);
        dispatch_group_leave(group);
    });

    NSLog(@"end--------group");
    
    
    
    
//    dispatch_group_notify(group, dispatch_get_global_queue(0, 0), ^{
//
//        //线程与最后执行的任务线程是同样的并没有开辟新的线程
//        NSLog(@"end_notify------%@",[NSThread currentThread]);
//    });
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        
        //主线程线程
        NSLog(@"end_notify------%@",[NSThread currentThread]);
    });
    
    
   
    void (^blockxx)(void) = ^(void){
       
        NSLog(@"123456");
    };
    blockxx ();
    
    

    
    
}

-(void)test1{
    
    dispatch_queue_t queue = dispatch_queue_create("dlk.create.queue", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_sync(queue, ^{
        NSLog(@"1");
        dispatch_sync(queue, ^{
            sleep(1);
            NSLog(@"0");
        });
        NSLog(@"2");
    });
    
    
    dispatch_queue_t queue1 = dispatch_queue_create("ccc.commg",DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue1, ^{
        
    });
    
    
    dispatch_queue_t  queue2 = dispatch_get_global_queue(0, 0);
    

    dispatch_sync(queue2, ^{
        
    });
    
    
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSLog(@"124355");
    });
    
    
    
    
//    NSLog(@"100");  
//    dispatch_sync(queue, ^{
////        [NSThread sleepForTimeInterval:1];
//        NSLog(@"2");
//    });
//    dispatch_async(queue, ^{
////        sleep(1);
//        NSLog(@"3");
//    });
//    dispatch_async(queue, ^{
////        sleep(1);
//        NSLog(@"4");
//    });
//
//    dispatch_async(queue, ^{
//        NSLog(@"4");
//    });
//    dispatch_async(queue, ^{
//        NSLog(@"5");
//    });
//    dispatch_sync(queue, ^{
////        sleep(1);
//        NSLog(@"0");
//    });
    
//    NSLog(@"100");
    
//    dispatch_async(queue, ^{
//
//        NSLog(@"101");
//    });
//    
//    
//    dispatch_async(queue, ^{
//
//        NSLog(@"102");
//    });
    
}


-(void)operationNotify{
    NSInvocationOperation *operation = [[NSInvocationOperation alloc]initWithTarget:self selector:@selector(operationSEL:) object:nil];
    [operation start];
    
    NSBlockOperation *operationBlock = [NSBlockOperation blockOperationWithBlock:^{
        //当前线程下执行
        NSLog(@"block");
    }];
    [operationBlock start];
    
    
    
}
-(void)operationSEL:(id ) oper {
    //在当前线程下执行
    
    NSLog(@"%@",[NSThread currentThread]);
    
    
}

-(void)oper1{
    NSBlockOperation *blockOperation1 = [NSBlockOperation blockOperationWithBlock:^{
        //在主线程中执行
        for (int i=0; i<3; i++) {
            NSLog(@"A=====%@",[NSThread currentThread]);
        }
        
    }];
    
    NSBlockOperation *blockOperation2 = [NSBlockOperation blockOperationWithBlock:^{
        //在主线程中执行
        for (int i=0; i<3; i++) {
            NSLog(@"B=====%@",[NSThread currentThread]);
        }
        
    }];
    
    NSBlockOperation *blockOperation3 = [NSBlockOperation blockOperationWithBlock:^{
        //在主线程中执行
        for (int i=0; i<3; i++) {
            NSLog(@"C=====%@",[NSThread currentThread]);
        }
        
    }];
    
    NSBlockOperation *blockOperation4 = [NSBlockOperation blockOperationWithBlock:^{
        //在主线程中执行
        for (int i=0; i<3; i++) {
            NSLog(@"D=====%@",[NSThread currentThread]);
        }
        
    }];
    
    [blockOperation4 addDependency:blockOperation1];
    [blockOperation4 addDependency:blockOperation2];
    
    NSBlockOperation *blockOperation5 = [NSBlockOperation blockOperationWithBlock:^{
        //在主线程中执行
        for (int i=0; i<3; i++) {
            NSLog(@"E=====%@",[NSThread currentThread]);
        }
        
    }];
    
    [blockOperation5 addDependency:blockOperation2];
    [blockOperation5 addDependency:blockOperation3];
    
    NSBlockOperation *blockOperation6 = [NSBlockOperation blockOperationWithBlock:^{
        //在主线程中执行
        for (int i=0; i<3; i++) {
            NSLog(@"F=====%@",[NSThread currentThread]);
        }
        
    }];
    [blockOperation6 addDependency:blockOperation4];
    [blockOperation6 addDependency:blockOperation5];
    
    NSOperationQueue *queue = [[NSOperationQueue alloc]init];
    [queue addOperation:blockOperation1];
    [queue addOperation:blockOperation2];
    [queue addOperation:blockOperation3];
    [queue addOperation:blockOperation4];
    [queue addOperation:blockOperation5];
    [queue addOperation:blockOperation6];
    
    NSBlockOperation *vvvBlockOp = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"10------%@",[NSThread currentThread]);
    }];
    
    [queue addOperations:@[vvvBlockOp] waitUntilFinished:YES];
    
}

-(void)gcdCreate{
     
    NSLog(@"stare======%@",[NSThread currentThread]);
    NSBlockOperation *blockOp = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"now ======%@",[NSThread currentThread]);
        
        dispatch_semaphore_t  semaphore = dispatch_semaphore_create(0);
         
        NSLog(@"1--------------");
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        NSLog(@"2--------------");
        
        dispatch_semaphore_signal(semaphore);
        NSLog(@"3--------------");
    }];
   
    NSOperationQueue *queue = [[NSOperationQueue alloc]init];
    [queue addOperation:blockOp];
    
 
}

-(void)addBlockOperation{
    NSBlockOperation *blockOperation = [NSBlockOperation blockOperationWithBlock:^{
        //在主线程中执行
        NSLog(@"%@",[NSThread currentThread]);
    }];
    [blockOperation addExecutionBlock:^{
        //默认在当前线程下执行，但是当任务多时（或者系统决定）会开启新的线程执行
            NSLog(@"%@",[NSThread currentThread]);
    }];
    
    NSOperationQueue *queue = [NSOperationQueue mainQueue];
    //主队列，在主队列中执行的任务都是在主线程中执行，除了addExecutionBlock 操作下的任务（可能会开辟新线程）
    
    [queue addOperation:blockOperation];
    
    queue.maxConcurrentOperationCount = 1;
    
    
}
//-(void)test2{
//    dispatch_barrier_sync(<#dispatch_queue_t  _Nonnull queue#>, <#^(void)block#>)
//}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
