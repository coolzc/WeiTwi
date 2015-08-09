//
//  BSAssemblingFactory.m
//  BuddhaSaid
//
//  Created by zhangcheng on 5/23/15.
//  Copyright (c) 2015 XYZ. All rights reserved.
//

#import "WTRAssemblingFactory.h"
#import "UIStory+BuddhaSaid.h"

static NSString* const HomeViewControllerIndentifier = @"HomeViewController";
static NSString* const BSWelcomeViewControllerIndentifier = @"WTRWelcomeViewController";

@implementation WTRAssemblingFactory

+ (UIViewController *)assembleHomeViewController {
    return [[UIStoryboard mainStoryboard] instantiateViewControllerWithIdentifier:HomeViewControllerIndentifier];
}

+ (UIViewController *)assembleWelcomeViewController {
    return [[UIStoryboard mainStoryboard] instantiateViewControllerWithIdentifier:BSWelcomeViewControllerIndentifier];
  
}

@end
