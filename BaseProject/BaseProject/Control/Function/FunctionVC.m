//
//  FunctionVC.m
//  BaseProject
//
//  Created by DLK on 2020/12/22.
//  Copyright © 2020 DLK. All rights reserved.
//

#import "FunctionVC.h"
#import "DeviceOrientation.h"
#import "TransitionAnimate.h"
#import "ForbidCatchScreenVC.h"
#import "CalendarsNotifVC.h"
#import "StringToUnicode.h"
@interface FunctionVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSArray * dataArry;

@end

@implementation FunctionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataArry=@[@"横竖屏控制",@"转屏动画",@"截屏获取通知（iOS 不能实现禁止截屏功能）",@"系统日历写入提示信息",@"设备root环境监测",@"UTF-8与Unicode转换"];
    [self.view addSubview:self.tableView];
    
}
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 88, self.view.frame.size.width, self.view.frame.size.width-88) style:UITableViewStylePlain];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
    }
    return _tableView;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArry.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellid=@"cellid";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellid];
    }
    NSString *titleStr=_dataArry[indexPath.row];
    cell.textLabel.text=titleStr;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row==0) {
        //横竖屏控制
        DeviceOrientation *deviceVC=[[DeviceOrientation alloc]init];
//        deviceVC.modalPresentationStyle=UIModalPresentationFullScreen;
//        deviceVC.modalTransitionStyle=UIModalTransitionStyleCoverVertical;
//        deviceV.transitioningDelegate=
        deviceVC.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:deviceVC animated:YES];
    }
    if(indexPath.row==1){
        //推出屏幕动画
        TransitionAnimate *transitionVC=[[TransitionAnimate alloc]init];
        transitionVC.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:transitionVC animated:YES];
    }
    if (indexPath.row==2) {
        //禁止截屏功能
        
        ForbidCatchScreenVC *vc=[[ForbidCatchScreenVC alloc]init];
        vc.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (indexPath.row==3) {
        //系统日历写入事件
        CalendarsNotifVC *vc = [[CalendarsNotifVC alloc]init];
        vc.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (indexPath.row == 4) {
        //字符串转换数字
        StringToUnicode *vc = [[StringToUnicode alloc]init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
}
//取随机数 0--3 获取三个不同的数
-(NSArray *)arcNum{
    NSMutableArray *arry = [[NSMutableArray alloc]init];
    while (arry.count < 3) {
        int num = arc4random() % 4 ;
        if (![arry containsObject:@(num)]) {
            [arry addObject: @(num)];
        }
    }
    return arry;
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
