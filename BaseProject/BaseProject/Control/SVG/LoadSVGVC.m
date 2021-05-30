//
//  LoadSVGVC.m
//  BaseProject
//
//  Created by dlk on 2021/5/29.
//  Copyright © 2021 DLK. All rights reserved.
//

#import "LoadSVGVC.h"
#import <SVGKit/SVGKit.h>
#import <Masonry/Masonry.h>
@interface LoadSVGVC ()

@end

@implementation LoadSVGVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSArray *titleArr = @[@"加载SVG图片"];
    UIButton *button = [[UIButton alloc]init];
    button.backgroundColor = [UIColor blueColor];
    [self.view addSubview:button];
    [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.view.mas_top).mas_offset([PublicMethodManager nativeTopHeight]+30);
    }];
//    button.tag = 1000;
    [button setTitle:titleArr[0] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
}
-(void)btnClick:(UIButton *)button{
    SVGKImage *svgimage = [SVGKImage imageNamed:@"svg1.svg"];
    svgimage.size = CGSizeMake(200, 200);
    UIImageView *imageView = [[UIImageView alloc]init];
    [self.view addSubview:imageView];
    imageView.image = svgimage.UIImage;
    imageView.contentMode =  UIViewContentModeScaleAspectFill;
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(button.mas_bottom).offset(50);
    }];
    
    
}

/*
#pragma mark - Navigation 

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
