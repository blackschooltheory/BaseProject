//
//  CalendarsNotifVC.m
//  BaseProject
//
//  Created by dlk on 2021/2/22.
//  Copyright © 2021 DLK. All rights reserved.
//

#import "CalendarsNotifVC.h"
#import <EventKit/EventKit.h>//给日历添加事件提醒需要引入的库
#import <EventKitUI/EventKitUI.h>//系统的添加日历事件界面需要引入的库

@interface CalendarsNotifVC ()<UITableViewDelegate,UITableViewDataSource,EKEventEditViewDelegate>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSArray *dataArry;
@property (nonatomic ,strong)EKEventStore *myEventStore;
@end

@implementation CalendarsNotifVC

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, [PublicMethodManager screenWith], [PublicMethodManager screenHeight]-64) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    }
    return _tableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    添加权限
//    Privacy - Calendars Usage Description 是否允许此App使用日历？
//    Privacy - Reminders Usage Description 是否允许此App访问提醒事项？
//    需要打开日历与提醒事项的通知权限；（这个权限关闭后是不能接收通知的）
//   在自己的手机上，测试设置了日历提醒定时；但是发现不能通知我；关机重启后可以正常收取通知
    // 当然日历与提醒事项的通知 没有极光推送这样的好；
    
    _dataArry = @[@"给当前的日历添加提醒",@"系统添加提醒",@"添加提醒事项(单一的直接用提醒的比较少)"];
    [self.view addSubview:self.tableView];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  _dataArry.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    cell.textLabel.text=_dataArry[indexPath.row];
    return  cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        //创建日历事件
        [self createCalendarsEvent];
        
    }
    
    if (indexPath.row == 2) {
        //创建提醒事件
        [self createReminderEvent];
    }
}
#pragma mark-----创建日历事件
-(void)createCalendarsEvent{
    EKEventStore *store = [[EKEventStore alloc]init];
    //判断是否响应该方法
    __weak typeof(self) weakSelf = self ;
    if ([store respondsToSelector:@selector(requestAccessToEntityType:completion:)]) {
        //获取访问权限
        [store requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError * _Nullable error) {
            if (error) {
                //报错了
            }else if (!granted){
                //无权限被用户拒绝权限
            }else{
                
                dispatch_async(dispatch_get_main_queue(), ^{
                   // 创建日历事件
                    EKEvent *event = [EKEvent eventWithEventStore:store];
                    NSDate *date = [NSDate date];
                    
                    event.title  = @"事件标题标标标--今天干什么" ;              //  事件标题
                    event.location = @"事件地点地地地地--杭州市区" ;          //  事件地点
                    event.notes = @"事件备注备备备---今天在杭州市区打酱油";               //  事件备注
                    // 事件URL
                    event.URL = [NSURL URLWithString:@"https//:www.baidu.com"];
                    event.startDate = [date dateByAddingTimeInterval:60 * 2];   // 开始时间
                    event.endDate   = [date dateByAddingTimeInterval:60 * 30];  // 结束时间
//                    event.allDay = YES 是否全天
                    
                    // 提醒（具体几分钟前）
                    //第一次提醒  (几分钟后)
                    [event addAlarm:[EKAlarm alarmWithRelativeOffset:60.0f * 1.0f]];
                    //第二次提醒
                    [event addAlarm:[EKAlarm alarmWithRelativeOffset:60.0f * 3.0f]];
                    
                    //设置日历
                    [event setCalendar:[store defaultCalendarForNewEvents]];
                    
                    NSError *err = nil;
                    [store
                     saveEvent:event span:EKSpanThisEvent error:&err];
                    
//                    EKSpanThisEvent  此事件
//                    EKSpanFutureEvents  此事件或未来事件 (删除可以用以重复的事件--定义了重复的未来事件)
                    
                    if (!err) {
                        //添加事件成功
                        //保存事件到缓存
                        NSString * identStr = event.eventIdentifier;
                        [[NSUserDefaults standardUserDefaults] setObject:identStr forKey:@"Save_EventID"];
                        [[NSUserDefaults standardUserDefaults] synchronize];
                        
                        [self showAlert:@"添加日历成功" withContentStr:@""];
                        
                    }else{
                        //添加事件失败
                    }
                    
                    
                });
            }
                    
        }];
    }
}

#pragma mark----获取缓存的日历事件
-(EKEvent *)historyCalendarEvent{
    //获取缓存的事件标志
    NSString *eventStr = [[NSUserDefaults standardUserDefaults]objectForKey:@"Save_EventID"];
    //通过事件标志获取事件
    EKEventStore *store = [[EKEventStore alloc]init];
    EKEvent *event = [store eventWithIdentifier:eventStr];
    return event;
}
#pragma  mark------修改事件
-(void)modifyEvent:(EKEvent *)event{
    EKEventStore *store = [[EKEventStore alloc]init];
    
    event.title = @"修改标题";
    event.startDate=[NSDate date];
    event.endDate=[NSDate date];
    
    [event addAlarm:[EKAlarm alarmWithRelativeOffset:60]]; //设置定时器提醒相对当前设置的开始事件后60 秒
    [event setCalendar:[store defaultCalendarForNewEvents]];//设置到日历中
    NSError *error = nil;
    [store saveEvent:event span:EKSpanThisEvent error:&error];
    if (!error) {
        //成功
    }else{
        //失败
    }
}

#pragma  mark----删除事件
-(void)removeEvent:(EKEvent *)event{
    EKEventStore *stroe = [[EKEventStore alloc]init];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        NSError *error = nil;
        //删除事件
        BOOL isRemoveState = [stroe removeEvent:event span:EKSpanThisEvent error:&error];
        if (!error && isRemoveState) {
            //删除成功
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@""];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
    });
}

#pragma mark------创建提醒事项
-(void)createReminderEvent{
    EKEventStore *store = [[EKEventStore alloc]init];
    
    [store requestAccessToEntityType:EKEntityTypeReminder completion:^(BOOL granted, NSError * _Nullable error) {
        
        if (error) {
            //报错了
            
        }
        else if (!granted){
            //无权限，去开通权限
        }else{
            //创建提醒事项
            
//            EKReminder *reminder = [EKReminder reminderWithEventStore:store];
//            reminder.title = @"提醒标题";
//            reminder.location = @"地址-杭州";
//            reminder.notes = @"事件备注";
//
//            reminder.startDateComponents = []
            
            EKReminder *reminder = [EKReminder reminderWithEventStore:self.myEventStore];
            //标题
            
            reminder.title = @"提醒标题";
            //添加日历
//            reminder.location = @"地址-杭州";
                       reminder.notes = @"事件备注";
            [reminder setCalendar:[self.myEventStore defaultCalendarForNewReminders]];
            
            NSCalendar *cal = [NSCalendar currentCalendar];
            
            [cal setTimeZone:[NSTimeZone systemTimeZone]];
            
            NSInteger flags = NSCalendarUnitYear | NSCalendarUnitMonth |
            
            NSCalendarUnitDay |NSCalendarUnitHour | NSCalendarUnitMinute |
            
            NSCalendarUnitSecond;
            
            NSDateComponents* dateComp = [cal components:flags fromDate:[NSDate dateWithTimeIntervalSinceNow:60]];
            
            dateComp.timeZone = [NSTimeZone systemTimeZone];
            
            reminder.startDateComponents = dateComp; //开始时间
            
            reminder.dueDateComponents = dateComp; //到期时间
            
            reminder.priority = 1; //优先级
            NSMutableArray *weekArr = [NSMutableArray array];
            NSArray *weeks = @[@1,@2,@3];//1代表周日以此类推
            //  也可以写成NSArray *weekArr = @[@(EKWeekdaySunday),@(EKWeekdayMonday),@(EKWeekdayTuesday)];
            [weeks enumerateObjectsUsingBlock:^(NSNumber * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                EKRecurrenceDayOfWeek *daysOfWeek = [EKRecurrenceDayOfWeek dayOfWeek:obj.integerValue];
                [weekArr addObject:daysOfWeek];
            }];
            //创建重复需要用到 EKRecurrenceRule
            //EKRecurrenceFrequencyDaily, 周期为天
            //EKRecurrenceFrequencyWeekly, 周期为周
            //EKRecurrenceFrequencyMonthly, 周期为月
            //EKRecurrenceFrequencyYearly  周期为年
            // EKRecurrenceRule *rule = [[EKRecurrenceRule alloc]initRecurrenceWithFrequency:EKRecurrenceFrequencyWeekly interval:1 daysOfTheWeek:weekArr daysOfTheMonth:nil monthsOfTheYear:nil weeksOfTheYear:nil daysOfTheYear:nil setPositions:nil end:nil];
            
            //每天
            EKRecurrenceRule *rule = [[EKRecurrenceRule alloc] initRecurrenceWithFrequency:(EKRecurrenceFrequencyDaily) interval:1 end:nil];
            [reminder addRecurrenceRule:rule];
            
            EKAlarm *alarm = [EKAlarm alarmWithAbsoluteDate:[NSDate dateWithTimeIntervalSinceNow:60]]; //添加一个闹钟
            
            [reminder addAlarm:alarm];
            
            NSError *err;
            
            [self.myEventStore saveReminder:reminder commit:YES error:&err];
            
            if (err) {
                
                
            }
        }
            
    }];
    
    
    
}




//打开系统的日历定时器页面
-(void)openUI{
    EKEventStore *eventStore = self.myEventStore;
    if([eventStore respondsToSelector:@selector(requestAccessToEntityType:completion:)]) {
        //EKEntityTypeEvent 事件页面
        //EKEntityTypeReminder 提醒页面
        [eventStore requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted,NSError* error){
            if(!granted){
                dispatch_async(dispatch_get_main_queue(), ^{
                    //TODO: 提示需要权限
                });
            }else{
                
                EKEvent *event = [EKEvent eventWithEventStore:eventStore];
                event.title = @"日历标题";
                
                EKCalendar* calendar;
                calendar = [EKCalendar calendarForEntityType:EKEntityTypeEvent eventStore:eventStore];
                NSError* error;
                [eventStore saveCalendar:calendar commit:YES error:&error];
                
                EKEventEditViewController *addController = [[EKEventEditViewController alloc] initWithNibName:nil bundle:nil];
                addController.event = event;
                addController.eventStore = eventStore;
                
                [self presentViewController:addController animated:YES completion:nil];
                addController.editViewDelegate = self;
            }
        }];
    }
}
#pragma mark - eventEditDelegates -
- (void)eventEditViewController:(EKEventEditViewController *)controller didCompleteWithAction:(EKEventEditViewAction)action{
    if (action ==EKEventEditViewActionCanceled) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    if (action==EKEventEditViewActionSaved) {
        [self dismissViewControllerAnimated:YES completion:nil];
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
