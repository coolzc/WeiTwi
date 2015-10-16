//
//  ViewController.h
//  BuddhaSaid
//
//  Created by zhangcheng on 5/23/15.
//  Copyright (c) 2015 XYZ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WTRPageMessenger.h"

@interface WTRWireframe : NSObject

+ (UIViewController *)entryScreen;
+ (void)moveToNextPageOfViewController:(UIViewController *)viewController;
+ (void)moveToNextPageOfViewController:(UIViewController *)viewController messenger:(WTRPageMessenger *)messenger;
+ (void)moveToPreviousPageOfViewController:(UIViewController *)viewController;


@end

