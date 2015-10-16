//
//  WTRBasePresenter.m
//  WeiTwi
//
//  Created by zhangcheng on 10/10/15.
//  Copyright © 2015 XYZ. All rights reserved.
//

#import "WTRBasePresenter.h"

@implementation WTRBasePresenter

- (void)viewDidLoad:(UIViewController *)viewController {}

-(void)view:(UIViewController *)viewController willAppear:(BOOL)animated {}

- (void)view:(UIViewController *)viewController didAppear:(BOOL)animated {}

- (void)view:(UIViewController *)viewController willDisappear:(BOOL)animated {}

- (void)view:(UIViewController *)viewController didDisappear:(BOOL)animated {}

- (id)getParameterNamed:(NSString *)parameterName {
    return [self.mainViewController.params valueForKey:parameterName];
}

@end
