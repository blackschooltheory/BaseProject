//
//  BaseViewController.h
//  BaseProject
//
//  Created by dlk on 2021/2/20.
//  Copyright © 2021 DLK. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PublicMethodManager.h"
#import <Masonry/Masonry.h>
NS_ASSUME_NONNULL_BEGIN

@interface BaseViewController : UIViewController
-(void)showAlert:(NSString *)titleStr withContentStr:(NSString *)contentStr;
@end
NS_ASSUME_NONNULL_END
