//
//  ProtocolVC.m
//  BaseProject
//
//  Created by dlk on 2021/6/16.
//  Copyright © 2021 DLK. All rights reserved.
//

#import "ProtocolVC.h"




/*
 面向接口编程 组件化的项目开发
 定义优秀的组件开发
 、、、
 */

@interface ProtocolVC ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,strong)UICollectionView *masterCollectionView;
@property(nonatomic,strong)NSArray *dataArry;
@end

@implementation ProtocolVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
    
    
    
}
-(UICollectionView *)masterCollectionView{
    if (!_masterCollectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.itemSize = CGSizeMake(50, 50);
        
        _masterCollectionView = [[ UICollectionView alloc]initWithFrame:CGRectMake(0, 0, [PublicMethodManager screenWith], [PublicMethodManager screenHeight]-34) collectionViewLayout:layout];
        _masterCollectionView.delegate =self;
        _masterCollectionView.dataSource =self;
//        _masterCollectionView
    }
    return _masterCollectionView;
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
