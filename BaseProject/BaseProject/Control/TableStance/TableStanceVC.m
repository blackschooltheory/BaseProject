//
//  TableStanceVC.m
//  BaseProject
//
//  Created by 邓烈康 on 2021/5/24.
//  Copyright © 2021 DLK. All rights reserved.
//

#import "TableStanceVC.h"
#import "UITableView+StabceImage.h"


@interface TableStanceVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *dataArry;
@end

@implementation TableStanceVC

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, [PublicMethodManager screenWith], [PublicMethodManager screenHeight]) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource =self;
        _tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _dataArry = @[];
    [self.view addSubview:self.tableView];
    
//    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
//    button.backgroundColor = [UIColor blueColor];
//    [self.view addSubview:button];
//    [button addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    
    
//    [_tableView reloadData];
    
//    [self performSelector:@selector(time3) withObject:nil afterDelay:3];
    
    
    [self.view layoutIfNeeded];
    __weak typeof(self) weakSelf = self;
    _tableView.reloadBlock = ^{
        weakSelf.dataArry = @[@"1",@"2",@"3"];
        [weakSelf.tableView reloadData];
        
    };
    
}
-(void)time3{
    _dataArry = @[@"1",@"2",@"3"];
//   NSInteger num = [self tableView:_tableView numberOfRowsInSection:0];
//    NSLog(@"自动获取row数量==%i",num);
    
       [_tableView reloadData];
}
//-(void)btnClick{
//    id <UITableViewDataSource> dataSource = _tableView.dataSource;
////
////    NSInteger sections = [dataSource numberOfSectionsInTableView:_tableView];
////    NSLog(@"session =%i",sections);
////    NSInteger row = [dataSource tableView:_tableView numberOfRowsInSection:sections];
////    NSLog(@"-----------");
//    _dataArry = @[@"1",@"2",@"3"];
//    [_tableView reloadData];
//}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_dataArry count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
        
    }
    NSString *titleStr = _dataArry[indexPath.row];
    cell.textLabel.text = titleStr;
    return cell;
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
