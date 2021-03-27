//
//  MVP_Presenter.h
//  BaseProject
//
//  Created by dlk on 2021/3/22.
//  Copyright © 2021 DLK. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MVP_Model;

NS_ASSUME_NONNULL_BEGIN
@protocol MVC_ViewProtcol <NSObject>
- (void) updateDataArry:(NSMutableArray <MVP_Model *> *)arry;
@end

@interface MVP_Presenter : NSObject

@property(nonatomic,weak) id <MVC_ViewProtcol> viewDeleaget;

@end

NS_ASSUME_NONNULL_END
