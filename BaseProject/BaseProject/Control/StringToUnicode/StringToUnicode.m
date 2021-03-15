//
//  StringToUnicode.m
//  BaseProject
//
//  Created by 邓烈康 on 2021/3/8.
//  Copyright © 2021 DLK. All rights reserved.
//

#import "StringToUnicode.h"

@interface StringToUnicode ()

@end

@implementation StringToUnicode

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //字符转换
    
    UITextField *textFiled = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, [PublicMethodManager screenWith]-60, 50)];
    textFiled.tag = 200;
    textFiled.center = CGPointMake([PublicMethodManager screenWith]/2.0, 300);
    textFiled.backgroundColor = [UIColor  grayColor];
    textFiled.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:textFiled];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(30, CGRectGetMaxY(textFiled.frame)+30, [PublicMethodManager screenWith]-60, 100)];
    titleLabel.numberOfLines = 0;
    titleLabel.tag = 300;
    [self.view addSubview:titleLabel];
    titleLabel.backgroundColor = [UIColor brownColor];
    titleLabel.textColor = [UIColor blueColor];
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(100, CGRectGetMaxY(titleLabel.frame)+30, 100, 50)];
    [self.view addSubview: button];
    
    button.backgroundColor = [UIColor blueColor];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitle:@"转换成数字" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick)];
    [self.view addGestureRecognizer:tap];
    self.view.userInteractionEnabled=YES;
    
}
-(void)tapClick{
    [self.view endEditing:YES];
}
-(void)btnClick{
    
    UITextField *text = (UITextField *) [self.view viewWithTag:200];
    NSString *str = text.text;
    NSString *encryption = [self strEncryption:str];
    
    NSArray *arry = [encryption componentsSeparatedByString:@"|"];
    
    NSMutableString *showStr = [[NSMutableString alloc]init];
    for (int i = 0; i<arry.count; i++) {
        NSString *pointStr = arry[i];
        NSInteger dataNum = [pointStr integerValue]+i; //加密处理过减一现在要加回来
        //只能转化中文字符，若要转换数字与英文要修改下面代码
        NSString *unicodeStr=[NSString stringWithFormat:@"\\u%x",dataNum];
        [showStr appendString:unicodeStr];
    }
    
    UILabel *label = (UILabel *) [self.view viewWithTag:300];
    label.text = [self replaceUnicode:showStr];
    
   
}

//将字符转换为数字
-(NSString *)strEncryption:(NSString *)encryptionStr{
    NSMutableArray *arrys = [[NSMutableArray alloc]init];
    for (int i = 0; i<encryptionStr.length; i++) {
        NSString *pointStr = [encryptionStr substringWithRange:NSMakeRange(i,1)];
        //字符串转
        NSString * uni = [self utf8ToUnicode:pointStr];
        NSString *lastNum = uni;
        if (uni.length>3) {
            lastNum = [uni substringFromIndex:2];
        }
      //strtoul(lastNum.UTF8String, 0, 16) 将16位unicode 转化为10进制数字
        long pointNum = strtoul(lastNum.UTF8String, 0, 16)-i; //减一个数相当于加密
        [arrys addObject:[NSString stringWithFormat:@"%i",pointNum]];
    }
    return  [arrys componentsJoinedByString:@"|"];
    
    
}
// 字符转化为 unicode (就是//u + 16位)
-(NSString *) utf8ToUnicode:(NSString *)string
{
   NSUInteger length = [string length];
    NSMutableString *s = [NSMutableString stringWithCapacity:0];
    
   for (int i =0;i < length; i++)
    {
       unichar _char = [string characterAtIndex:i];
        //判断是否为英文和数字
       if (_char <= '9' && _char >='0')
        {
            [s appendFormat:@"%@",[string substringWithRange:NSMakeRange(i,1)]];
        }
       else if(_char >='a' && _char <='z')
        {
            [s appendFormat:@"%@",[string substringWithRange:NSMakeRange(i,1)]];
        }
       else if(_char >='A' && _char <='Z')
        {
            [s appendFormat:@"%@",[string substringWithRange:NSMakeRange(i,1)]];
        }
       else
        {
            [s appendFormat:@"\\u%x",[string characterAtIndex:i]];
        }
    }
   return s;
}

//unicode  转换回原先转换前的字符串
-(NSString *)replaceUnicode:(NSString *)unicodeStr
{
    if (unicodeStr.length == 0) {
        return unicodeStr;
    }
    NSString *tempStr1 = [unicodeStr stringByReplacingOccurrencesOfString:@"\\u"withString:@"\\U"];
    NSString *tempStr2 = [tempStr1 stringByReplacingOccurrencesOfString:@"\""withString:@"\\\""];
    NSString *tempStr3 = [[@"\""stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    NSString* returnStr = [NSPropertyListSerialization propertyListWithData:tempData options:kCFPropertyListImmutable format:nil error:nil];
    NSLog(@"%@",returnStr);
    return [returnStr stringByReplacingOccurrencesOfString:@"\\r\\n"withString:@"\n"];
}
/*
#pragma mark - Navigation

// In a s toryboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
