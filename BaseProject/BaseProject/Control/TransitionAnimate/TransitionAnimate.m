//
//  TransitionAnimate.m
//  BaseProject
//
//  Created by DLK on 2021/1/25.
//  Copyright © 2021 DLK. All rights reserved.
//

#import "TransitionAnimate.h"
#import "PublicMethodManager.h"
#import "ModelPresentVC.h"

@interface TransitionAnimate ()

@end

@implementation TransitionAnimate

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIStackView *stakeView = [[UIStackView alloc]initWithFrame:CGRectMake(0, 64,[PublicMethodManager screenWith] , [PublicMethodManager screenHeight]-64)];
    stakeView.axis = UILayoutConstraintAxisVertical;
    stakeView.alignment = UIStackViewAlignmentFill ;
    stakeView.distribution = UIStackViewDistributionFillEqually;
    [self.view addSubview: stakeView];
    
    UIButton *button1 = [[UIButton alloc]init];
    button1.tag=100;
    button1.backgroundColor = [UIColor blueColor];
    [button1 setTitle:@"模态由下往上弹出动画" forState:UIControlStateNormal];
    [stakeView addArrangedSubview:button1];
    
    UIButton *button2 = [[UIButton alloc]init];
    button2.tag=200;
    button2.backgroundColor = [UIColor greenColor];
    [button2 setTitle:@"模态左右翻转动画" forState:UIControlStateNormal];
    [stakeView addArrangedSubview:button2];
    
    UIButton *button3 = [[UIButton alloc]init];
    button3.tag=300;
    button3.backgroundColor = [UIColor redColor];
    [button3 setTitle:@"模态淡入淡出动画" forState:UIControlStateNormal];
    [stakeView addArrangedSubview:button3];
    
    UIButton *button4 = [[UIButton alloc]init];
    button4.tag=400;
    button4.backgroundColor = [UIColor yellowColor];
    [button4 setTitle:@"模态书页翻转动画" forState:UIControlStateNormal];
    [stakeView addArrangedSubview:button4];
    
    UIButton *button5 = [[UIButton alloc]init];
    button5.tag=500;
    button5.backgroundColor = [UIColor orangeColor];
    [button5 setTitle:@"导航栏推出动画" forState:UIControlStateNormal];
    [stakeView addArrangedSubview:button5];
    
    UIButton *button6 = [[UIButton alloc]init];
    button6.backgroundColor = [UIColor blueColor];
    [button6 setTitle:@"导航栏推出动画" forState:UIControlStateNormal];
    [stakeView addArrangedSubview:button6];
    
    [button1 addTarget:self action:@selector(modelPresentClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [button2 addTarget:self action:@selector(modelPresentClick:) forControlEvents:UIControlEventTouchUpInside];
    [button3 addTarget:self action:@selector(modelPresentClick:) forControlEvents:UIControlEventTouchUpInside];
    [button4 addTarget:self action:@selector(modelPresentClick:) forControlEvents:UIControlEventTouchUpInside];
   
    
     [button5 addTarget:self action:@selector(navPushClick) forControlEvents:UIControlEventTouchUpInside];
    
}
-(void)modelPresentClick:(UIButton *)button{
    ModelPresentVC *vc = [[ModelPresentVC alloc]init];
    //        覆盖整个当前页面 可透明
    //        UIModalPresentationCustom;
    //        UIModalPresentationOverFullScreen;
    //        UIModalPresentationOverCurrentContext;
    
    //        覆盖整个当前页面 不透明
    //UIModalPresentationFullScreen
    //默认不覆盖页面
    
    vc.modalPresentationStyle = UIModalPresentationFullScreen;
    
    if (button.tag == 100) {
        //默认的模态推出动画--由下往上弹出
        vc.modalTransitionStyle=UIModalTransitionStyleCoverVertical;
    }
    if (button.tag == 200) {
        //左右翻转动画
        vc.modalTransitionStyle=UIModalTransitionStyleFlipHorizontal;
    }
    if (button.tag == 300) {
        //淡入淡出动画
        vc.modalTransitionStyle=UIModalTransitionStyleCrossDissolve;
    }
    if (button.tag == 400) {
        //书页翻转动画
        // 用dismiss 的时候会卡主 ；是苹果的bug; 最好不用整个动画效果；如果必须要用的话可以设置dismiss的动画为NO
        vc.modalTransitionStyle=UIModalTransitionStylePartialCurl;
    }
//
    [self presentViewController:vc animated:YES completion:nil];
    
}
-(void)navPushClick{
    ModelPresentVC *vc = [[ModelPresentVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    
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
