//
//  HomeViewController.h
//  BuddhaSaid
//
//  Created by zhangcheng on 6/8/15.
//  Copyright (c) 2015 XYZ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WTRMyView.h"

@interface HomeViewController : UIViewController

@property(nonatomic, strong) WTRMyView *myView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *loginStatusLabel;
@property (weak, nonatomic) IBOutlet UILabel *timelineStatusLabel;

@end
