//
//  TimerVC.m
//  BaseProject
//
//  Created by dlk on 2021/6/11.
//  Copyright © 2021 DLK. All rights reserved.
//

#import "TimerVC.h"
#import "TimerModel.h"
@interface TimerVC ()
@property(nonatomic,strong)NSTimer *timer;
@end

@implementation TimerVC
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    /*
      把model换成 NSProxy 更加的轻量;
     */
    TimerModel *model = [TimerModel new];
    model.targetVC = self;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:model selector:@selector(timeClick) userInfo:nil repeats:YES];
    
    
}
-(void)timeClick{
    NSLog(@"------%@----",[self class]);
}
-(void)dealloc{
    NSLog(@"------%@ delloc----",[self class]);
    [self.timer invalidate];
    self.timer = nil;
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
