//
//  Child_OneVC.m
//  BaseProject
//
//  Created by dlk on 2021/5/23.
//  Copyright © 2021 DLK. All rights reserved.
//

#import "Child_OneVC.h"
#

@interface Child_OneVC ()

@end

@implementation Child_OneVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"child_oneVC 调用");
    self.view.backgroundColor = [UIColor grayColor];
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
}


-(void)touchBlock:(void (^)(void))block{
    
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
