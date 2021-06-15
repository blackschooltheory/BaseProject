//
//  TimerModel.m
//  BaseProject
//
//  Created by dlk on 2021/6/15.
//  Copyright © 2021 DLK. All rights reserved.
//

#import "TimerModel.h"

@implementation TimerModel
-(id)forwardingTargetForSelector:(SEL)aSelector{
    return _targetVC;
}
-(void)dealloc{
    NSLog(@"------%@ delloc----",[self class]);
}
@end
