//
//  ProjectResourceView.h
//  BaseProject
//
//  Created by dlk on 2021/3/26.
//  Copyright © 2021 DLK. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ProjectResourceView : UIView
@property (nonatomic , strong) UITableView *tableView;
@property (nonatomic , strong) NSMutableArray *dataArry;
@end

NS_ASSUME_NONNULL_END
