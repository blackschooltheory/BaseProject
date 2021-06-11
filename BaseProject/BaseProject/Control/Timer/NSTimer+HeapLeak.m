//
//  NSTimer+HeapLeak.m
//  BaseProject
//
//  Created by dlk on 2021/6/9.
//  Copyright © 2021 DLK. All rights reserved.
//

#import "NSTimer+HeapLeak.h"

@implementation NSTimer (HeapLeak)
+(void) fileTimer{
    [[self class] scheduledTimerWithTimeInterval:1 target:self selector:@selector(click) userInfo:nil repeats:YES];
}
@end
