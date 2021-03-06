//
//  ModelLanscapeLeftVC.m
//  BaseProject
//
//  Created by dlk on 2021/2/20.
//  Copyright © 2021 DLK. All rights reserved.
//

#import "ModelLanscapeLeftVC.h"
#import "AppDelegate.h"

@interface ModelLanscapeLeftVC ()

@end

@implementation ModelLanscapeLeftVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(100, 100, 100, 50)];
    [self.view addSubview: label];
    label.text = @"模态横屏";
    label.textColor = [UIColor blueColor];
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(100, 200, 100, 50)];
    button.backgroundColor = [UIColor blueColor];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitle:@"返回" forState:UIControlStateNormal];
    [self.view addSubview:button];
    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
}
-(void)back{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    AppDelegate * appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    appDelegate.allowRotation = YES;//(以上2行代码,可以理解为打开横屏开关)
    [self setNewOrientation:YES];//调用转屏代码
}
- (void)setNewOrientation:(BOOL)fullscreen{
    if (fullscreen) {
        //由任意屏 旋转为横屏
        NSNumber *resetOrientationTarget = [NSNumber numberWithInt:UIInterfaceOrientationUnknown];
        [[UIDevice currentDevice] setValue:resetOrientationTarget forKey:@"orientation"];
        NSNumber *orientationTarget = [NSNumber numberWithInt:UIInterfaceOrientationLandscapeLeft];
        [[UIDevice currentDevice] setValue:orientationTarget forKey:@"orientation"];
    }else{
        //由任意屏 旋转为竖屏
        NSNumber *resetOrientationTarget = [NSNumber numberWithInt:UIInterfaceOrientationUnknown];
        [[UIDevice currentDevice] setValue:resetOrientationTarget forKey:@"orientation"];
        NSNumber *orientationTarget = [NSNumber numberWithInt:UIInterfaceOrientationPortrait];
        [[UIDevice currentDevice] setValue:orientationTarget forKey:@"orientation"];
    }
}


#pragma mark--------（方式不行 在Appdeleage 中已经设置 window 的方式为竖屏 supportedInterfaceOrientationsForWindow 还需要改变window的竖屏状态）模态推出横屏方式通过直接 设置允许自动旋转屏幕；支持旋转屏幕的方式 ；设置旋转成的屏幕方向 这个方式是不行的
//present 模态推出横屏方案
//-(BOOL)shouldAutorotate{
//    return YES;
//}
//-(UIInterfaceOrientationMask)supportedInterfaceOrientations{
//    return UIInterfaceOrientationMaskAllButUpsideDown;
//}
//-(UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
//
//return UIInterfaceOrientationLandscapeLeft;
//
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
