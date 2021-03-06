//
//  BaseViewController.m
//  BaseProject
//
//  Created by dlk on 2021/2/20.
//  Copyright © 2021 DLK. All rights reserved.
//

#import "BaseViewController.h"
#import "AppDelegate.h"
@interface BaseViewController ()
@property(nonatomic,strong)UIWindow *alertWindow;
@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    //导航栏横屏方式
    AppDelegate * appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    appDelegate.allowRotation = NO;//(以上2行代码,可以理解为打开横屏开关)
    [self setNewOrientation:NO];//调用转屏代码
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
-(void)showAlert:(NSString *)titleStr withContentStr:(NSString *)contentStr{
    _alertWindow = [[UIWindow alloc]initWithFrame:CGRectMake(0, 0, [PublicMethodManager screenWith], [PublicMethodManager screenHeight])];
    _alertWindow.windowLevel = UIWindowLevelAlert ;
    [_alertWindow makeKeyAndVisible];
    
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, [PublicMethodManager screenWith], 50)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor blueColor];
    titleLabel.font = [UIFont systemFontOfSize:13];
    titleLabel.center = CGPointMake([PublicMethodManager screenWith]/2.0, [PublicMethodManager screenHeight]/2.0);
    titleLabel.text = titleStr;
    [_alertWindow addSubview:titleLabel];
    
    [self performSelector:@selector(closeWindow) withObject:nil afterDelay:3.0];
    
}
-(void)closeWindow{
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        weakSelf.alertWindow.hidden = YES;
        weakSelf.alertWindow = nil ;
    });
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
