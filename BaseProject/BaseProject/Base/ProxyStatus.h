//
//  ProxyStatus.h
//  BaseProject
//
//  Created by dlk on 2021/6/8.
//  Copyright © 2021 DLK. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ProxyStatus : NSObject
@property(nonatomic,strong,nonnull) NSString *str2;
@property(nonatomic,strong,nullable) NSString *str3;
@property(nonatomic,strong,null_resettable) NSString *str4;
@property(nonatomic,strong,null_unspecified) NSString *str1;

+ (BOOL)getProxyStatus;
@end

NS_ASSUME_NONNULL_END
