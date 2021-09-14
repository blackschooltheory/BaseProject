//
//  AnimationVC.m
//  BaseProject
//
//  Created by mac on 2021/8/11.
//  Copyright © 2021 DLK. All rights reserved.
//

#import "AnimationVC.h"
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,AnimationKeyPath) {
    bounds = 0,
    frame = 1
};


@interface AnimationVC ()<CAAnimationDelegate>

@end

@implementation AnimationVC


-(void)addBasicAnimationWithLayer:(CALayer *)layer withKeyPath:(AnimationKeyPath )keyPath{
    CABasicAnimation *basicAnimation ;
    if (keyPath == bounds) {
        
    }
}

-(void)addBasicAnimationWithLayer:(CALayer *)layer{
    AnimationKeyPath boundsType = bounds;
    // bounds 的变化动画
    CABasicAnimation *basicAnimation = [CABasicAnimation animationWithKeyPath:@"bounds"];
    basicAnimation.toValue = [NSValue valueWithCGRect:CGRectMake(0, 0, 200, 200)];
    basicAnimation.duration = 3;
    basicAnimation.removedOnCompletion = NO;
    basicAnimation.autoreverses = YES;
    [layer addAnimation:basicAnimation forKey:@"com.dlk.bound"];
    
    //中心位置移动动画
    CABasicAnimation * twoBasicAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    twoBasicAnimation.duration = 3;
    twoBasicAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(300, 300)];
    twoBasicAnimation.autoreverses = YES ;
    [layer addAnimation:twoBasicAnimation forKey:@"com.dlk.position"];
    
    //旋转动画
//    CABasicAnimation * threeAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
//    twoBasicAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DScale(<#CATransform3D t#>, <#CGFloat sx#>, <#CGFloat sy#>, <#CGFloat sz#>)]
    
}


-(void)addKeyAnimationWtihLayer:(CALayer *)layer{
    
//    CAKeyframeAnimation *keyAnimation  = [CAKeyframeAnimation animationWithKeyPath:<#(nullable NSString *)#>]
    
    
}

-(void)addAnimationToLayer:(CALayer *)layer{
    
    CABasicAnimation *animation  = [CABasicAnimation animationWithKeyPath:@"position"];
    animation.delegate = self;
    animation.duration = 3;
//    animation.repeatCount = 3;
//    animation.repeatDuration = 1;
    animation.fromValue = [NSValue valueWithCGPoint: CGPointMake(100, 100)] ;
    animation.toValue = [NSValue valueWithCGPoint: CGPointMake(300, 300)] ;
//    [NSValue valueWithPointer:<#(nullable const void *)#>] 处理指针、
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.autoreverses = YES ;
//    [layer addAnimation:animation forKey:@"position"];
      
    
    CABasicAnimation *base2A = [CABasicAnimation animationWithKeyPath:@"position"];
    base2A.duration = 2;;
    base2A.fromValue = [UIColor brownColor];
    base2A.toValue = [UIColor blueColor];
    base2A.fillMode = kCAFillModeForwards;
    
    
    CAKeyframeAnimation * keyAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    keyAnimation.values = @[[NSValue valueWithCGPoint: CGPointMake(100, 100)] ,[NSValue valueWithCGPoint: CGPointMake(200, 300)],[NSValue valueWithCGPoint: CGPointMake(300, 300)] ];
    keyAnimation.duration = 3;
    [layer addAnimation:keyAnimation forKey:@"backgroundColor"];
    
    
    
}


-(void)animationDidStart:(CAAnimation *)anim{
    NSLog(@"动画开始");
}
-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    NSLog(@"动画停止");
}


@end
