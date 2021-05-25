//
//  FrameworkVC.m
//  BaseProject
//
//  Created by DLK on 2020/12/22.
//  Copyright © 2020 DLK. All rights reserved.
//

#import "FrameworkVC.h"
#import "TableStanceView.h"

@interface FrameworkVC ()

@end

@implementation FrameworkVC

NSString * const eeeecc  = @"hellow ";


static  const NSString * yye = @"tantiajn";



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    yye =@"titnais";
    
    float x = [PublicMethodManager screenWith]/2.0 - 50;
    float y = [PublicMethodManager screenHeight]/2.0 - 50;
    
    [self.view addSubview:[[TableStanceView alloc] initWithFrame:CGRectMake(x, y, 100, 100) withGif:@"load.gif"] ];
    
    
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
