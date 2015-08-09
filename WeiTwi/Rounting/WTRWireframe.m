//
//  ViewController.m
//  BuddhaSaid
//
//  Created by zhangcheng on 5/23/15.
//  Copyright (c) 2015 XYZ. All rights reserved.
//

#import "WTRWireframe.h"
#import "WTRAssemblingFactory.h"

@implementation WTRWireframe

+ (UIViewController *)entryPoint {
    UIViewController *welcomViewController = [WTRAssemblingFactory assembleWelcomeViewController];
    return welcomViewController;
}

+ (UIViewController *)moveToHomeViewControllerFrom:(UIViewController *)viewcontroller{
    UIViewController *homeViewController = [WTRAssemblingFactory assembleHomeViewController];
    homeViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [viewcontroller presentViewController:homeViewController animated:NO completion:nil];
    return homeViewController;
}

+ (void)dismissToPreviousPageOfViewController:(UIViewController *)viewController {
    [viewController dismissViewControllerAnimated:YES completion:nil];
}

@end
