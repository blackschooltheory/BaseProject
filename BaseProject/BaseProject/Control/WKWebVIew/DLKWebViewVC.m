//
//  DLKWebViewVC.m
//  BaseProject
//
//  Created by dlk on 2021/3/15.
//  Copyright © 2021 DLK. All rights reserved.
//

#import "DLKWebViewVC.h"
#import <WebKit/WebKit.h>

#define WebViewDefault 1 // 标准化的 Wkwebview 加载 html方法与方法回调
#define WebViewInject 1 //注入的方式 WKWebView 处理HTML  (不用修改js 代码可以实现JS与OC交互，实现UIWebView 转换到WKWebView)

@interface DLKWebViewVC ()<WKUIDelegate,WKNavigationDelegate,WKScriptMessageHandler>
@property(nonatomic,strong)WKWebView *wkWebView;

@end

@implementation DLKWebViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
#ifdef WebViewDefault
    [self.view addSubview:self.wkWebView];
#else
    NSLog(@"数据");
#endif


}


-(WKWebViewConfiguration *)initwebViewConfig{
    //创建wkwebView 的config
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc]init];
    
//    //自定义的WKScriptMessageHandler 是为了解决内存不释放的问题
//    WKScriptMessageHandler *weakScriptMessageDelegate = [[WKScriptMessageHandler alloc] initWithDelegate:self];
    WKUserContentController *userContent = config.userContentController;
    [userContent addScriptMessageHandler:self name:@"xxxfunctionName"];//直接用self 会导致内存不释放问题
    
    
    return config;
}

-(WKWebView *)wkWebView{
    //初始化 wkWebView 对象
    if (!_wkWebView) {
        _wkWebView = [[WKWebView alloc]initWithFrame:self.view.frame];
        _wkWebView.UIDelegate = self;
        _wkWebView.navigationDelegate = self;
    }
    return _wkWebView;
}
-(void)initWkWebViewConfig{
//    _wkWebView
    
    
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
