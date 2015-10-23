//
//  BSAssemblingFactory.h
//  BuddhaSaid
//
//  Created by zhangcheng on 5/23/15.
//  Copyright (c) 2015 XYZ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "WTRBaseViewController.h"

@interface WTRAssemblingFactory : NSObject

+ (WTRBaseViewController *)assembleSplashScreen;
+ (UIViewController *)assembleHomeView;//homeViewController is tabViewController
+ (WTRBaseViewController *)assembleTimelineView;
+ (WTRBaseViewController *)assembleMessageView;
+ (WTRBaseViewController *)assembleExploreView;
+ (WTRBaseViewController *)assembleSettingView;
+ (WTRBaseViewController *)assembleDeckView;

+ (UINavigationController *)wrapWithDefaultNavigationController:(UIViewController *)viewController;
+ (UITabBarController *)wrapWithDefaultTabBarController:(NSArray *)viewControllers;

@end
