//
//  TimerModel.h
//  BaseProject
//
//  Created by dlk on 2021/6/15.
//  Copyright © 2021 DLK. All rights reserved.
//

#import <Foundation/Foundation.h>

@class  TimerVC;
NS_ASSUME_NONNULL_BEGIN

@interface TimerModel : NSObject
@property(nonatomic,weak)TimerVC *targetVC;

@end

NS_ASSUME_NONNULL_END
