//
//  MVC_ViewController.m
//  BaseProject
//
//  Created by dlk on 2021/3/22.
//  Copyright © 2021 DLK. All rights reserved.
//

#import "MVC_ViewController.h"
#import "MVP_Model.h"
#import "MVP_Presenter.h"
@interface MVC_ViewController ()<MVC_ViewProtcol>

@end

@implementation MVC_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}
-(void)updateDataArry:(NSMutableArray<MVP_Model *> *)arry{
    //代理更新tableView的数据
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
