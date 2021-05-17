//
//  Carsh.h
//  BaseProject
//
//  Created by dlk on 2021/5/17.
//  Copyright © 2021 DLK. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Carsh : NSObject

void  caughtExceptionHandler(NSException *exception);

@end

NS_ASSUME_NONNULL_END
