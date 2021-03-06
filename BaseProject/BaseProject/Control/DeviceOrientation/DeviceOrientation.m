//
//  DeviceOrientation.m
//  BaseProject
//
//  Created by DLK on 2021/1/22.
//  Copyright © 2021 DLK. All rights reserved.
//

#import "DeviceOrientation.h"
#import "LandscapeLeftVC.h"
#import "PublicMethodManager.h"
#import "ModelLanscapeLeftVC.h"

@interface DeviceOrientation ()

@end

@implementation DeviceOrientation

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"横竖屏功能";
    self.view.backgroundColor=[UIColor whiteColor];
    
    UILabel *discriptLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 84, [PublicMethodManager screenWith]-40, 200)];
    
    [self.view addSubview:discriptLabel];
    
    discriptLabel.text=@"横屏方式有两种，一种是模态推出的方式；一中的导航栏推出方式；两种的设置方式应该用一样的方法；其他的横屏方式要不就是会失效，要不就是返回当前页面时还需要改回之前屏幕的横竖设置";
    discriptLabel.numberOfLines=0;
    

    UIButton *hButton = [[UIButton alloc]initWithFrame:CGRectMake(0,200, 100, 50)];
    hButton.center = CGPointMake(self.view.frame.size.width/2.0, 300);
    hButton.backgroundColor = [UIColor blueColor];
    [hButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:hButton];
    [hButton setTitle:@"模态横屏" forState:UIControlStateNormal];
    [hButton addTarget:self action:@selector(modelClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *pushBtn = [[UIButton alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(hButton.frame)+20, 100, 50)];
    pushBtn.center = CGPointMake(self.view.frame.size.width/2.0, 400);
    pushBtn.backgroundColor = [UIColor blueColor];
    [pushBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:pushBtn];
    [pushBtn setTitle:@"导航栏横屏" forState:UIControlStateNormal];
    [pushBtn addTarget:self action:@selector(hClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    
}
-(void)modelClick{
    //模态推出页面
    ModelLanscapeLeftVC *vc = [[ModelLanscapeLeftVC alloc]init];
    vc.modalPresentationStyle=UIModalPresentationFullScreen;
    [self presentViewController:vc animated:YES completion:nil];
    
}
-(void)hClick{
    //导航啦推出页面
      LandscapeLeftVC *vc = [[LandscapeLeftVC alloc]init];
//    UINavigationController *nav =[[UINavigationController alloc]initWithRootViewController:vc];
//    nav.modalPresentationStyle=UIModalPresentationFullScreen;
//    [self presentViewController:nav animated:YES completion:nil];
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

@end
