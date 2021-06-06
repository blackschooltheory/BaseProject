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
#import <AFNetworking/AFNetworking.h>
@interface LoadSVGVC ()

@end

@implementation LoadSVGVC
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
//        self.view.backgroundColor = [UIColor blueColor];
    }
    return self;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.view.backgroundColor = [UIColor blueColor];
    }
    return self;
}
- (void)loadView{
//    [super loadView];
}
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
    
    UILabel *label = [[UILabel alloc]init];
    [label sizeToFit];
    
    
    
    
}

-(UIImage *)name:(NSString *)name imgv:(UIImageView *)imgv tintColor:(UIColor *)tintColor{
    
    UIImage *svgImage = [SVGKImage imageNamed:@"svg1.svg"].UIImage;
    
    CGRect rect = CGRectMake(0, 0, svgImage.size.width, svgImage.size.height);
    CGImageAlphaInfo alphaInfo = CGImageGetAlphaInfo(svgImage.CGImage);
    BOOL opaque = alphaInfo == (kCGImageAlphaNoneSkipLast | kCGImageAlphaNoneSkipFirst | kCGImageAlphaNone);
    UIGraphicsBeginImageContextWithOptions(svgImage.size, opaque, svgImage.scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, 0, svgImage.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextSetBlendMode(context, kCGBlendModeNormal);
    CGContextClipToMask(context, rect, svgImage.CGImage);
    
    CGContextSetFillColorWithColor(context, tintColor.CGColor);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
    
}


-(void)loadData{
    
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = 5.0;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"application/json", @"text/plain", @"text/json", @"text/javascript",nil];
    manager.requestSerializer.cachePolicy = NSURLRequestUseProtocolCachePolicy;
    NSInteger timeInter = [NSDate timeIntervalSinceReferenceDate];
    //添加时间字符串可以防止 304 not modified 缓存问题解决
    NSString *urlStr = [NSString stringWithFormat:@"http://192.168.169.94:8080/abc.json?t=%i",timeInter];
    [manager GET:urlStr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *result = (NSDictionary *) responseObject;
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (error) {
                NSLog(@"%@",error.localizedDescription);
            }
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
