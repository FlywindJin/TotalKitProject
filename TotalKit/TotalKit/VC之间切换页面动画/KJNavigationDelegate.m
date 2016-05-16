//
//  KJNavigationDelegate.m
//  TotalKit
//
//  Created by kinjin on 16/3/21.
//  Copyright © 2016年 kinjin. All rights reserved.
//

#import "KJNavigationDelegate.h"
#import "KJTransitioningAnimator.h"
@implementation KJNavigationDelegate
-(id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC{
    return [KJTransitioningAnimator new];;
    
}

@end
