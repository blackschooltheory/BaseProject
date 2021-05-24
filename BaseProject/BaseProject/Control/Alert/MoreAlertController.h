//
//  MoreAlertController.h
//  BaseProject
//
//  Created by dlk on 2021/5/21.
//  Copyright © 2021 DLK. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MoreAlertController : NSObject
@property(nonatomic,strong)NSMutableArray <UIViewController *> *alertList;

+ (instancetype)defaultAlert;
@end

NS_ASSUME_NONNULL_END
