//
//  LandscapeLeftVC.m
//  BaseProject
//
//  Created by DLK on 2021/1/26.
//  Copyright © 2021 DLK. All rights reserved.
//

#import "LandscapeLeftVC.h"
#import "AppDelegate.h"

@interface LandscapeLeftVC ()

@end

@implementation LandscapeLeftVC

//-(void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:animated];
//    NSNumber *orientationUnknown = [NSNumber numberWithInt:UIInterfaceOrientationUnknown];
//    [[UIDevice currentDevice] setValue:orientationUnknown forKey:@"orientation"];
//    NSNumber *orientationTarget = [NSNumber numberWithInt:UIInterfaceOrientationLandscapeLeft];
//    [[UIDevice currentDevice] setValue:orientationTarget forKey:@"orientation"];
//}
//-(void)viewDisappear:(BOOL)animated{
//    [super viewWillDisappear:animated];
//    NSNumber *orientationUnknown = [NSNumber numberWithInt:UIInterfaceOrientationUnknown];
//
//       [[UIDevice currentDevice] setValue:orientationUnknown forKey:@"orientation"];
//
//       NSNumber *orientationTarget = [NSNumber numberWithInt:UIInterfaceOrientationPortrait];
//
//       [[UIDevice currentDevice] setValue:orientationTarget forKey:@"orientation"];
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"横屏页面";
    self.view.backgroundColor=[UIColor brownColor];
    UIButton *titleBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 100, 100, 100)];
    titleBtn.backgroundColor=[UIColor blueColor];
    [self.view addSubview:titleBtn];
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


@end
