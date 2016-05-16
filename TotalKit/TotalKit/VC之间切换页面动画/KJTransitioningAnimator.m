//
//  KJTransitioningAnimator.m
//  TotalKit
//
//  Created by kinjin on 16/3/21.
//  Copyright © 2016年 kinjin. All rights reserved.
//

#import "KJTransitioningAnimator.h"
#import "FirstViewController.h"

#import <CoreGraphics/CoreGraphics.h>
@interface KJTransitioningAnimator ()<UIViewControllerAnimatedTransitioning>

@property (weak, nonatomic) id transitionContext;

@end
@implementation KJTransitioningAnimator
-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return 0.5f;
}
-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    self.transitionContext = transitionContext;
    UIView *containerView = [transitionContext containerView];
    FirstViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    FirstViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    [containerView addSubview:toVC.view];
    UIButton *btn = fromVC.firstBtn;
    UIBezierPath *originPath = [UIBezierPath bezierPathWithOvalInRect:btn.frame];
    CGPoint extremePoint = CGPointMake(btn.center.x - 0, btn.center.y - CGRectGetHeight(toVC.view.bounds));
    float radius = sqrtf(extremePoint.x * extremePoint.x + extremePoint.y * extremePoint.y);
    UIBezierPath *finalPath = [UIBezierPath bezierPathWithOvalInRect:CGRectInset(btn.frame, -radius, -radius)];
    
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.path = finalPath.CGPath;
    toVC.view.layer.mask = maskLayer;
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"path"];
    animation.fromValue = (__bridge id _Nullable)(originPath.CGPath);
    animation.toValue  = (__bridge id _Nullable)(finalPath.CGPath);
    animation.duration = [self transitionDuration:transitionContext];
    animation.delegate = self;
    [maskLayer addAnimation:animation forKey:@"path"];

    
}
-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    [self.transitionContext completeTransition:![self.transitionContext transitionWasCancelled]];
    [self.transitionContext viewControllerForKey:UITransitionContextToViewControllerKey].view.layer.mask = nil;
}
@end
