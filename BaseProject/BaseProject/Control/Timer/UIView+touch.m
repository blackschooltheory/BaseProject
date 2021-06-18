//
//  UIView+touch.m
//  BaseProject
//
//  Created by dlk on 2021/6/17.
//  Copyright © 2021 DLK. All rights reserved.
//

#import "UIView+touch.h"

@implementation UIView (touch)
-(void)ggggg{
    NSLog(@"HHHHHHHH");
}
-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    
    return  [self hitTest:point withEvent:event];
}
-(BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{
    
    NSLog(@"point l");
    return  [self pointInside:point withEvent:event];
}
@end
