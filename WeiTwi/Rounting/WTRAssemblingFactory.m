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
#import "WTRTransitionDelegate.h"

static WTRTransitionDelegate *CurrentTransitionDelegate = nil;

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
    WTRBaseViewController *messageViewController = [self assembleMessageView];
    WTRBaseViewController *exploreViewController = [self assembleExploreView];
    WTRBaseViewController *settingViewController = [self assembleSettingView];
    
    UINavigationController *timelineNav = [self wrapWithDefaultNavigationController:timeLineViewController];
    CurrentTransitionDelegate = [WTRTransitionDelegate delegateForPresentFromTop:YES];
    timelineNav.navigationController.delegate = CurrentTransitionDelegate;
    
    UINavigationController *messageNav = [self wrapWithDefaultNavigationController:messageViewController];
    UINavigationController *exploreNav = [self wrapWithDefaultNavigationController:exploreViewController];
    UINavigationController *settingNav = [self wrapWithDefaultNavigationController:settingViewController];
    UIViewController *tabViewController = [self wrapWithDefaultTabBarController:@[
                                                                                  timelineNav,
                                                                                  messageNav,
                                                                                  exploreNav,
                                                                                  settingNav
                                                                                  ]];
    
    return tabViewController;
}

+ (WTRBaseViewController *)assembleTimelineView {
    WTRTimeLineViewController *viewController = [[UIStoryboard mainStoryboard] instantiateViewControllerWithIdentifier:TimeLineViewController];
    viewController.navigationPresenter = [self buildNavigationPresenter];
    viewController.timelineListPresenter = [self buildTimelinePresenter];
    
    viewController.title = NSLocalizedString(@"tab-bar-item-timeline", nil);
    viewController.tabBarItem.image = [UIImage imageNamed:@"tab_item_timeline"];
    viewController.tabBarItem.selectedImage = [UIImage imageNamed:@"tab_item_timeline_selected"];
    viewController.navigationItem.title = NSLocalizedString(@"navigation-title-timeline-list", nil);
    viewController.needShowTabbar = YES;
    return viewController;
}

+ (WTRBaseViewController *)assembleMessageView {
    WTRMessageViewController *viewController = [[UIStoryboard mainStoryboard] instantiateViewControllerWithIdentifier:MessageViewControllerIndentifier];
    viewController.title = NSLocalizedString(@"tab-bar-item-message", nil);
    viewController.tabBarItem.image = [UIImage imageNamed:@"tab_item_message"];
    viewController.tabBarItem.selectedImage = [UIImage imageNamed:@"tab_item_message_selected"];
    viewController.navigationItem.title = NSLocalizedString(@"navigation-title-message-list", nil);
    viewController.needShowTabbar = YES;
    return viewController;
}

+ (WTRBaseViewController *)assembleExploreView {
    WTRExploreViewController *viewController = [[UIStoryboard mainStoryboard] instantiateViewControllerWithIdentifier:ExploreViewControllerIndentifier];
    viewController.title = NSLocalizedString(@"tab-bar-item-explore", nil);
    viewController.tabBarItem.image = [UIImage imageNamed:@"tab_item_explore"];
    viewController.tabBarItem.selectedImage = [UIImage imageNamed:@"tab_item_explore_selected"];
    viewController.navigationItem.title = NSLocalizedString(@"navigation-title-explore-list", nil);
    viewController.needShowTabbar = YES;
    return viewController;
}

+ (WTRBaseViewController *)assembleSettingView {
    WTRSettingViewController *viewController = [[UIStoryboard mainStoryboard] instantiateViewControllerWithIdentifier:SettingViewControllerIndentifier];
    viewController.title = NSLocalizedString(@"tab-bar-item-setting", nil);
    viewController.tabBarItem.image = [UIImage imageNamed:@"tab_item_setting"];
    viewController.tabBarItem.selectedImage = [UIImage imageNamed:@"tab_item_setting_selected"];
    viewController.navigationItem.title = NSLocalizedString(@"navigation-title-setting-list", nil);
    viewController.needShowTabbar = YES;
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

+ (WTRTimeLineListPresenter *)buildTimelinePresenter {
    WTRTimeLineListPresenter *timelinePresenter = [WTRTimeLineListPresenter new];
    return timelinePresenter;
}


@end
