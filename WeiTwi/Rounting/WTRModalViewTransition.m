//
//  WTRModalViewTransition.m
//  WeiTwi
//
//  Created by zhangcheng on 10/16/15.
//  Copyright © 2015 XYZ. All rights reserved.
//

#import "WTRModalViewTransition.h"

@interface WTRModalViewTransition ()

@property (readwrite, nonatomic, assign) WTRTransitionType type;
@property (readwrite, nonatomic, assign) BOOL moveInFromTop;

@end

@implementation WTRModalViewTransition

+ (instancetype)moveInTransitionFromTop:(BOOL)moveInFromTop type:(WTRTransitionType)type {
    WTRModalViewTransition *transition = [WTRModalViewTransition new];
    transition.type = type;
    transition.moveInFromTop = moveInFromTop;
    return transition;
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.5f;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {

}

#pragma mark - Private Methods

- (void)animateShowTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    
    //caculate position
    CGRect toFrame = containerView.bounds;
    CGRect fromFrame = toFrame;
    if (self.moveInFromTop) {
        fromFrame.origin.y -= fromFrame.size.height;
    } else {
        fromFrame.origin.y += fromFrame.size.height;
    }
    toViewController.view.frame = fromFrame;
    [containerView addSubview:toViewController.view];
    
    //animation
    NSTimeInterval duration =[self transitionDuration:transitionContext];
    [UIView animateWithDuration:duration
                     animations:^{
                         toViewController.view.frame = toFrame;
                   } completion:^(BOOL finished) {
                       [transitionContext completeTransition:YES];
                     }];
}

- (void)animateDismissTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController* fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    // calculate positions
    CGRect toFrame = fromViewController.view.frame;
    if (self.moveInFromTop) {
        toFrame.origin.y -= toFrame.size.height;
    } else {
        toFrame.origin.y += toFrame.size.height;
    }
    
    // animation
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    [UIView animateWithDuration:duration animations:^{
        fromViewController.view.frame = toFrame;
    } completion:^(BOOL finished) {
        [fromViewController.view removeFromSuperview];
        [transitionContext completeTransition:YES];
    }];
}

- (void)animatePopTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController* fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController* toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView* containerView = [transitionContext containerView];
    [containerView insertSubview:toViewController.view belowSubview:fromViewController.view];
    
    // calculate positions
    CGRect toFrame = fromViewController.view.frame;
    if (self.moveInFromTop) {
        toFrame.origin.y -= toFrame.size.height;
    } else {
        toFrame.origin.y += toFrame.size.height;
    }
    
    // animation
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    [UIView animateWithDuration:duration animations:^{
        fromViewController.view.frame = toFrame;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
    }];
}


@end
