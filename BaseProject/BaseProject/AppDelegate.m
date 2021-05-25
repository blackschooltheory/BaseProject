//
//  AppDelegate.m
//  BaseProject
//
//  Created by DLK on 2020/12/7.
//  Copyright © 2020 DLK. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "FunctionVC.h"
#import "FrameworkVC.h"
#import "Performance.h"
#import "Carsh.h"

@interface AppDelegate ()
@property (assign, nonatomic) UIBackgroundTaskIdentifier backgroundId;
@property (assign, nonatomic) UIBackgroundTaskIdentifier backIden;
@property (assign, nonatomic)NSTimer *timer;
@property(nonatomic,assign) int applyTimes;

@end

static NSString  const * PrivacyPolicy = @"PrivacyPolicy";
@implementation AppDelegate
#pragma mark----横屏竖屏设置  设置强制转屏
- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(nullable UIWindow *)window{
    if (_allowRotation == YES) {
        // 强制转屏为横屏
        return UIInterfaceOrientationMaskLandscapeLeft;
    }else{
        //默认竖屏
        return (UIInterfaceOrientationMaskPortrait);
    }
}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    //需要设置 NSSetUncaughtExceptionHandler 来抓取崩溃信息
    NSSetUncaughtExceptionHandler(&caughtExceptionHandler);
    
    //设置tabbar 菜单栏 与首页3个页面
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    FunctionVC *funVC = [[FunctionVC alloc]init];
    UINavigationController *funNav = [[UINavigationController alloc]initWithRootViewController:funVC];
    funNav.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"功能" image:[UIImage imageNamed:@"menu_0"] selectedImage:[UIImage imageNamed:@"menu_0_sel"]];
    FrameworkVC *fraVC = [[FrameworkVC alloc]init];
    UINavigationController *fraNav = [[UINavigationController alloc]initWithRootViewController:fraVC];
    fraNav.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"性能" image:[UIImage imageNamed:@"menu_1"] selectedImage:[UIImage imageNamed:@"menu_1_sel"]];
    Performance *perVC = [[Performance alloc]init];
    UINavigationController *perNav = [[UINavigationController alloc]initWithRootViewController:perVC];
    perNav.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"三方库" image:[UIImage imageNamed:@"menu_2"] selectedImage:[UIImage imageNamed:@"menu_2_sel"]];
    UITabBarController *tab = [[UITabBarController alloc]init];
    tab.viewControllers = @[funNav,fraNav,perNav];
    self.window.rootViewController = tab;
    [self.window makeKeyAndVisible];
    
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appWillEnterForeground) name:UIApplicationWillEnterForegroundNotification object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appDidEnterBackground) name:UIApplicationDidEnterBackgroundNotification object:nil];
    
//    CGFloat scaleFloat = [UIScreen mainScreen].scale;
//    CGAffineTransformMakeRotation(M_PI_4);
//    [self adViewLaunch];
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(handleDeviceOrientationChange:)
                                         name:UIDeviceOrientationDidChangeNotification object:nil];

    return YES;
}

-(void)handleDeviceOrientationChange:(NSNotification *)notif{
    UIDevice *device = notif.object ;
    if (  device.orientation==UIDeviceOrientationLandscapeRight ) {
        [PublicMethodManager alertTitle:@"屏幕旋转了"];
    }
    NSLog(@"deviceChage =%i",device.orientation);
   
  

//
}
#pragma mark------隐私政策提示
-(void)privacyPolicy{
    
    
    NSUserDefaults *defalts = [NSUserDefaults  standardUserDefaults];
    BOOL isShowPrivacyPolicy =  [defalts boolForKey:PrivacyPolicy];
    if (!isShowPrivacyPolicy) {
        //弹出隐私政策
        
        
    }
    
}



#pragma mark-------截取启动页的图片
-(void)adViewLaunch{
    UIImageView *adImageView = [[UIImageView alloc]initWithFrame:self.window.frame];
    [self.window addSubview:adImageView];
    adImageView.image = [self launchImage];
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(200, 64, 100, 100)];
    button.backgroundColor = [UIColor blueColor];
    [adImageView addSubview:button];
}

-(UIImage *)launchImage{
    //获取 launchScreen 的 storyboard
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"LaunchScreen" bundle:nil];
    UIViewController *vc = [storyboard instantiateInitialViewController];
    vc.view.frame = self.window.frame;
    //截取页面成为图片
    UIGraphicsBeginImageContextWithOptions(self.window.frame.size, YES, 0.0);
    [vc.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return  image;
}

- (void)appWillEnterForeground {
   [self stopKeepAlive];
}

- (void)appDidEnterBackground {
//    _backgroundId = [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:^{
//        //申请的时间即将到时回调该方法
//        [self stopKeepAlive];
//        NSLog(@"BackgroundTask time gone");
//
//
//    }];
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(applyForMoreTime) userInfo:nil repeats:YES];
    [_timer fire];
   
}

- (void)stopKeepAlive{
  if (_backgroundId) {
        [[UIApplication sharedApplication] endBackgroundTask:_backgroundId];
        _backgroundId = UIBackgroundTaskInvalid;
    }
    
}
-(void)applyForMoreTime {
    
     _applyTimes += 1;
       NSLog(@"Try to apply for more time:%d",_applyTimes);
//    NSTimeInterval ttt=[UIApplication sharedApplication].backgroundTimeRemaining;
//    if ([UIApplication sharedApplication].backgroundTimeRemaining < 10) {
//        _applyTimes += 1;
//        NSLog(@"Try to apply for more time:%d",_applyTimes);
//        [[UIApplication sharedApplication] endBackgroundTask:_backgroundId];
//        _backgroundId = [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:^{
//            [self stopKeepAlive];
//        }];
//        if(_applyTimes == 5){
//            [_timer invalidate];
//            _applyTimes = 0;
//            [self stopKeepAlive];
//        }
//    }
}


//获取推送的deviceToken
-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    
}




@end
