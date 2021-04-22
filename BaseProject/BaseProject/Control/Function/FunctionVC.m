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
#import "GCDVC.h"
#import "ProjectResourceManager.h"
#import "BlockVC.h"
#import "RunloopVC.h"
#import "RunLoopFunctionVC.h"
@interface FunctionVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSArray * dataArry;

@end

@implementation FunctionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataArry = @[@"横竖屏控制",@"转屏动画",@"截屏获取通知（iOS 不能实现禁止截屏功能）",@"系统日历写入提示信息",@"设备root环境监测",@"UTF-8与Unicode转换",@"GCD",@"项目资源文件管理",@"Block",@"Runloop"];
    [self.view addSubview:self.tableView];
    
}
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 88, self.view.frame.size.width, self.view.frame.size.height-88) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    }
    return _tableView;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArry.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellid = @"cellid";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellid];
    }
    NSString *titleStr = _dataArry[indexPath.row];
    cell.textLabel.text = titleStr;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        //横竖屏控制
        DeviceOrientation *deviceVC=[[DeviceOrientation alloc]init];
//        deviceVC.modalPresentationStyle=UIModalPresentationFullScreen;
//        deviceVC.modalTransitionStyle=UIModalTransitionStyleCoverVertical;
//        deviceV.transitioningDelegate=
        deviceVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:deviceVC animated:YES];
    }
    if(indexPath.row == 1){
        //推出屏幕动画
        TransitionAnimate *transitionVC = [[TransitionAnimate alloc]init];
        transitionVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:transitionVC animated:YES];
    }
    if (indexPath.row == 2) {
        //禁止截屏功能
        
        ForbidCatchScreenVC *vc = [[ForbidCatchScreenVC alloc]init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    
        
    }
    if (indexPath.row==3) {
        //系统日历写入事件
        CalendarsNotifVC *vc = [[CalendarsNotifVC alloc]init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (indexPath.row == 4) {
        //字符串转换数字
//        StringToUnicode *vc = [[StringToUnicode alloc]init];
//        vc.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:vc animated:YES];
        NSString *str = @"网易";
        NSString *encode = [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        NSLog(@"%@",encode);
        
        
    }
    if (indexPath.row == 6) {
        GCDVC *vc = [[GCDVC alloc]init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (indexPath.row == 7) {
        ProjectResourceManager *vc = [[ProjectResourceManager alloc]init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (indexPath.row == 8) {
        BlockVC *vc = [[BlockVC alloc]init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (indexPath.row == 9) {
        RunLoopFunctionVC *vc = [[RunLoopFunctionVC alloc]init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

//将字符装换为数字
-(NSString *)strEncryption:(NSString *)encryptionStr{
    NSMutableArray *arrys = [[NSMutableArray alloc]init];
    for (int i = 0; i<encryptionStr.length; i++) {
        NSString *pointStr = [encryptionStr substringWithRange:NSMakeRange(i,1)];
        //字符串转
        NSString * uni = [self utf8ToUnicode:pointStr];
        NSString *lastNum = uni;
        if (uni.length>3) {
            lastNum = [uni substringFromIndex:2];
        }
      
        long pointNum = strtoul(lastNum.UTF8String, 0, 16)-i;
        [arrys addObject:[NSString stringWithFormat:@"%i",pointNum]];
    }
    return  [arrys componentsJoinedByString:@"|"];
    
    
}

-(NSString *) utf8ToUnicode:(NSString *)string
{
   NSUInteger length = [string length];
    NSMutableString *s = [NSMutableString stringWithCapacity:0];
    
   for (int i =0;i < length; i++)
    {
       unichar _char = [string characterAtIndex:i];
        //判断是否为英文和数字
       if (_char <= '9' && _char >='0')
        {
            [s appendFormat:@"%@",[string substringWithRange:NSMakeRange(i,1)]];
        }
       else if(_char >='a' && _char <='z')
        {
            [s appendFormat:@"%@",[string substringWithRange:NSMakeRange(i,1)]];
        }
       else if(_char >='A' && _char <='Z')
        {
            [s appendFormat:@"%@",[string substringWithRange:NSMakeRange(i,1)]];
        }
       else
        {
            [s appendFormat:@"\\u%x",[string characterAtIndex:i]];
        }
    }
   return s;
}


-(NSString *)replaceUnicode:(NSString *)unicodeStr
{

    if (unicodeStr.length == 0) {
        return unicodeStr;
    }

    NSString *tempStr1 = [unicodeStr stringByReplacingOccurrencesOfString:@"\\u"withString:@"\\U"];
    NSString *tempStr2 = [tempStr1 stringByReplacingOccurrencesOfString:@"\""withString:@"\\\""];
    NSString *tempStr3 = [[@"\""stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    NSString* returnStr = [NSPropertyListSerialization propertyListWithData:tempData options:kCFPropertyListImmutable format:nil error:nil];
    NSLog(@"%@",returnStr);
    return [returnStr stringByReplacingOccurrencesOfString:@"\\r\\n"withString:@"\n"];
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
