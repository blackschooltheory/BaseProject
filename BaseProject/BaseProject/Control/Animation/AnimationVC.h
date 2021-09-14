//
//  AnimationVC.h
//  BaseProject
//
//  Created by mac on 2021/8/11.
//  Copyright © 2021 DLK. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface AnimationVC : NSObject
-(void)addAnimationToLayer:(CALayer *)layer;
-(void)addBasicAnimationWithLayer:(CALayer *)layer;
@end

NS_ASSUME_NONNULL_END
