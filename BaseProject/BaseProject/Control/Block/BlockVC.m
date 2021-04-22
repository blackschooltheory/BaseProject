//
//  BlockVC.m
//  BaseProject
//
//  Created by dlk on 2021/3/28.
//  Copyright © 2021 DLK. All rights reserved.
//

#import "BlockVC.h"
#import "BlockMode.h"

@interface BlockVC ()
@property (nonatomic , strong) NSString *good;
@end

@implementation BlockVC

- (void)viewDidLoad {

    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
    button.backgroundColor = [UIColor blueColor];
    [self.view addSubview:button];
    [button addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    
//    NSString *goodStr = @"1";
//    __weak typeof(self) weakSelf =self;
//    _good = @"hellow";
//    simpleBlock = ^(NSString *sss){
//         NSLog(@"%@", weakSelf.good);
//    };
//    simpleBlock (@"");
//    NSLog(@"%@",[simpleBlock class]);
    
//   void (^blockReturn) (void) = [self blockReturn];
//
//    blockReturn();
//
//    NSString * (^sss)(void) =  ^(void){
//        NSLog(@"");
//        return @"";
//    };
//
//    id (^ggg)(void) =   ^(void){
//
//        return @"gg";
//    };
//    ggg();
}


-(void (^)(void) )blockReturn{
    
    
    void (^ggggBlock)(NSString *ss) = ^(NSString *str){
        
    };
    
    return ^(void){
        NSLog(@"this is a return block function");
    };
}

void (^simpleBlock)(NSString *str);

- (void) btnClick{
//    simpleBlock (@"");
    _good = @"hellow";
    
    BlockMode *model = [[BlockMode alloc]init];
   [ model creatBlock:^NSString *  (NSString * _Nonnull sstr) {
       NSLog(@"%@", self.good);
       self.good = sstr;
       
       //开启线程做耗时操作导致当前的 model对象已经释放,操作model数据时就会直接返回空，这个时候需要在block 内部强引用 model 数据，不让其在执行完后就释放
       
       return  @"给你一个回馈";
    }];
    
    NSLog(@"good===%@",self.good);
    
    
    [model setValue:@"good" forKey:@"name"];
   
   
    
}
-(void)dealloc{
    NSLog(@"没有循环引用，释放了当前对象");
}

-(void)httpManager{
    
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
