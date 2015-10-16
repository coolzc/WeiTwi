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
#import "WTRTimeLineViewController.h"
#import "WTRMessageViewController.h"
#import "WTRExploreViewController.h"
#import "WTRSettingViewController.h"
#import "WTRDeckViewController.h"

#import "WTRDataSyncInteractor.h"

static NSString* const SplashScreenIdentifier = @"WTRSplashScreenViewController";
static NSString* const TimeLineViewController = @"WTRTimeLineViewController";
static NSString* const MessageViewControllerIndentifier = @"WTRMessageViewController";
static NSString* const ExploreViewControllerIndentifier = @"WTRExploreViewController";
static NSString* const SettingViewControllerIndentifier = @"WTRSettingViewController";
static NSString* const DeckViewControllerIdentifier = @"WTRDeckViewController";

@implementation WTRAssemblingFactory

+ (WTRBaseViewController *)assembleSplashScreen {
    WTRSplashScreenViewController *viewController = [[UIStoryboard genericStoryboard] instantiateViewControllerWithIdentifier:SplashScreenIdentifier];
    viewController.initializaitonPresenter = [self buildInitializationPresenter];
    return viewController;
}

+ (UIViewController *)assembleHomeView {
    WTRBaseViewController *timeLineViewController = [self assembleTimelineView];
    timeLineViewController.title = NSLocalizedString(@"tab-bar-item-timeline", nil);
    timeLineViewController.tabBarItem.image = [UIImage imageNamed:@"tab_item_timeline"];
    timeLineViewController.tabBarItem.selectedImage = [UIImage imageNamed:@"tab_item_timeline_selected"];
    timeLineViewController.navigationItem.title = NSLocalizedString(@"navigation-title-timeline-list", nil);
    timeLineViewController.needShowTabbar = YES;
    
    WTRBaseViewController *messageViewController = [self assembleMessageView];
    messageViewController.title = NSLocalizedString(@"tab-bar-item-message", nil);
    messageViewController.tabBarItem.image = [UIImage imageNamed:@"tab_item_message"];
    messageViewController.tabBarItem.selectedImage = [UIImage imageNamed:@"tab_item_message_selected"];
    messageViewController.navigationItem.title = NSLocalizedString(@"navigation-title-message-list", nil);
    messageViewController.needShowTabbar = YES;
    
    WTRBaseViewController *exploreViewController = [self assembleExploreView];
    exploreViewController.title = NSLocalizedString(@"tab-bar-item-explore", nil);
    exploreViewController.tabBarItem.image = [UIImage imageNamed:@"tab_item_explore"];
    exploreViewController.tabBarItem.selectedImage = [UIImage imageNamed:@"tab_item_explore_selected"];
    exploreViewController.navigationItem.title = NSLocalizedString(@"navigation-title-explore-list", nil);
    exploreViewController.needShowTabbar = YES;
    
    WTRBaseViewController *settingViewController = [self assembleSettingView];
    settingViewController.title = NSLocalizedString(@"tab-bar-item-setting", nil);
    settingViewController.tabBarItem.image = [UIImage imageNamed:@"tab_item_setting"];
    settingViewController.tabBarItem.selectedImage = [UIImage imageNamed:@"tab_item_setting_selected"];
    settingViewController.navigationItem.title = NSLocalizedString(@"navigation-title-setting-list", nil);
    settingViewController.needShowTabbar = YES;
    
    UIViewController *tabViewController = [self wrapWithDefaultTabBarController:@[
        [self wrapWithDefaultNavigationController:timeLineViewController],
        [self wrapWithDefaultNavigationController:messageViewController],
        [self wrapWithDefaultNavigationController:exploreViewController],
        [self wrapWithDefaultNavigationController:settingViewController]
        ]];
    return tabViewController;
}

+ (WTRBaseViewController *)assembleTimelineView {
    WTRBaseViewController *viewController = [[UIStoryboard mainStoryboard] instantiateViewControllerWithIdentifier:TimeLineViewController];
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
