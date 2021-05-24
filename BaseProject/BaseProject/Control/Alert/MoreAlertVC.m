//
//  MoreAlertVC.m
//  BaseProject
//
//  Created by dlk on 2021/5/21.
//  Copyright © 2021 DLK. All rights reserved.
//

#import "MoreAlertVC.h"

@interface MoreAlertVC ()
@property(nonatomic,strong)NSMutableArray *alertVCArr;

@end

@implementation MoreAlertVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
    button.backgroundColor = [UIColor blueColor];
    [self.view addSubview:button];
    [button addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
//    [NSNotificationCenter def]
}

-(void)btnClick{
    
    
    
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
