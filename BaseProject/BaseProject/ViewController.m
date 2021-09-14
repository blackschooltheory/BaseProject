//
//  ViewController.m
//  BaseProject
//
//  Created by DLK on 2020/12/7.
//  Copyright © 2020 DLK. All rights reserved.
//

#import "ViewController.h"
#import <dlfcn.h>
#import <libkern/OSAtomic.h>


@interface ViewController ()

@end

@implementation ViewController
{
    UITextField *texttFile;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor brownColor];
    // Do any additional setup after loading the view.gonn
//
//    for
    
    
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(100,100 , 200, 50)];
    label.textColor=[UIColor blackColor];
    label.tag=1000;
    [self.view addSubview:label];
    label.font=[UIFont preferredFontForTextStyle:UIFontTextStyleSubheadline];
    
    label.text=@"军官证";
    
//    NSLog(@"%c",@"h".UTF8String);
//    [self utf8ToUnicode:@"军官证"];
    
    NSString *uuu8= [self stringToUTF8:@"hellow军"];
    
     NSLog(@"%@",uuu8);
    
    UIButton *button=[[UIButton alloc]initWithFrame:CGRectMake(100, 200, 100, 50)];
    button.backgroundColor=[UIColor blueColor];
    [self.view addSubview:button];
    [button addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    
    NSNotificationCenter *center=[NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(updateFont:) name:UIContentSizeCategoryDidChangeNotification object:nil];
    
    
    texttFile=[[UITextField alloc]initWithFrame:CGRectMake(100, 300, 200, 50)];
    [self.view addSubview:texttFile];
    

    
}
- (NSString *)stringToUTF8:(NSString *)string
{
    return [string stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
}
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

-(void)updateFont:(NSNotification *)noti{
     NSLog(@"%@ === %@ === %@", noti.object, noti.userInfo, noti.name);
    NSLog(@"12354");
}
-(void)btnClick{
    
    NSString *iiiii=[NSString stringWithFormat:@"%i",@"a"];
    
    
    NSString *sss=[texttFile.text stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSString *ccc=[self utf8ToUnicode:texttFile.text];
    NSLog(@"-----%@", [self replaceUnicode:@"\U0000e601"]);
    NSString * ttt=texttFile.text;
    UILabel *label=(UILabel *)[self.view viewWithTag:1000];
    label.font=[UIFont preferredFontForTextStyle:UIFontTextStyleBody];
}
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



@end
