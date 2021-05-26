//
//  TableStanceView.m
//  BaseProject
//
//  Created by 邓烈康 on 2021/5/24.
//  Copyright © 2021 DLK. All rights reserved.
//

#import "TableStanceView.h"
#import <WebKit/WebKit.h>

@interface TableStanceView ()
@property(nonatomic,strong)WKWebView * gifWebView;

@end


@implementation TableStanceView

- (instancetype)initWithFrame:(CGRect)frame withGif:(NSString *)gifStr
{
    self = [super init];
    if (self) {
        
        [self addGif:gifStr withFrame:frame];
    }
    return self;
}

-(void)addGif:(NSString *)gifStr withFrame:(CGRect) frame{
    _gifWebView = [[WKWebView alloc]initWithFrame:frame];
    _gifWebView.scrollView.scrollEnabled = NO;
    NSString *patch = [[NSBundle mainBundle]pathForResource:@"load.gif" ofType:@""];
    NSURL *url = [NSURL fileURLWithPath:patch];
    [_gifWebView loadFileURL:url allowingReadAccessToURL:url];
    [self addSubview:_gifWebView];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
