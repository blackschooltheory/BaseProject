//
//  TimerVC.m
//  BaseProject
//
//  Created by dlk on 2021/6/11.
//  Copyright © 2021 DLK. All rights reserved.
//

#import "TimerVC.h"
#import "TimerModel.h"
#import "UIView+touch.h"
#import <Masonry/Masonry.h>
#import "timerView.h"
@interface TimerVC ()
@property(nonatomic,strong)NSTimer *timer;
@property(nonatomic,assign)NSInteger numIndex;
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
    /*
     
     
    TimerModel *model = [TimerModel new];
    model.targetVC = self;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:model selector:@selector(timeClick) userInfo:nil repeats:YES];
    _numIndex = 0;
     
     */
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
    button.backgroundColor = [UIColor blueColor];
    [self.view addSubview:button];
    [button addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    
//    self.view.userInteractionEnabled = NO;
//    button.userInteractionEnabled = YES;
    [self.view ggggg];
    
    timerView *vv = [[timerView alloc]init];
    [self.view addSubview:vv];
    [vv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(button.mas_bottom).offset(30);
        make.centerX.equalTo(self.view.mas_centerX);
        make.centerY.equalTo(self.view.mas_centerY);
        make.width.mas_offset(100);
        make.height.mas_offset(100);
    }];
    
    
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"touch 了");
}
-(void)btnClick{
    NSLog(@"按钮点击");
}
-(void)timeClick{
    NSLog(@"------%@----",[self class]);
    _numIndex ++;
    if (_numIndex == 5) {
        [PublicMethodManager alertTitle:@"显示弹框"];
    }
    
    
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
