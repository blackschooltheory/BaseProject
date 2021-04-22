//
//  TwoVC.m
//  BaseProject
//
//  Created by dlk on 2021/4/20.
//  Copyright © 2021 DLK. All rights reserved.
//

#import "TwoVC.h"

@interface TwoVC ()

@end

@implementation TwoVC

static NSString * const TwoTiltleStr = @"hhhhhh";


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSLog(TwoTiltleStr);
    
    
    void (^gggg)(void) = ^(void){
        NSLog(@"数据");
    };
    
    NSString * (^good)(NSString *)  = [self gblock:^{
            
    }];
    good(@"哈哈哈哈");
}
-( NSString * (^)(NSString *))gblock:(void (^)(void)) block{
    return ^(NSString * sss){
        block();
        return @"2345";
    };
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
