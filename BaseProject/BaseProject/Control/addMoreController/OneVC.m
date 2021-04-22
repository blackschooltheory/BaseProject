//
//  OneVC.m
//  BaseProject
//
//  Created by dlk on 2021/4/20.
//  Copyright © 2021 DLK. All rights reserved.
//

#import "OneVC.h"

@interface OneVC ()

@end

@implementation OneVC

NSString *const OneVCTitleStr = @"goodSrt";

float const OneVCTime = 100.12 ;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSInvocationOperation *operation1 = [[NSInvocationOperation alloc]initWithTarget:self selector:@selector(operation1) object:nil];
    NSOperationQueue *queue = [[NSOperationQueue alloc]init];
    [queue addOperation:operation1];
    
//    queue
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
