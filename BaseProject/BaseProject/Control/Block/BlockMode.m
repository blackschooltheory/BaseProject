//
//  BlockMode.m
//  BaseProject
//
//  Created by dlk on 2021/3/28.
//  Copyright © 2021 DLK. All rights reserved.
//

#import "BlockMode.h"

NSString *blockName ;
@implementation BlockMode
+(instancetype)manager{
    return [[[self class]alloc]initWithGood:@"hhh"];
}
-(instancetype)initWithGood:(NSString *)name{
    self = [super init];
    if (!self) {
        return nil;
    }
    return self;
}
+(void)load{
    //再要加载内存就会调用
    NSLog(@"调用了load 方法");
}
+(void)initialize{
    NSLog(@"调用了initialize方法");
}
-(void)creatBlock:(NSString * _Nonnull (^)(NSString * _Nonnull))bblock{
    NSString * goodGirle = @"好朋友";
   NSString *gggg =  bblock(goodGirle);
    NSLog(@"%@",gggg);
    blockName =@"1234";
}



@end
