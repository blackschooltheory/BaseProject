//
//  TimerVC+invarcatFunction.m
//  BaseProject
//
//  Created by dlk on 2021/6/17.
//  Copyright © 2021 DLK. All rights reserved.
//

#import "TimerVC+invarcatFunction.h"

@implementation TimerVC (invarcatFunction)
-(void)timeClick{
    NSLog(@"------%@----",[self class]);
    self.numIndex ++;
    if (self.numIndex == 5) {
        [PublicMethodManager alertTitle:@"显示弹框"];
    }
}
@end
