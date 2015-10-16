//
//  ViewController.m
//  BuddhaSaid
//
//  Created by zhangcheng on 5/23/15.
//  Copyright (c) 2015 XYZ. All rights reserved.
//

#import "WTRWireframe.h"
#import "WTRAssemblingFactory.h"
#import "WTRBaseViewController.h"
#import "WTRTimeLineViewController.h"
#import "WTRSplashScreenViewController.h"
#import "WTRDeckViewController.h"

#import "NSString+WTRUtility.h"
#import "WTRTransitionDelegate.h"

@interface UIViewController (WeiTwi)

+ (NSString *)wireframeKey:(NSString *)name;

@end

@implementation UIViewController (WeiTwi)

+ (NSString *)wireframeKey:(NSString *)name {
    return [[[self class] description] conj:name];
}

@end

static WTRTransitionDelegate *CurrentTransitionDelegate = nil;

@implementation WTRWireframe

+ (UIViewController *)entryScreen {
    return [self loadLaunchScreen];
}

+ (void)moveToNextPageOfViewController:(UIViewController *)viewController {
    [self moveToNextPageOfViewController:viewController messenger:[WTRPageMessenger messenger]];
}

+ (void)moveToNextPageOfViewController:(UIViewController *)viewController messenger:(WTRPageMessenger *)messenger {
    // find the corresponding selector
    SEL selector = [self selectorOfClass:[viewController class] messenageName:[messenger name]];
    
    // cast to IMP to avoid compiler's warning
    IMP imp = [[self class] methodForSelector:selector];
    id (*func)(id, SEL) = (id (*)(id, SEL))imp;
    
    //to make sure the initial controller of tabBarViewController load successfully
    UIViewController *targetViewController = func([self class],selector);
    if ([targetViewController isKindOfClass:[WTRBaseViewController class]]) {
        WTRBaseViewController *targetWTRViewController = (WTRBaseViewController *)targetViewController;
        targetWTRViewController.params = [messenger params];
        dispatch_async(dispatch_get_main_queue(), ^{
            [viewController presentViewController:targetWTRViewController animated:YES completion:nil];
        });
    } else {
        dispatch_async(dispatch_get_main_queue(), ^{
            [viewController presentViewController:targetViewController animated:YES completion:nil];
        });
    }
}

+ (void)moveToPreviousPageOfViewController:(UIViewController *)viewController {
    //navigation pop dismiss action code need to be written here
    // so we can add logic code here to check whether to use 'pop' or 'dismiss'
    dispatch_async(dispatch_get_main_queue(), ^{
        if (!viewController.navigationController) {
            [viewController dismissViewControllerAnimated:YES completion:nil];
        } else {
            [viewController.navigationController popViewControllerAnimated:YES];
        }
    });
}

//+ (void)dismissToPreviousPageOfViewController:(UIViewController *)viewController {
//    [viewController dismissViewControllerAnimated:YES completion:nil];
//}

#pragma mark - Route Mapping Methods

+ (WTRBaseViewController *)loadLaunchScreen {
    return [WTRAssemblingFactory assembleSplashScreen];
}

+ (UIViewController *)loadHomeScreen {
    return [WTRAssemblingFactory assembleHomeView];
}

+ (WTRBaseViewController *)loadDeckScreen {
    return [WTRAssemblingFactory assembleDeckView];
}

+ (WTRBaseViewController *)loadEmptyScreen {
    return nil;
}


+ (SEL)selectorOfClass:(Class)class messenageName:(NSString *)messengerName {
    static NSDictionary *selectorMap = nil;
    if (!selectorMap) {
        selectorMap = @{
                        [WTRSplashScreenViewController wireframeKey:[WTRPageMessenger defaultName]] : [NSValue valueWithPointer:@selector(loadHomeScreen)],
                        [WTRTimeLineViewController wireframeKey:[WTRPageMessenger deckName]] : [NSValue valueWithPointer:@selector(loadDeckScreen)],
                        [WTRDeckViewController wireframeKey:[WTRPageMessenger homeName]] : [NSValue valueWithPointer:@selector(loadHomeScreen)]
                        };
    }
    NSValue *selectorName = [selectorMap valueForKey:[[class description] conj:messengerName]];
    return selectorName ? [selectorName pointerValue] : @selector(loadEmptyScreen);
}

@end
