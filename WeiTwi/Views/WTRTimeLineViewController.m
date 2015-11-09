//
//  HomeViewController.m
//  BuddhaSaid
//
//  Created by zhangcheng on 6/8/15.
//  Copyright (c) 2015 XYZ. All rights reserved.
//


#import "WTRTimeLineViewController.h"
#import "WTRTimelineCell.h"
#import "WTRWireframe.h"
#import "WTRPageMessenger.h"
#import "MMDrawerBarButtonItem.h"

static NSString *const TimelineCellReuseIdentifier = @"TimelineCellReusedId";

@interface WTRTimeLineViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSArray* weiboStatuses;

@end

@implementation WTRTimeLineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureView];
    [self initProperties];
}

- (NSArray *)presenters {
   return @[self.navigationPresenter, self.weiboTimelineListPresenter, self.twitterTimelinePresenter];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.weiboStatuses count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WTRTimelineCell *cell = [tableView dequeueReusableCellWithIdentifier:TimelineCellReuseIdentifier forIndexPath:indexPath];
    [cell updateCellStatuses:self.weiboStatuses[indexPath.row]];

    [cell setNeedsUpdateConstraints];
    [cell updateConstraintsIfNeeded];

    return cell;
}



#pragma mark - WTRTwitterTimelineDisplayInterface

- (void)displayTwtitterTimeline:(NSArray *)timeline {
}

- (void)displayWeiboTimelineStatuses:(NSArray *)statuses {
    self.weiboStatuses = statuses;
    [self.tableView reloadData];
}

#pragma mark - Action


#pragma mark - Private Methods

- (void)configureView {
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"WTRTimelineCell" bundle:nil] forCellReuseIdentifier:TimelineCellReuseIdentifier];
    
    self.tableView.estimatedRowHeight = 150;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
}

- (void)initProperties {
    self.weiboStatuses = self.weiboStatuses ?: @[];
}

@end
