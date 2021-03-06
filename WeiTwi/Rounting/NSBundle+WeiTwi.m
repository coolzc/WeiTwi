//
//  NSBundle.m
//  WeiTwi
//
//  Created by zhangcheng on 10/12/15.
//  Copyright © 2015 XYZ. All rights reserved.
//

#import "NSBundle+WeiTwi.h"

static NSString *const TableViewFooterView = @"WTRTableViewFooterView";

@implementation NSBundle (WeiTwi)

+ (WTRTableViewFooterView *)loadTableViewFooterView {
    return (WTRTableViewFooterView *)[self loadViewByNibName:TableViewFooterView];
}

#pragma mark - Private Methods

+ (UIView *)loadViewByNibName:(NSString *)nibName {
    UIView *view = [[[self mainBundle] loadNibNamed:nibName owner:nil options:nil] lastObject];
    view.translatesAutoresizingMaskIntoConstraints = NO;
    return view;
}

@end
