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

-(void)hdsavfs{
    
}

-(void)btnClick{
    ThreeVC *vc = [[ThreeVC alloc]init];
    vc.modalPresentationStyle =  0 ;
    [self presentViewController:vc animated:YES completion:nil];
    
    
//    NSLog(@"%@", OneVCTitleStr);
//    NSLog(@"%f",OneVCTime);
//    [self operationCreate];
    
    
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
