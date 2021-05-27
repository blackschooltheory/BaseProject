//
//  UITableView+StabceImage.m
//  BaseProject
//
//  Created by 邓烈康 on 2021/5/11.
//  Copyright © 2021 DLK. All rights reserved.
//

/*
 通过  method  swizzling  的方式给 tableView 设置无数据时的站位图；
 
 */



#import "UITableView+StabceImage.h"
#import <objc/runtime.h>
#import "TableStanceView.h"

@implementation UITableView (StabceImage)

+(void)load{
    // 在load中到底要不要调用 [super load];调用了又会导致什么问题（涉及到父类，子类，父类分类，子类分类的执行顺序问题：并没有正确的顺序关于父类分类与子类分类(按照编译顺序来实现)）；若想执行继承体系上的load 则需要调用  [super load]
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class selfClass = [self class];
        
        SEL originalSel = @selector(reloadData);
        SEL swizzlingSel = @selector(reloadSwizzling);
        
        
        Method originalMethod = class_getInstanceMethod(selfClass, @selector(reloadData));
        Method swizzlingMethod = class_getInstanceMethod(selfClass, @selector(reloadSwizzling));
        
        /*
         通过  class_addMethod  给当前的类添加SEL对应的IMP 是否成功；若成功则说明IMP是父类中的方法（本类中添加父类的方法并将SEL与父类的IMP绑定）
         若失败则说明 本类已经有了该IMP，添加不了；
         */
        
        BOOL addMethod = class_addMethod(selfClass, originalSel, method_getImplementation(swizzlingMethod), method_getTypeEncoding(swizzlingMethod));
        if (addMethod) {
            //父类中有该方法
            //已经将original的方法的IMP换成了Swizzling 的了
            
            //我们只需将 swizzlingSel的IMP更换下即可
            class_replaceMethod(selfClass, swizzlingSel, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
        }else{
            //只在本类中有该方法
            method_exchangeImplementations(originalMethod, swizzlingMethod);
        }
    });
    
    
}

- (void)checkEmpty {
    BOOL isEmpty = YES;//flag标示
    id <UITableViewDataSource> dataSource = self.dataSource; //获取加载tableView 页面对象
    // 下面的获取 section 与 row 的方法 实际上是加载 tableView 页面的数据源数据返回的 所以间接的可以判断当前的数据源是否有值，来判断是否显示数据加载图。
    NSInteger sections = 1;//默认一组
    if ([dataSource respondsToSelector:@selector(numberOfSectionsInTableView:)]) {
        sections = [dataSource numberOfSectionsInTableView:self] - 1;//获取当前TableView组数
    }
    
    for (NSInteger i = 0; i <= sections; i++) {
        NSInteger rows = [dataSource tableView:self numberOfRowsInSection:sections];//获取当前TableView各组行数
        if (rows) {
            isEmpty = NO;//若行数存在，不为空
        }
    }
    if (isEmpty) {//若为空，加载占位图
        if (!self.placeholderView) {//若未自定义，展示默认占位图
            [self makeDefaultPlaceholderView];
        }
        self.placeholderView.hidden = NO;
        [self addSubview:self.placeholderView];
    } else {//不为空，隐藏占位图
        self.placeholderView.hidden = YES;
    }
}

- (void)makeDefaultPlaceholderView {
    self.bounds = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    TableStanceView *placeholderView = [[TableStanceView alloc] initWithFrame: CGRectMake(0, 0, 100, 100) withGif:@""];
    //点击占位图中的按钮来重新加载数据
    __weak typeof(self) weakSelf = self;
    placeholderView.stanceBlock = ^{
        if (weakSelf.reloadBlock) {
            weakSelf.reloadBlock();
        }
    };
    self.placeholderView = placeholderView;
}

#pragma mark-------交换的方法
-(void)reloadSwizzling{
    [self checkEmpty];
    [self reloadSwizzling];// 该方法执行的是 reload 方法
}


- (BOOL)firstReload {
    return [objc_getAssociatedObject(self, @selector(firstReload)) boolValue];
}

- (void)setFirstReload:(BOOL)firstReload {
    objc_setAssociatedObject(self, @selector(firstReload), @(firstReload), OBJC_ASSOCIATION_ASSIGN);
}

- (UIView *)placeholderView {
    return objc_getAssociatedObject(self, @selector(placeholderView));
}

- (void)setPlaceholderView:(UIView *)placeholderView {
    objc_setAssociatedObject(self, @selector(placeholderView), placeholderView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void (^)(void))reloadBlock {
    return objc_getAssociatedObject(self, @selector(reloadBlock));
}

- (void)setReloadBlock:(void (^)(void))reloadBlock {
    objc_setAssociatedObject(self, @selector(reloadBlock), reloadBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

@end
