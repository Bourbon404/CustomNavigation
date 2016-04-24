//
//  NavigationInteractiveTransition.h
//  CustomNavigation
//
//  Created by Bourbon on 16/4/24.
//  Copyright © 2016年 Bourbon. All rights reserved.
//

#import <Foundation/Foundation.h>
@class UIViewController,UIPercentDrivenInteractiveTransition,UIPanGestureRecognizer;

@interface NavigationInteractiveTransition : NSObject

-(instancetype)initWithViewController:(UIViewController *)vc;
-(void)handleControllerPop:(UIPanGestureRecognizer *)recognizer;
-(UIPercentDrivenInteractiveTransition *)interactivePopTransition;
@end
