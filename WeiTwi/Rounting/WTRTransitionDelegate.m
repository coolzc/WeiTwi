//
//  WTRTransitionDelegate.m
//  WeiTwi
//
//  Created by zhangcheng on 10/16/15.
//  Copyright © 2015 XYZ. All rights reserved.
//

#import "WTRTransitionDelegate.h"
#import "WTRModalViewTransition.h"
#import "WTRSwipeHorizontalInteractiveTransition.h"

@interface WTRTransitionDelegate ()

@property (nonatomic, strong) WTRSwipeHorizontalInteractiveTransition *interactiveSwipeTransition;
@property (nonatomic, assign) WTRTransitionDirection direction;
@property (nonatomic, strong) UIPercentDrivenInteractiveTransition *interactivePopTransition;

@end

@implementation WTRTransitionDelegate

//once use delegateForPresentFromTop or delegateForDismissToTop method,present or dismiss will be the same direction
+ (instancetype)delegateForPresentFrom:(WTRTransitionDirection)direction viewController:(UIViewController *)viewController {
    WTRSwipeHorizontalInteractiveTransition *interactiveSwipeTransition = [WTRSwipeHorizontalInteractiveTransition new];
    [interactiveSwipeTransition wireToViewController:viewController];
    WTRTransitionDelegate *delegate = [WTRTransitionDelegate new];
    delegate.direction = direction;
    return delegate;
}

+ (instancetype)delegateForDismissFrom:(WTRTransitionDirection)direction viewController:(UIViewController *)viewController {
    WTRSwipeHorizontalInteractiveTransition *interactiveSwipeTransition = [WTRSwipeHorizontalInteractiveTransition new];
    [interactiveSwipeTransition wireToViewController:viewController];
    WTRTransitionDelegate *delegate = [WTRTransitionDelegate new];
    delegate.direction = direction;
    return delegate;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                  presentingController:(UIViewController *)presenting
                                                                      sourceController:(UIViewController *)source {
    return [WTRModalViewTransition moveInTransitionType:WTRTransitionShow direction:self.direction];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return [WTRModalViewTransition moveInTransitionType:WTRTransitionDismiss direction:self.direction];
}

//TODO : add horizontal swipe to navigation controller
- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                  animationControllerForOperation:(UINavigationControllerOperation)operation
                                               fromViewController:(UIViewController *)fromVC
                                                 toViewController:(UIViewController *)toVC {
    if (UINavigationControllerOperationPush == operation) {
        return [WTRModalViewTransition moveInTransitionType:WTRTransitionPop direction:self.direction];
    } else {
        return [WTRModalViewTransition moveInTransitionType:WTRTransitionDismiss direction:self.direction];
    }

}

- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController {
    return self.interactiveSwipeTransition;
}

- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id<UIViewControllerAnimatedTransitioning>)animator {
    return self.interactiveSwipeTransition.interacting ? self.interactiveSwipeTransition : nil;
}

- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator {
    return self.interactiveSwipeTransition.interacting ? self.interactiveSwipeTransition : nil;
}

//- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
//    navigationController.delegate = nil; //one time use this
//}

@end
