//
//  CustomNavigationController.m
//  CustomNavigation
//
//  Created by Bourbon on 16/4/24.
//  Copyright © 2016年 Bourbon. All rights reserved.
//

#import "CustomNavigationController.h"
#import "NavigationInteractiveTransition.h"
@interface CustomNavigationController ()<UIGestureRecognizerDelegate>
@property (nonatomic,strong) NavigationInteractiveTransition *navT;
@end

@implementation CustomNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //先禁掉系统的座滑返回手势
    UIGestureRecognizer *gesture = self.interactivePopGestureRecognizer;
    gesture.enabled = NO;
    
    //新建一个返回手势，然后添加到当前手势界面上
    UIView *gestureView = gesture.view;
    UIPanGestureRecognizer *popRecoginzer = [[UIPanGestureRecognizer alloc] init];
    [popRecoginzer setDelegate:self];
    [popRecoginzer setMaximumNumberOfTouches:1];
    [gestureView addGestureRecognizer:popRecoginzer];
    
    
    _navT = [[NavigationInteractiveTransition alloc] initWithViewController:self];
    [popRecoginzer addTarget:_navT action:@selector(handleControllerPop:)];
}
-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    ///根视图或者正在进行动画时不支持手势
    if (self.viewControllers.count != 1 && ![[self valueForKey:@"_isTransitioning"] boolValue]) {
        return YES;
    }
    return NO;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
