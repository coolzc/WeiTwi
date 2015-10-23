//
//  WTRTransitionDelegate.h
//  WeiTwi
//
//  Created by zhangcheng on 10/16/15.
//  Copyright © 2015 XYZ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "WTRConfig.h"

@interface WTRTransitionDelegate : NSObject <UIViewControllerTransitioningDelegate, UINavigationControllerDelegate>

+ (instancetype)delegateForPresentFrom:(WTRTransitionDirection)direction viewController:(UIViewController *)viewController;
+ (instancetype)delegateForDismissFrom:(WTRTransitionDirection)direction viewController:(UIViewController *)viewController;

@end
