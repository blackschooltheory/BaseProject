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

//实现JS与OC的通信 需要继承WKScriptMessageHandler 并实现方法（可以规避直接使用self内存泄露）
@interface dlkScriptMessageHandel: NSObject<WKScriptMessageHandler>
@property (nonatomic,weak)id<WKScriptMessageHandler> dlkScriptMessage;

-(instancetype)initDelegate:(id<WKScriptMessageHandler>)scriptDelegate;
@end

@implementation dlkScriptMessageHandel
-(instancetype)initDelegate:(id<WKScriptMessageHandler>)scriptDelegate{
    self = [ super init];
    if (self) {
        _dlkScriptMessage = scriptDelegate;
    }
    return  self;
}
-(void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    NSLog(@"message");
    
}
@end



@interface DLKWebViewVC ()<WKUIDelegate,WKNavigationDelegate>
//,WKNavigationDelegate,WKScriptMessageHandle
@property(nonatomic,strong)WKWebView *wkWebView;

@end

@implementation DLKWebViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    

    
    
    NSString *indexPatch = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"html"];
    NSString *mainPatch = [[NSBundle mainBundle] pathForResource:@"html5" ofType:@""]; //若是 folder 文件必须先获取到 folder 文件夹名称的位置，然后再拼接文件路径地址。
    
    NSString *urlHtml = [[NSString alloc]initWithContentsOfFile:indexPatch encoding:NSUTF8StringEncoding error:nil];
    
    /*
     WKWebView 加载的HTML的三种方式
     loadFileURL:
     loadRequest:
     loadHTMLString:
     */
//    [_wkWebView loadFileURL:[NSURL fileURLWithPath:indexPatch] allowingReadAccessToURL:[NSURL fileURLWithPath:indexPatch]] ;

//    allowingReadAccessToURL  这个入参必须是一个正常的url 路径
    
//    [_wkWebView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:indexPatch]]];
    
//    [self.wkWebView loadHTMLString:urlHtml baseURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]]];

    //加载 svg 的方式
    NSString *svgPatch = [[NSBundle mainBundle]pathForResource:@"gdicon.svg" ofType:nil];
    
    NSData *svgData = [NSData dataWithContentsOfFile:svgPatch];
    NSString *reasourcePath = [[NSBundle mainBundle] resourcePath];
        NSURL *baseUrl = [[NSURL alloc] initFileURLWithPath:reasourcePath isDirectory:true];
    [self.wkWebView loadData:svgData MIMEType:@"image/svg+xml" characterEncodingName:@"UIF-8" baseURL:baseUrl];
//
    
    
#ifdef WebViewDefault
    UIView *vvvvv = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [PublicMethodManager screenWith], [PublicMethodManager screenHeight])];
    [self.view addSubview:vvvvv];
    
    [vvvvv addSubview:self.wkWebView];
#else
    NSLog(@"数据");
#endif

}
-(WKWebView *)wkWebView{
    //初始化 wkWebView 对象
    if (!_wkWebView) {
        dlkScriptMessageHandel *handel = [[dlkScriptMessageHandel alloc]init];
        WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc]init];
        WKUserContentController *userContent = [[WKUserContentController alloc]init];
        [userContent addScriptMessageHandler:handel name:@"showJSToOC"];
        
        //实现注入js 让JS或者原生调用；也可以统一修改html 的样式
        NSString *scriptPatch = [[NSBundle mainBundle] pathForResource:@"UserContent" ofType:@"js"];
        NSString *scriptStr = [NSString stringWithContentsOfFile:scriptPatch encoding:NSUTF8StringEncoding error:nil];
        
        WKUserScript *userScript = [[WKUserScript alloc]initWithSource:scriptStr injectionTime:WKUserScriptInjectionTimeAtDocumentStart forMainFrameOnly:NO];
        
        [userContent addUserScript:userScript];
        
        configuration.userContentController =userContent;
        
        _wkWebView = [[WKWebView alloc]initWithFrame:self.view.frame configuration:configuration];
        _wkWebView.UIDelegate = self;
        _wkWebView.navigationDelegate = self;
//        _wkWebView.scrollView.scrollEnabled=NO;
    }
    return _wkWebView;
}

#pragma mark -- UIDelegate  代理
-(void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler{
    
//    NSLog(message);
//    completionHandler();
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"HTML的弹出框" message:message?:@"" preferredStyle:UIAlertControllerStyleAlert];
       [alertController addAction:([UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
           completionHandler();
       }])];
       [self presentViewController:alertController animated:YES completion:nil];
    
}
-(void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL))completionHandler{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:message?:@"" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:([UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            completionHandler(NO);
        }])];
        [alertController addAction:([UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            completionHandler(YES);
        }])];
        [self presentViewController:alertController animated:YES completion:nil];
}

-(void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * _Nullable))completionHandler{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:prompt message:@"" preferredStyle:UIAlertControllerStyleAlert];
       [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
           textField.text = defaultText;
       }];
       [alertController addAction:([UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
           completionHandler(alertController.textFields[0].text?:@"");
       }])];
       [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark-----这个涉及到导航栏重定向

/*
 1 .前端 target="_blank" 设置后无法加载页面 和 window.open(url) 无法打开新页面
 原因：两者都是要在新窗口打开，判断下当前请求的targetFrame是不是MainFrame，不是则要在主动加载链接
2.界面重定向打不开页面
 */

//上面两点的问题结局方法
-(WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures{
    if (!navigationAction.targetFrame.isMainFrame) {
        [webView loadRequest:navigationAction.request];
    }
    return nil;
}

#pragma mark---------WKNavigationDeletegate

// 是否允许开始请求，这个地方可以给要加载或者要跳转的网页加入不同的东西
-(void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    
    NSLog(@"是否允许请求");
    decisionHandler(WKNavigationActionPolicyAllow);//可以设置允许与不允许，可以阻止网页请求
    
}
//是否允许响应请求（加载或者跳转网页时，会调用），可以给这个阶段网页添加处理
-(void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
    NSLog(@"是否允许响应");
    decisionHandler(WKNavigationResponsePolicyAllow); // 可以设置允许与不允许，可以阻止网页响应
}


-(void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    //开始临时的导航
    NSLog(@"是否StartProvisional");
}
-(void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
    //开始提交
    NSLog(@"是否开始提交");
}
-(void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    //导航栏加载结束
    NSLog(@"是否结束");
}
-(void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error{
    //加载失败
    NSLog(@"加载过程出现失败");
}
////收到重定向
//-(void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation{
//    NSLog(@"重定向");
//}
//// https 身份验证
//-(void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential * _Nullable))completionHandler{
//
//}

-(void)webViewWebContentProcessDidTerminate:(WKWebView *)webView{
    //进程结束
    NSLog(@"进程结束");
}

-(void)dealloc{
    
    [_wkWebView.configuration.userContentController removeScriptMessageHandlerForName:@"showJSToOC"];
    NSLog(@"webView 对象清除");
}


#pragma mark--------WKNavigationDelegate


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
