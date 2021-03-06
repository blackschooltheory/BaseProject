//
//  modelPresentVC.m
//  BaseProject
//
//  Created by DLK on 2021/2/4.
//  Copyright © 2021 DLK. All rights reserved.
//

#import "ModelPresentVC.h"
#import "PublicMethodManager.h"
@interface ModelPresentVC ()

@end

@implementation ModelPresentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [[UIColor blueColor]colorWithAlphaComponent:0.2];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(20, 100, [PublicMethodManager screenWith]-40, 100)];
    label.numberOfLines = 0 ;
    [self.view addSubview:label];
    label.text = @"模态推出动画";
    label.textColor = [UIColor blueColor];
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(100, 300, 100, 50)];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.backgroundColor = [UIColor blueColor];
    [button setTitle:@"返回" forState:UIControlStateNormal];
    [self.view addSubview:button];
    
    [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    
}
-(void)buttonClick{
    [self dismissViewControllerAnimated:YES completion:nil];
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
