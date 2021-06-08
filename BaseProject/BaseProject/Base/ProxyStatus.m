//
//  ProxyStatus.m
//  BaseProject
//
//  Created by dlk on 2021/6/8.
//  Copyright © 2021 DLK. All rights reserved.
//

#import "ProxyStatus.h"

@implementation ProxyStatus
-(void)proxy{
    self.str2 = nil;//不能为空
}
+ (BOOL)getProxyStatus {
    NSDictionary *proxySettings = NSMakeCollectable([(NSDictionary *)CFNetworkCopySystemProxySettings() autorelease]);
    NSArray *proxies = NSMakeCollectable([(NSArray *)CFNetworkCopyProxiesForURL((CFURLRef)[NSURL URLWithString:@"http://www.google.com"], (CFDictionaryRef)proxySettings) autorelease]);
    NSDictionary *settings = [proxies objectAtIndex:0];
    
    NSLog(@"host=%@", [settings objectForKey:(NSString *)kCFProxyHostNameKey]);
    NSLog(@"port=%@", [settings objectForKey:(NSString *)kCFProxyPortNumberKey]);
    NSLog(@"type=%@", [settings objectForKey:(NSString *)kCFProxyTypeKey]);
    
    if ([[settings objectForKey:(NSString *)kCFProxyTypeKey] isEqualToString:@"kCFProxyTypeNone"])
    {
        //没有设置代理
        return NO;
    }
    else
    {
        //设置代理了
        return YES;
    }
}

//ARC 版本获取代理状态
//- (BOOL)getProxyStatus {
//    NSDictionary *proxySettings = (__bridge NSDictionary*)(CFNetworkCopySystemProxySettings());
//    NSArray *proxies = (__bridge NSArray *) (CFNetworkCopyProxiesForURL((__bridge CFURLRef _Nonnull)([NSURL URLWithString:@"http://www.baidu.com"]), (__bridge CFDictionaryRef _Nonnull)(proxySettings)));
//    NSDictionary *settings = [proxies objectAtIndex:0];
//    NSLog(@"host=%@", [settings objectForKey:(NSString *)kCFProxyHostNameKey]);
//    NSLog(@"port=%@", [settings objectForKey:(NSString *)kCFProxyPortNumberKey]);
//    NSLog(@"type=%@", [settings objectForKey:(NSString *)kCFProxyTypeKey]);
//    if ([[settings objectForKey:(NSString *)kCFProxyTypeKey] isEqualToString:@"kCFProxyTypeNone"]){
//        //没有设置代理
//        return NO;
//    }else{
//        //设置代理了
//        return YES;
//    }
//}
#pragma  mark--------判断APP是否处于代理的环境下
//-(BOOL)getProxyStatus {
//    CFDictionaryRef dicRef = CFNetworkCopySystemProxySettings();
//    CFStringRef proxyCFstr = CFDictionaryGetValue(dicRef, (const void*)kCFNetworkProxiesHTTPProxy);
//
//    NSString* proxy = (__bridge NSString *) (proxyCFstr);
//
//     if (proxy) {
//        return YES;
//    }
//     else {
//
//        return NO;
//    }
//}

@end
