//
//  AddChildVC.m
//  BaseProject
//
//  Created by dlk on 2021/5/23.
//  Copyright © 2021 DLK. All rights reserved.
//

#import "AddChildVC.h"
#import "Child_OneVC.h"
#import "Child_TwoVC.h"

@interface AddChildVC ()
@property(nonatomic,strong)Child_OneVC *oneVC;

@end

@implementation AddChildVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
    button.backgroundColor = [UIColor blueColor];
    [self.view addSubview:button];
    [button addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton *button2 = [[UIButton alloc]initWithFrame:CGRectMake(250, 100, 100, 100)];
    button2.backgroundColor = [UIColor blueColor];
    [self.view addSubview:button2];
    [button2 addTarget:self action:@selector(btn2Click) forControlEvents:UIControlEventTouchUpInside];
    
}

/*
 addChildViewController 可以在当前页面添加其他的VC的View 并且父页面可以传递子页面的转屏，以及外观事件
  当收到内存警告时可以删除未显示View(而之前我们页面中加载了（登录失败的提示View，上传附件成功的提示View，网络失败的提示View等这些虽然少，但是一直都在我们内存中）)
 */
- (void) btnClick{
    _oneVC = [Child_OneVC new];
    _oneVC.view.frame =CGRectMake(0, 200, [PublicMethodManager screenWith], 300);
    [self addChildViewController:_oneVC];
    [self.view addSubview:_oneVC.view];
    [_oneVC didMoveToParentViewController:self];
//   self didMoveToParentViewController
}
- (void)btn2Click{
    
    Child_TwoVC *vc = [Child_TwoVC new];
    [self addChildViewController:vc];
    [self transitionFromViewController:_oneVC toViewController:vc duration:0.2 options:UIViewAnimationOptionTransitionCrossDissolve animations:nil completion:^(BOOL finished) {

//        if (finished) {
//
//                        [vc didMoveToParentViewController:self];
//                        [_oneVC willMoveToParentViewController:nil];
//                        [_oneVC removeFromParentViewController];
//                    }else{
//
//                        }
    }];
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
