//
//  WTRTableViewFooterView.m
//  WeiTwi
//
//  Created by zhangcheng on 11/19/15.
//  Copyright © 2015 XYZ. All rights reserved.
//

#import "WTRTableViewFooterView.h"

@implementation WTRTableViewFooterView

- (void)awakeFromNib {
    self.frame = CGRectMake(0, 0, 320, 300);
}

- (void)startRefreshing {
    [self.activityIndicator startAnimating];
}

-(void)stopRefreshing {
    [self.activityIndicator stopAnimating];
}

@end
