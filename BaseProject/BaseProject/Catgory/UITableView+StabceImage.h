//
//  UITableView+StabceImage.h
//  BaseProject
//
//  Created by 邓烈康 on 2021/5/11.
//  Copyright © 2021 DLK. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


//typedef void(^ReloadBlock)(void);


@interface UITableView (StabceImage)
@property (nonatomic, assign) BOOL firstReload;
@property (nonatomic, strong) UIView *placeholderView;
@property (nonatomic,   copy) void(^reloadBlock)(void);
@end

NS_ASSUME_NONNULL_END
