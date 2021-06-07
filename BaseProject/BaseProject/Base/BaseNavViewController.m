//
//  BaseNavViewController.m
//  BaseProject
//
//  Created by dlk on 2021/6/7.
//  Copyright © 2021 DLK. All rights reserved.
//

#import "BaseNavViewController.h"

@interface BaseNavViewController ()

@end

@implementation BaseNavViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.leftButtonArr = [[NSArray alloc]init];
    self.rightButtonArr = [[NSArray alloc]init];
    self.navBackColor = [UIColor whiteColor];
    [self createLeftBtns:nil];
}

#pragma mark---创建导航栏左边按钮
-(void)createLeftBtns:(NSArray *)leftBtns{
    
    if(!leftBtns || leftBtns.count == 0){
        //默认只有返回按钮
        UIButton *leftBtn = [[UIButton alloc]init];
        [leftBtn setBackgroundImage:[UIImage imageNamed:@"nav_back"] forState:UIControlStateNormal];
        [leftBtn addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *leftBtnItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
        self.navigationItem.leftBarButtonItem = leftBtnItem;
        
    }else{
        //导航栏左侧有多个按钮
        NSMutableArray *leftArr = [NSMutableArray new];
        for (UIButton *btn in leftBtns) {
            UIBarButtonItem *leftBtnItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
            [leftArr addObject:leftBtnItem];
        }
        self.navigationItem.leftBarButtonItems = leftArr;
    }
}
-(void)back:(UIButton *)btn{
    [self.navigationController popViewControllerAnimated:YES];
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
