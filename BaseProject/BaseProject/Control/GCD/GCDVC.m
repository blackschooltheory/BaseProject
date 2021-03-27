//
//  GCDVC.m
//  BaseProject
//
//  Created by dlk on 2021/3/17.
//  Copyright © 2021 DLK. All rights reserved.
//

#import "GCDVC.h"




@interface GCDVC ()

@end

@implementation GCDVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(100, 100, 100, 50)];
    button.backgroundColor = [UIColor blueColor];
    [self.view addSubview:button];
    [button addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
    
}
-(void)btnClick{
    [self test5];
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
