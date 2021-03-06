//
//  ForbidCatchScreenVC.m
//  BaseProject
//
//  Created by DLK on 2021/1/29.
//  Copyright © 2021 DLK. All rights reserved.
//

#import "ForbidCatchScreenVC.h"
#import <Photos/Photos.h>
@interface ForbidCatchScreenVC ()

@end

@implementation ForbidCatchScreenVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 不能禁止截屏控制，只能够获取截屏时候的通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(screenshots) name:UIApplicationUserDidTakeScreenshotNotification object:nil];
    UIView *screenView = [[UIView alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
    screenView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:screenView];
    
    
    
}
- (UIImage *)imageWithScreenshot {
    CGSize imageSize = CGSizeZero;
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    if (UIInterfaceOrientationIsPortrait(orientation)) {
        imageSize = [UIScreen mainScreen].bounds.size;
    } else {
        imageSize = CGSizeMake([UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width);
    }
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    for (UIWindow *window in [[UIApplication sharedApplication] windows]) {
        CGContextSaveGState(context);
        CGContextTranslateCTM(context, window.center.x, window.center.y);
        CGContextConcatCTM(context, window.transform);
        CGContextTranslateCTM(context, -window.bounds.size.width * window.layer.anchorPoint.x, -window.bounds.size.height * window.layer.anchorPoint.y);
        if (orientation == UIInterfaceOrientationLandscapeLeft) {
            CGContextRotateCTM(context, M_PI_2);
            CGContextTranslateCTM(context, 0, -imageSize.width);
        } else if (orientation == UIInterfaceOrientationLandscapeRight) {
            CGContextRotateCTM(context, -M_PI_2);
            CGContextTranslateCTM(context, -imageSize.height, 0);
        } else if (orientation == UIInterfaceOrientationPortraitUpsideDown) {
            CGContextRotateCTM(context, M_PI);
            CGContextTranslateCTM(context, -imageSize.width, -imageSize.height);
        }
        if ([window respondsToSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)]) {
            [window drawViewHierarchyInRect:window.bounds afterScreenUpdates:YES];
        } else {
            [window.layer renderInContext:context];
        }
        CGContextRestoreGState(context);
    }
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    NSData *imageData = UIImagePNGRepresentation(image);
    UIImage *screenImage = [UIImage imageWithData:imageData];
    return screenImage;
}

-(void)screenshots
{
    
  UIAlertView *alert1 = [[UIAlertView alloc] initWithTitle:nil message:@"[安全提醒]该功能用于收付款时使用。不要截图，录制或分享给他人以保障资金账户安全。" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
  [alert1 show];
    
    
//    self.view.backgroundColor=[UIColor greenColor];

}

-(void)dealloc
{
  [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationUserDidTakeScreenshotNotification object:nil];
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
