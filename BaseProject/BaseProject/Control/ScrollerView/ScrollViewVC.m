//
//  ScrollViewVC.m
//  BaseProject
//
//  Created by dlk on 2021/6/1.
//  Copyright © 2021 DLK. All rights reserved.
//

#import "ScrollViewVC.h"
#import <SVGKit/SVGKit.h>

@interface ScrollViewVC ()<UIScrollViewDelegate>
{
    UIImageView *imageV ;
    UIScrollView *testScrollview ;
}
@end

@implementation ScrollViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    testScrollview = [[UIScrollView alloc]initWithFrame:self.view.frame];
    testScrollview.contentSize =CGSizeMake([PublicMethodManager screenWith]*3, [PublicMethodManager screenHeight ]);
    [self.view addSubview:testScrollview];
    testScrollview.pagingEnabled = YES;
    
    testScrollview.delegate = self;
    SVGKImage *svgimage = [SVGKImage imageNamed:@"svg1.svg"];
    svgimage.size = CGSizeMake([PublicMethodManager screenWith], [PublicMethodManager screenHeight]);
    
    imageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, [PublicMethodManager screenWith], [PublicMethodManager screenHeight])];
    
    imageV.image = svgimage.UIImage;
    [testScrollview addSubview:imageV];
    
    //增加了 最大最小缩放方式后scrollview 是不能够滚动的了，只能缩放
    testScrollview.minimumZoomScale = 1;
    testScrollview.maximumZoomScale = 2;
    [testScrollview setZoomScale:1.00 animated:YES];
    
    
    /*
     
    //绘制坐标
    UIBezierPath * path = [[UIBezierPath alloc]init];
       path.lineWidth = 1.0;
       [path moveToPoint:CGPointMake( 0, 527 )];
       [path addLineToPoint:CGPointMake( 90, 527 )];
       [path addLineToPoint:CGPointMake( 99.96, 541.85 )];
       [path addLineToPoint:CGPointMake( 153.13, 546.03 )];
       [path addLineToPoint:CGPointMake( 204.96, 560.85 )];
       [path addLineToPoint:CGPointMake( 250.96, 585.85 )];
       [path addLineToPoint:CGPointMake( 310.87, 636.47 )];
       [path addLineToPoint:CGPointMake( 336.96, 662.85 )];
       [path addLineToPoint:CGPointMake( 402.5, 641.5 )];
       [path addLineToPoint:CGPointMake( 485.5, 647.5 )];
       CAShapeLayer *lineChartLayer = [CAShapeLayer layer];
       lineChartLayer.path = path.CGPath;
       lineChartLayer.strokeColor = [UIColor redColor].CGColor;
       lineChartLayer.fillColor = [[UIColor clearColor] CGColor];
       // 默认设置路径宽度为0，使其在起始状态下不显示
       lineChartLayer.lineWidth = 1;
       [imageV.layer addSublayer:lineChartLayer];
     
     */
    
}
-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
 
    return imageV;
}
- (void)scrollViewDidZoom:(UIScrollView *)scrollView{
    
}
-(void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)finalScale{
//    view.transform = CGAffineTransformIdentity;
//        view.bounds = CGRectApplyAffineTransform(view.bounds, CGAffineTransformMakeScale(finalScale, finalScale));
//        [view setNeedsDisplay];

//    testScrollview.minimumZoomScale /= finalScale;
//    testScrollview.maximumZoomScale /= finalScale;
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
