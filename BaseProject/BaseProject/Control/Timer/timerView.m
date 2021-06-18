//
//  timerView.m
//  BaseProject
//
//  Created by dlk on 2021/6/17.
//  Copyright © 2021 DLK. All rights reserved.
//

#import "timerView.h"
#import "UIView+touch.h"
@implementation timerView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    return  [super hitTest:point withEvent:event];
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor brownColor];
    }
    return self;
}
@end
