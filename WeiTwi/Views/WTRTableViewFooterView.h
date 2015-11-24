//
//  WTRTableViewFooterView.h
//  WeiTwi
//
//  Created by zhangcheng on 11/19/15.
//  Copyright © 2015 XYZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WTRTableViewFooterView : UIView

@property (weak, nonatomic) IBOutlet UILabel *refreshTextLabel;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

- (void)startRefreshing;
- (void)stopRefreshing;

@end
