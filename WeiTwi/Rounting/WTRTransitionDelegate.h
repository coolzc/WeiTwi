//
//  WTRTransitionDelegate.h
//  WeiTwi
//
//  Created by zhangcheng on 10/16/15.
//  Copyright © 2015 XYZ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface WTRTransitionDelegate : NSObject <UIViewControllerTransitioningDelegate, UINavigationControllerDelegate>

@property (nonatomic, assign) BOOL presentFromTop;
@property (nonatomic, assign) BOOL dismissToTop;

+ (instancetype)delegateForPresentFromTop:(BOOL)presentFromTop;
+ (instancetype)delegateForDismissToTop:(BOOL)dismissToTop;

@end
