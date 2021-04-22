//
//  TableRunLoopCell.h
//  BaseProject
//
//  Created by dlk on 2021/4/8.
//  Copyright © 2021 DLK. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TableRunLoopCell : UITableViewCell
@property (nonatomic , strong) NSString * leftImageStr ;
@property (nonatomic , strong) NSString * centerStr;
@property (nonatomic , assign) BOOL isShowLabel ;
-(void)showCenterLabel;
@end

NS_ASSUME_NONNULL_END
