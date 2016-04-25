//
//  ViewController.m
//  CustomNavigation
//
//  Created by Bourbon on 16/4/24.
//  Copyright © 2016年 Bourbon. All rights reserved.
//

#import "ViewController.h"
#import "SecondViewController.h"
#import "Text.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor lightGrayColor];
    self.navigationController.navigationBar.hidden = YES;
    Text *text = [[Text alloc] initWithFrame:self.view.frame];
    [text setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:text];
//    CGFloat space = 24;
//    CTParagraphStyleSetting firstLine ;
//    firstLine.spec = kCTParagraphStyleSpecifierFirstLineHeadIndent;
//    firstLine.value = &space;
//    firstLine.valueSize = sizeof(float);
//    
//    UILabel *label = [[UILabel alloc] initWithFrame:self.view.frame];
//    [self.view addSubview:label];
//    NSString *src = @"其实流程是这样的： 1、生成要绘制的NSAttributedString对象。 2、生成一个CTFramesetterRef对象，然后创建一个CGPath对象，这个Path对象用于表示可绘制区域坐标值、长宽。 3、使用上面生成的setter和path生成一个CTFrameRef对象，这个对象包含了这两个对象的信息（字体信息、坐标信息），它就可以使用CTFrameDraw方法绘制了。";
//    NSMutableAttributedString * mabstring = [[NSMutableAttributedString alloc]initWithString:src];
//
//    CTParagraphStyleSetting setting[] = {firstLine};
//    CTParagraphStyleRef ref = CTParagraphStyleCreate(setting, 1);
//    NSMutableDictionary *attributes = [NSMutableDictionary dictionaryWithObject:(id)ref forKey:(id)kCTParagraphStyleAttributeName];
//    [mabstring addAttributes:attributes range:NSMakeRange(0, mabstring.length)];
//    [label setAttributedText:mabstring];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    SecondViewController *second = [[SecondViewController alloc] init];
    [self.navigationController pushViewController:second animated:YES];
}
@end
