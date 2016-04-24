//
//  PopAnimation.m
//  CustomNavigation
//
//  Created by Bourbon on 16/4/24.
//  Copyright © 2016年 Bourbon. All rights reserved.
//

#import "PopAnimation.h"

@interface PopAnimation ()
@property (nonatomic,strong) id<UIViewControllerContextTransitioning>transitionContext;
@end
@implementation PopAnimation
//必须要实现他的两个代理方法
-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.25;
}
-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *containerView = [transitionContext containerView];
    [containerView insertSubview:toViewController.view belowSubview:fromViewController.view];
    
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    
    //动画的方式
    [UIView animateWithDuration:duration
                     animations:^{
                         fromViewController.view.transform = CGAffineTransformMakeTranslation([UIScreen mainScreen].bounds.size.width, 0);
                     } completion:^(BOOL finished) {
                         //当你动画执行完成，这个方法必须要调用，否则系统会认为你的其与操作都在动画执行过程中
                         [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
                     }];
}
-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    [_transitionContext completeTransition:!_transitionContext.transitionWasCancelled];
}
@end
