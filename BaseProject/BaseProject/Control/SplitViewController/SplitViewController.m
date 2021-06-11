//
//  SplitViewController.m
//  BaseProject
//
//  Created by dlk on 2021/6/9.
//  Copyright © 2021 DLK. All rights reserved.
//

#import "SplitViewController.h"
#import "MasterVC.h"
#import "DetailVC.h"

@interface SplitViewController ()<UISplitViewControllerDelegate>
@property(nonatomic,strong)UISplitViewController *splitVC;
@end

@implementation SplitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    /*
      iphone  是不能用 UISplitViewController 分屏视图控制器   ipad 才能用
     iPhone 自定义分屏控制器
     */
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
    button.backgroundColor = [UIColor blueColor];
    [self.view addSubview:button];
    [button addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    
   
    
    
}
-(void)btnClick{
    _splitVC = [[UISplitViewController alloc]init];
    MasterVC *masterVC = [MasterVC new];
    DetailVC *detailVC = [DetailVC new];
    _splitVC.viewControllers = @[masterVC,detailVC];
    _splitVC.delegate = self;
    _splitVC.preferredDisplayMode = UISplitViewControllerDisplayModeAllVisible;
    _splitVC.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:_splitVC animated:YES completion:nil];
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
