//
//  Animation_StudyVC.m
//  BaseProject
//
//  Created by mac on 2021/8/11.
//  Copyright © 2021 DLK. All rights reserved.
//

#import "Animation_StudyVC.h"
#import "AnimationVC.h"
@interface Animation_StudyVC ()

@end

@implementation Animation_StudyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    UIView *view  = [[UIView alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
    view.backgroundColor = [UIColor grayColor];
    [self.view addSubview:view];
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(viewTag:) ];
    view.userInteractionEnabled = YES;
    [view addGestureRecognizer:tap];
}
-(void)viewTag:(UITapGestureRecognizer *)tag{
    UIView *view = tag.view;
    AnimationVC  * aa = [AnimationVC new];
    [aa addBasicAnimationWithLayer:view.layer];
}

-(void)createUI{
//    UITableViewController *vc = [UITableViewController new];
    UITableView *tableView = [UITableView new];
    tableView.delegate = self;
    tableView.dataSource = self;
    
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
