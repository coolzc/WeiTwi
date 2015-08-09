//
//  BSAssemblingFactory.h
//  BuddhaSaid
//
//  Created by zhangcheng on 5/23/15.
//  Copyright (c) 2015 XYZ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface WTRAssemblingFactory : NSObject

+ (UIViewController *)assembleWelcomeViewController;
+ (UIViewController *)assembleHomeViewController;

@end
