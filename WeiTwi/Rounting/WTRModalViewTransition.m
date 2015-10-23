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
@property (readwrite, nonatomic, assign) WTRTransitionDirection moveInDirection;

@end

@implementation WTRModalViewTransition

+ (instancetype)moveInTransitionType:(WTRTransitionType)type direction:(WTRTransitionDirection)direction {
    WTRModalViewTransition *transition = [WTRModalViewTransition new];
    transition.type = type;
    transition.moveInDirection = direction;
    return transition;
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.5f;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    switch (self.type) {
        case WTRTransitionShow:
            [self animateShowTransition:transitionContext];
            break;
            
        case WTRTransitionDismiss:
            [self animateDismissTransition:transitionContext];
            break;
            
        case WTRTransitionPop:
            [self animatePopTransition:transitionContext];
            break;
            
        default:
            break;
    }
}
#pragma mark - Private Methods

- (void)animateShowTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    UIViewController* toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView* containerView = [transitionContext containerView];
    
    // calculate positions
    CGRect toFrame = containerView.bounds;
    CGRect fromFrame = toFrame;
    switch (self.moveInDirection) {
        case WTRTransitionFromTop:
            fromFrame.origin.y -= fromFrame.size.height;
            break;
        case WTRTransitionFromRight:
            fromFrame.origin.x += fromFrame.size.width;
            break;
        case WTRTransitionFromBottom:
            fromFrame.origin.y += fromFrame.size.height;
            break;
        case WTRTransitionFromLeft:
            fromFrame.origin.x -= fromFrame.size.width;
            break;
        default:
            break;
    }
    toViewController.view.frame = fromFrame;
    [containerView addSubview:toViewController.view];
    
    // animation
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    [UIView animateWithDuration:duration animations:^{
        toViewController.view.frame = toFrame;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
    }];
}

- (void)animateDismissTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    UIViewController* fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    // calculate positions
    CGRect toFrame = fromViewController.view.frame;
    switch (self.moveInDirection) {
        case WTRTransitionFromTop:
            toFrame.origin.y -= toFrame.size.height;
            break;
        case WTRTransitionFromRight:
            toFrame.origin.x += toFrame.size.width;
            break;
        case WTRTransitionFromBottom:
            toFrame.origin.y += toFrame.size.height;
            break;
        case WTRTransitionFromLeft:
            toFrame.origin.x -= toFrame.size.width;
            break;
        default:
            break;
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

- (void)animatePopTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    UIViewController* fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController* toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView* containerView = [transitionContext containerView];
    [containerView insertSubview:toViewController.view belowSubview:fromViewController.view];

    // calculate positions
    CGRect toFrame = fromViewController.view.frame;
    switch (self.moveInDirection) {
        case WTRTransitionFromTop:
            toFrame.origin.y -= toFrame.size.height;
            break;
        case WTRTransitionFromRight:
            toFrame.origin.x += toFrame.size.width;
            break;
        case WTRTransitionFromBottom:
            toFrame.origin.y += toFrame.size.height;
            break;
        case WTRTransitionFromLeft:
            toFrame.origin.x -= toFrame.size.width;
            break;
        default:
            break;
    }
    
    // animation
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    [UIView animateWithDuration:duration animations:^{
        fromViewController.view.frame = toFrame;
    } completion:^(BOOL finished) {
        //TODO:
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
    }];
}


@end
