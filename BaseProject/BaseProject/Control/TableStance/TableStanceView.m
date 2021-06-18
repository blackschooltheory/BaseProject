//
//  TableStanceView.m
//  BaseProject
//
//  Created by 邓烈康 on 2021/5/24.
//  Copyright © 2021 DLK. All rights reserved.
//

#import "TableStanceView.h"
#import <WebKit/WebKit.h>
#import "PublicMethodManager.h"

@interface TableStanceView ()
@property(nonatomic,strong)WKWebView * gifWebView;

@end


@implementation TableStanceView

- (instancetype)initWithFrame:(CGRect)frame withGif:(NSString *)gifStr
{
    self = [super init];
    if (self) {
        
        self.frame = [PublicMethodManager currentVC].view.frame;
        
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
    [_gifWebView setCenter:CGPointMake([PublicMethodManager screenWith]/2.0, [PublicMethodManager screenHeight]/2.0)];
    [self layoutIfNeeded];
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMinX(_gifWebView.frame), CGRectGetMaxY(_gifWebView.frame)+20, 100, 50)];
    button.backgroundColor = [UIColor blueColor];
    [self addSubview:button];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"重新加载" forState:UIControlStateNormal];
    
}
-(void)btnClick{
    //执行重新加载
    if (self.stanceBlock) {
        self.stanceBlock();
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
