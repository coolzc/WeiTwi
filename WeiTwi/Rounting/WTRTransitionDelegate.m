//
//  WTRTransitionDelegate.m
//  WeiTwi
//
//  Created by zhangcheng on 10/16/15.
//  Copyright © 2015 XYZ. All rights reserved.
//

#import "WTRTransitionDelegate.h"
#import "WTRModalViewTransition.h"
@implementation WTRTransitionDelegate

+ (instancetype)delegateForPresentFromTop:(BOOL)presentFromTop {
    WTRTransitionDelegate *delegate = [WTRTransitionDelegate new];
    delegate.presentFromTop = presentFromTop;
    delegate.dismissToTop = presentFromTop;
    return delegate;
}

+(instancetype)delegateForDismissToTop:(BOOL)dismissToTop {
    WTRTransitionDelegate *delegate = [WTRTransitionDelegate new];
    delegate.presentFromTop = dismissToTop;
    delegate.dismissToTop = dismissToTop;
    return delegate;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                  presentingController:(UIViewController *)presenting
                                                                      sourceController:(UIViewController *)source {
    return [WTRModalViewTransition moveInTransitionFromTop:self.presentFromTop type:WTRTransitionShow];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return [WTRModalViewTransition moveInTransitionFromTop:self.dismissToTop type:WTRTransitionDismiss];
}

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                  animationControllerForOperation:(UINavigationControllerOperation)operation
                                               fromViewController:(UIViewController *)fromVC
                                                 toViewController:(UIViewController *)toVC {
    if (UINavigationControllerOperationPush == operation) {
        return [WTRModalViewTransition moveInTransitionFromTop:self.presentFromTop type:WTRTransitionPop];
    } else {
        return [WTRModalViewTransition moveInTransitionFromTop:self.dismissToTop type:WTRTransitionDismiss];
    }

}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    navigationController.delegate = nil; //one time use this
}

@end
