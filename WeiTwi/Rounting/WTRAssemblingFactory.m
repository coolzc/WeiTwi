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
#import "WTRWeiboManagerInteractor.h"
#import "WTRTwitterManagerInteractor.h"
#import "WTRTransitionDelegate.h"
#import "WTRSwipeHorizontalInteractiveTransition.h"

#import "MMDrawerController.h"
#import "MMDrawerVisualState.h"
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
//    WTRBaseViewController *messageViewController = [self assembleMessageView];
//    WTRBaseViewController *exploreViewController = [self assembleExploreView];
//    WTRBaseViewController *settingViewController = [self assembleSettingView];
    
    UINavigationController *timelineNav = [self wrapWithDefaultNavigationController:timeLineViewController];
   
//    UINavigationController *messageNav = [self wrapWithDefaultNavigationController:messageViewController];
//    UINavigationController *exploreNav = [self wrapWithDefaultNavigationController:exploreViewController];
//    UINavigationController *settingNav = [self wrapWithDefaultNavigationController:settingViewController];
//    UIViewController *tabViewController = [self wrapWithDefaultTabBarController:@[
//                                                                                  timelineNav,
//                                                                                  messageNav,
//                                                                                  exploreNav,
//                                                                                  settingNav
//                                                                                  ]];
    //MMDrawerViewController lib suggest that center vc can't support centerVC as tabBarViewController
//    UINavigationController *centerVC = [self wrapWithDefaultNavigationController:tabViewController];
    
    WTRBaseViewController *leftDeckViewController = [self assembleDeckView];
    MMDrawerController *centerViewController = [[MMDrawerController alloc] initWithCenterViewController:timelineNav leftDrawerViewController:leftDeckViewController];
    [centerViewController setDrawerVisualStateBlock:[MMDrawerVisualState parallaxVisualStateBlockWithParallaxFactor:2.5f]];
    [centerViewController setMaximumLeftDrawerWidth:160.0];
    [centerViewController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
    [centerViewController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
    //TODO:not sure to remain this code here
//    centerViewController.modalPresentationStyle = UIModalPresentationCustom;
//    CurrentTransitionDelegate = [WTRTransitionDelegate delegateForPresentFrom:WTRTransitionFromTop viewController:centerViewController];
//    centerViewController.transitioningDelegate = CurrentTransitionDelegate;
//    
    NSLog(@"initial timeline:viewcontrollers in navigationviewcontroller count:%lu",[timelineNav.navigationController.viewControllers count]);

    return centerViewController;
}

+ (WTRBaseViewController *)assembleTimelineView {
    WTRTimeLineViewController *viewController = [[UIStoryboard mainStoryboard] instantiateViewControllerWithIdentifier:TimeLineViewController];
    viewController.navigationPresenter = [self buildNavigationPresenter];
    viewController.weiboTimelineListPresenter = [self buildWeiboTimelinePresenter];
    viewController.twitterTimelinePresenter = [self buildTwitterTimelinePresenter];
    
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
    viewController.deckListPresenter = [self buildDeckListPresenter];
    
    viewController.modalPresentationStyle = UIModalPresentationCustom;
    viewController.transitioningDelegate = [WTRTransitionDelegate delegateForPresentFrom:WTRTransitionFromBottom viewController:viewController];
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

//deck presenter
+ (WTRDeckPresenter *)buildDeckListPresenter {
    WTRDeckPresenter *deckListPresenter = [WTRDeckPresenter new];
    return deckListPresenter;
}

+ (WTRWeiboTimeLinePresenter *)buildWeiboTimelinePresenter {
    WTRWeiboTimeLinePresenter *timelinePresenter = [WTRWeiboTimeLinePresenter new];
    timelinePresenter.weiboInteractor = [WTRWeiboManagerInteractor new];
    timelinePresenter.weiboInteractor.delegate = timelinePresenter;
    
    return timelinePresenter;
}

+ (WTRTwitterTimelinePresenter *)buildTwitterTimelinePresenter {
    WTRTwitterTimelinePresenter *twitterTimelinePresenter = [WTRTwitterTimelinePresenter new];
    twitterTimelinePresenter.twitterInteractor = [WTRTwitterManagerInteractor new];
    twitterTimelinePresenter.twitterInteractor.delegate = twitterTimelinePresenter;
    return twitterTimelinePresenter;
}

@end
