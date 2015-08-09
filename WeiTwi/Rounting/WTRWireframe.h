//
//  ViewController.h
//  BuddhaSaid
//
//  Created by zhangcheng on 5/23/15.
//  Copyright (c) 2015 XYZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WTRWireframe : NSObject

+ (UIViewController *)entryPoint;
+ (UIViewController *)moveToHomeViewControllerFrom:(UIViewController *)viewcontroller;
+ (void)dismissToPreviousPageOfViewController:(UIViewController *)viewController;

@end

