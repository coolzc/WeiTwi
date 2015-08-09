//
//  UIStory+BuddhaSaid.m
//  BuddhaSaid
//
//  Created by zhangcheng on 6/8/15.
//  Copyright (c) 2015 XYZ. All rights reserved.
//

#import "UIStory+BuddhaSaid.h"

static NSString * const MainStoryboardName = @"Main";

@implementation UIStoryboard(WeiTwi)

+ (instancetype)mainStoryboard {
    static UIStoryboard *storyboard = nil;
    if (!storyboard) {
        storyboard = [UIStoryboard storyboardWithName:MainStoryboardName bundle:nil];
    }
    return storyboard;
}

@end
