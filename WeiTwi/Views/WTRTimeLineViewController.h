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
#import "WTRWeiboTimeLinePresenter.h"

@interface WTRTimeLineViewController : WTRBaseViewController <WTRWeiboTimelineDisplayInterface>

@property(nonatomic, strong) WTRMyView *myView;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) WTRWeiboTimeLinePresenter *weiboTimelineListPresenter;

@end
