//
//  HomeViewController.h
//  BuddhaSaid
//
//  Created by zhangcheng on 6/8/15.
//  Copyright (c) 2015 XYZ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WTRMyView.h"
#import "WTRBaseViewController.h"
#import "WTRNavigationPresenter.h"
#import "WTRWeiboTimeLinePresenter.h"
#import "WTRTwitterTimelinePresenter.h"

@interface WTRTimeLineViewController : WTRBaseViewController

@property(nonatomic, strong) WTRMyView *myView;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *loginStatusLabel;
@property (weak, nonatomic) IBOutlet UILabel *timelineStatusLabel;

@property (nonatomic, strong) WTRNavigationPresenter *navigationPresenter;
@property (nonatomic, strong) WTRWeiboTimeLinePresenter *weiboTimelineListPresenter;
@property (nonatomic, strong) WTRTwitterTimelinePresenter *twitterTimelinePresenter;

@end
