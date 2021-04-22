//
//  RunloopVC.m
//  BaseProject
//
//  Created by dlk on 2021/4/8.
//  Copyright © 2021 DLK. All rights reserved.
//

#import "RunloopVC.h"
#import "TableRunLoopCell.h"

@interface RunloopVC ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
@property (nonatomic , strong) UITableView *tableView;
@property (nonatomic , strong) NSMutableArray *dataArry;
@property (nonatomic , strong) NSArray *cacheArry;
@end

@implementation RunloopVC

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, [PublicMethodManager screenWith], [PublicMethodManager screenHeight]) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    }
    return _tableView;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    scrollView.contentOffset.y
}

static void Callback(CFRunLoopObserverRef observer, CFRunLoopActivity activity, void *info){
    NSLog(@"不断滚动=========%i",activity);
    RunloopVC * vcSelf = (__bridge RunloopVC *)(info);
//    || activity == kCFRunLoopBeforeWaiting
    if (activity == kCFRunLoopBeforeWaiting ){

                   

      NSArray *cells =  vcSelf.tableView.visibleCells;
        vcSelf.cacheArry = cells;
        for (TableRunLoopCell *cell in cells) {
            cell.isShowLabel = YES;
            [cell showCenterLabel];
        }
//        NSLog(@"结束滑动");
//                CFRunLoopWakeUp(CFRunLoopGetCurrent());
            }

    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _dataArry = [[NSMutableArray alloc]init];
    for (int i =0; i<200; i++) {
        [_dataArry addObject:[NSString stringWithFormat:@"第%i个数据现在正在现场",i]];
    }
   
    [self.view addSubview:self.tableView];
    
    
    CFRunLoopRef runloop = CFRunLoopGetCurrent();
        //定义一个centext
        CFRunLoopObserverContext context = {
            0,
            ( __bridge void *)(self),
            &CFRetain,
            &CFRelease,
            NULL
        };
        //定义一个观察者
        static CFRunLoopObserverRef defaultModeObsever;
        //创建观察者
        defaultModeObsever = CFRunLoopObserverCreate(NULL,
                                                     kCFRunLoopBeforeWaiting,
                                                     YES,
                                                     NSIntegerMax - 999,
                                                     &Callback,
                                                     &context
                                                     );
        
        //添加当前RunLoop的观察者
        CFRunLoopAddObserver(runloop, defaultModeObsever, kCFRunLoopDefaultMode);
        //c语言有creat 就需要release
        CFRelease(defaultModeObsever);

//    NSArray *arry = self.tableView.visibleCells ;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArry.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *labeStr = _dataArry[indexPath.row];
    static NSString *cellID = @"cellD";
    TableRunLoopCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[TableRunLoopCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    cell.centerStr = labeStr;

    return cell;
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
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
