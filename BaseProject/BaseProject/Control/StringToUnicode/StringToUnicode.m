//
//  StringToUnicode.m
//  BaseProject
//
//  Created by 邓烈康 on 2021/3/8.
//  Copyright © 2021 DLK. All rights reserved.
//

#import "StringToUnicode.h"

@interface StringToUnicode ()

@end

@implementation StringToUnicode

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    UITextField *textFiled = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, [PublicMethodManager screenWith]-60, 50)];
    textFiled.tag = 200;
    textFiled.center = CGPointMake([PublicMethodManager screenWith]/2.0, 300);
    [self.view addSubview:textFiled];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(30, CGRectGetMaxY(textFiled.frame)+30, [PublicMethodManager screenWith]-60, 100)];
    titleLabel.numberOfLines = 0;
    [self.view addSubview:titleLabel];
    titleLabel.textColor = [UIColor blueColor];
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(100, CGRectGetMaxY(titleLabel.frame)+30, 100, 50)];
    [self.view addSubview: button];
    
    button.backgroundColor = [UIColor blueColor];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitle:@"转换成数字" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick)];
    [self.view addGestureRecognizer:tap];
    self.view.userInteractionEnabled=YES;
    
}
-(void)tapClick{
    [self.view endEditing:YES];
}
-(void)btnClick{
    
    UITextField *text = (UITextField *) [self.view viewWithTag:200];
    NSString *str = text.text;
    
    for (int i = 0; i<str.length; i++) {
       char cc = [str characterAtIndex:i];
            char* ss;
            long i = strtol(&cc, &ss, 16);
        NSLog(@"%li",i);
    }
    
   
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
