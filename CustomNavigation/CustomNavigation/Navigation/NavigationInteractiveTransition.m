//
//  NavigationInteractiveTransition.m
//  CustomNavigation
//
//  Created by Bourbon on 16/4/24.
//  Copyright © 2016年 Bourbon. All rights reserved.
//

#import "NavigationInteractiveTransition.h"
#import <UIKit/UIKit.h>
#import "PopAnimation.h"
@interface NavigationInteractiveTransition ()<UINavigationControllerDelegate>
{
    //开始的进度和结束的进度
    CGFloat beginProgress;
    CGFloat endProgress;
}
@property (nonatomic,weak) UINavigationController *vc;
@property (strong,nonatomic) UIPercentDrivenInteractiveTransition *interactivePopTransition;
@end
@implementation NavigationInteractiveTransition
-(instancetype)initWithViewController:(UIViewController *)vc
{
    if (self = [super init]) {
        self.vc = (UINavigationController *)vc;
        self.vc.delegate = self;
    }
    return self;
}
-(void)handleControllerPop:(UIPanGestureRecognizer *)recognizer
{
    //根据当前位置和屏幕宽度作比较来判断进度
    CGFloat progress = [recognizer translationInView:recognizer.view].x / recognizer.view.bounds.size.width;
    progress = MIN(1.0, MAX(0.0, progress));
    
    //设置开始和结束值
    CGFloat change = progress * 0.05;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        beginProgress = change + 0.95;
    });
    endProgress = change + 0.95;
    
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        self.interactivePopTransition = [[UIPercentDrivenInteractiveTransition alloc] init];
        [self.vc popViewControllerAnimated:YES];
    }else if (recognizer.state == UIGestureRecognizerStateChanged){
        
        [self startAnimationWihtEndprogress:@(endProgress)];
        beginProgress = endProgress;
        [self.interactivePopTransition updateInteractiveTransition:progress];
    }else if (recognizer.state == UIGestureRecognizerStateEnded || recognizer.state == UIGestureRecognizerStateCancelled){
        if (progress > 0.5) {
            float delayTime = 0.35 - progress*0.3;
            [self performSelector:@selector(startAnimationWihtEndprogress:) withObject:@(1) afterDelay:delayTime];
            [self.interactivePopTransition finishInteractiveTransition];
        }else{
            [self.interactivePopTransition cancelInteractiveTransition];
        }
        self.interactivePopTransition = nil;
    }
}
-(id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC
{
    if (operation == UINavigationControllerOperationPop) {
        return [[PopAnimation alloc] init];
    }return nil;
}
-(id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController
{
    if ([animationController isKindOfClass:[PopAnimation class]]) {
        return self.interactivePopTransition;
    }
    return nil;
}
-(void)startAnimationWihtEndprogress:(NSNumber *)number
{
    CABasicAnimation *theAnimation;
    theAnimation=[CABasicAnimation animationWithKeyPath:@"transform.scale"];
    theAnimation.duration = 0.3;
    theAnimation.repeatCount = 1;
    theAnimation.delegate = self;
    theAnimation.removedOnCompletion = NO;
    theAnimation.fillMode = kCAFillModeForwards;
    theAnimation.fromValue = [NSNumber numberWithFloat:beginProgress]; // 开始时的倍率
    theAnimation.toValue = number; // 结束时的倍率
    [[self.vc.viewControllers firstObject].view.layer addAnimation:theAnimation forKey:@"transition"];

}
@end
