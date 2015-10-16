//
//  BSAssemblingFactory.m
//  BuddhaSaid
//
//  Created by zhangcheng on 5/23/15.
//  Copyright (c) 2015 XYZ. All rights reserved.
//

#import "WTRAssemblingFactory.h"
#import "UIStoryboard+WeiTwi.h"

#import "WTRSplashScreenViewController.h"
#import "HomeViewController.h"
#import "WTRMessageViewController.h"
#import "WTRExploreViewController.h"
#import "WTRSettingViewController.h"
#import "WTRDeckViewController.h"

#import "WTRDataSyncInteractor.h"

static NSString* const SplashScreenIdentifier = @"WTRSplashScreenViewController";
static NSString* const HomeViewControllerIndentifier = @"HomeViewController";
static NSString* const MessageViewControllerIndentifier = @"WTRMessageViewController.h";
static NSString* const ExploreViewControllerIndentifier = @"WTRExploreViewController.h";
static NSString* const SettingViewControllerIndentifier = @"WTRSettingViewController.h";
static NSString* const DeckViewControllerIdentifier = @"WTRDeckViewController";

@implementation WTRAssemblingFactory

+ (WTRBaseViewController *)assembleSplashScreen {
    WTRSplashScreenViewController *viewController = [[UIStoryboard genericStoryboard] instantiateViewControllerWithIdentifier:SplashScreenIdentifier];
    viewController.initializaitonPresenter = [self buildInitializationPresenter];
    return viewController;
}

+ (WTRBaseViewController *)assembleHomeView {
    HomeViewController *viewController = [[UIStoryboard mainStoryboard] instantiateViewControllerWithIdentifier:HomeViewControllerIndentifier];
    viewController.navigationPresenter = [self buildNavigationPresenter];
    return viewController;
}

+ (WTRBaseViewController *)assembleMessageView {
    WTRMessageViewController *viewController = [[UIStoryboard mainStoryboard] instantiateViewControllerWithIdentifier:MessageViewControllerIndentifier];
    return viewController;
}

+ (WTRBaseViewController *)assembleExploreView {
    WTRExploreViewController *viewController = [[UIStoryboard mainStoryboard] instantiateViewControllerWithIdentifier:ExploreViewControllerIndentifier];
    return viewController;
}

+ (WTRBaseViewController *)assembleSettingView {
    WTRSettingViewController *viewController = [[UIStoryboard mainStoryboard] instantiateViewControllerWithIdentifier:SettingViewControllerIndentifier];
    return viewController;
}

+ (WTRBaseViewController *)assembleDeckView {
    WTRDeckViewController *viewController = [[UIStoryboard mainStoryboard] instantiateViewControllerWithIdentifier:DeckViewControllerIdentifier];
    viewController.navigationPresenter = [self buildNavigationPresenter];
    return viewController;
}



+ (UINavigationController *)wrapWithDefaultNavigationController:(UIViewController *)viewController {
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:viewController];
    return navigationController;
}

+ (UITabBarController *)wrapWithDefaultTabBarController:(NSArray *)viewControllers {
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    tabBarController.viewControllers = [NSArray arrayWithArray:viewControllers];
    return tabBarController;
}

#pragma mark - Assembling Presenters

+ (WTRInitializationPresenter *)buildInitializationPresenter {
    WTRInitializationPresenter *initializationPresenter = [WTRInitializationPresenter new];
    WTRDataSyncInteractor *dataSyncInteractor = [WTRDataSyncInteractor new];
    initializationPresenter.dataSyncInteractor = dataSyncInteractor;
    dataSyncInteractor.delegate = initializationPresenter;
    return initializationPresenter;
}


+ (WTRNavigationPresenter *)buildNavigationPresenter {
    WTRNavigationPresenter *navigationPresenter = [WTRNavigationPresenter new];
    return navigationPresenter;
}


@end
