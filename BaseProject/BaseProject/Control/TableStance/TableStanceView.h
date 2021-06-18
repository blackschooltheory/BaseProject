//
//  TableStanceView.h
//  BaseProject
//
//  Created by 邓烈康 on 2021/5/24.
//  Copyright © 2021 DLK. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TableStanceView : UIView

@property(nonatomic,copy)  void(^stanceBlock) (void) ;


- (instancetype)initWithFrame:(CGRect)frame withGif:(NSString *)gifStr;
@end

NS_ASSUME_NONNULL_END
