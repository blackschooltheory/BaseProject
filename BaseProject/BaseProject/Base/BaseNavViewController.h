//
//  BaseNavViewController.h
//  BaseProject
//
//  Created by dlk on 2021/6/7.
//  Copyright © 2021 DLK. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface BaseNavViewController : BaseViewController
@property(nonatomic,strong)NSArray <UIButton *> * leftButtonArr;
@property(nonatomic,strong)NSArray <UIButton *> * rightButtonArr;
@property(nonatomic,strong)UIColor *navBackColor ;

@end

NS_ASSUME_NONNULL_END
