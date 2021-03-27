//
//  ProjectResourceManager.m
//  BaseProject
//
//  Created by dlk on 2021/3/26.
//  Copyright © 2021 DLK. All rights reserved.
//

#import "ProjectResourceManager.h"

@interface ProjectResourceManager ()

@end

@implementation ProjectResourceManager

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSString *homePath = NSHomeDirectory();
    NSLog(@"%@",homePath);
    
    
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
