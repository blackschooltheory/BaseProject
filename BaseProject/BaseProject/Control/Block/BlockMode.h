//
//  BlockMode.h
//  BaseProject
//
//  Created by dlk on 2021/3/28.
//  Copyright © 2021 DLK. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BlockMode : NSObject

+(instancetype)manager;

-(void)creatBlock:(NSString * (^)(NSString *))bblock;


@end

NS_ASSUME_NONNULL_END
