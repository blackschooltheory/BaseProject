//
//  TableRunLoopCell.m
//  BaseProject
//
//  Created by dlk on 2021/4/8.
//  Copyright © 2021 DLK. All rights reserved.
//

#import "TableRunLoopCell.h"
#import "PublicMethodManager.h"
@interface TableRunLoopCell ()
@property(nonatomic,strong)UIImageView *leftImageView ;
@property(nonatomic,strong)UILabel *centerLabel;
@property(nonatomic,strong)UIImageView *rightView;
@end

@implementation TableRunLoopCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _leftImageView = [[UIImageView alloc]initWithFrame:CGRectMake(15, 5, 50, 50)];
        [self.contentView addSubview:_leftImageView];
        
        _centerLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_leftImageView.frame)+30, 15, 200, 30)];
        [self.contentView addSubview:_centerLabel];
        _centerLabel.textColor = [UIColor blueColor];
    }
    
    return self;
}

-(void)setCenterStr:(NSString *)centerStr{
    _centerStr = centerStr;
//    if (_isShowLabel) {
//        _centerLabel.text = centerStr;
//    }else{
        _centerLabel.text = @"";
//    }
    
}
-(void)setLeftImageStr:(NSString *)leftImageStr{
//    _leftImageView.image =
}
-(void)showCenterLabel{
    _centerLabel.text = _centerStr;
}
- (void)loadImage{
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
