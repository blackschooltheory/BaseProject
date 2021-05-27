//
//  RunTimeVC.m
//  BaseProject
//
//  Created by 邓烈康 on 2021/4/28.
//  Copyright © 2021 DLK. All rights reserved.
//

#import "RunTimeVC.h"
#import <objc/runtime.h>

@interface RunTimeVC ()

@end

@implementation RunTimeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

void  goodFun(id obj ,SEL _cmd , id params){
    NSLog(@"invaction Function");
}
#pragma  mark--------消息重定向
+(BOOL)resolveClassMethod:(SEL)sel{
    //类方法消息重定向
    if (sel == @selector(goodFun)) {
        class_addMethod([self class], sel, (IMP) goodFun, "v@:");
        return YES;
    }
    return [super resolveClassMethod:sel ];
}

//+(BOOL)resolveInstanceMethod:(SEL)sel{
//    //实例对象的消息重定向
//}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
