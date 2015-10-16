//
//  WTRBasePresenter.h
//  WeiTwi
//
//  Created by zhangcheng on 10/10/15.
//  Copyright © 2015 XYZ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WTRBaseViewController.h"

@interface WTRBasePresenter : NSObject

// The current view controller that is presenting user interfaces
// So the presenter can use it to navigate to other view controllers
@property (nonatomic, weak) WTRBaseViewController *mainViewController;

- (void)viewDidLoad:(UIViewController *)viewController;
- (void)view:(UIViewController *)viewController willAppear:(BOOL)animated;
- (void)view:(UIViewController *)viewController didAppear:(BOOL)animated;
- (void)view:(UIViewController *)viewController willDisappear:(BOOL)animated;
- (void)view:(UIViewController *)viewController didDisappear:(BOOL)animated;

- (id)getParameterNamed:(NSString *)parameterName;

@end
