//
//  AppDelegate.h
//  WeiTwi
//
//  Created by zhangcheng on 7/2/15.
//  Copyright (c) 2015 XYZ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WTRWeiboSDKDelegate.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) WTRWeiboSDKDelegate *weiboSDKDelegate;


@end

