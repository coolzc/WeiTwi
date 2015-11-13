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

@property (nonatomic, strong) NSArray *weiboStatuses;
@property (nonatomic, strong) NSArray *cellsHeights;
@property (nonatomic, strong) NSArray *statusTextHeights;
@property (nonatomic, strong) NSArray *reTweetTextHeights;
@property (nonatomic, strong) NSArray *picturesViewConfigures;

@property (nonatomic, strong) UIRefreshControl *refreshControl;

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
    NSNumber *cellHeight = self.cellsHeights[indexPath.row];
    NSNumber *statusTextHeight= self.statusTextHeights[indexPath.row];
    NSNumber *reTweetTextHeight = self.reTweetTextHeights[indexPath.row];
    NSArray *picturesViewConfigures = self.picturesViewConfigures[indexPath.row];
    [cell updateCellHeightConstraintValues:cellHeight.floatValue
                     statusTextHeightValue:statusTextHeight.floatValue
                    reTweetTextHeightValue:reTweetTextHeight.floatValue
             picturesViewConstraintsValues:picturesViewConfigures];
    [cell updateCellStatuses:self.weiboStatuses[indexPath.row]];
    //before the cell returnning ,caculate constraints in this cell first
    [cell setNeedsUpdateConstraints];
    [cell updateConstraintsIfNeeded];

    return cell;
}

#pragma mark - UITableViewDelegate

/** use this funciton will cause the cell updateCellHeightConstraintValues: function to be hang up
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"***heightForRowAtIndexPath***");
    NSNumber *heightNumber = self.cellsHeights[indexPath.row];
    return heightNumber.floatValue;
}
**/

#pragma mark - WTRTwitterTimelineDisplayInterface

- (void)displayWeiboTimelineStatuses:(NSArray *)statuses withCellConfigure:(NSArray *)cellHeights statusTextHeight:(NSArray *)statusTextHeights reTweetTextHeight:(NSArray *)reTweetTextHeights pictureViewConfigure:(NSArray *)pictureViewConfigures {
    self.weiboStatuses = statuses;
    self.cellsHeights = cellHeights;
    self.statusTextHeights = statusTextHeights;
    self.reTweetTextHeights = reTweetTextHeights;
    self.picturesViewConfigures = pictureViewConfigures;
    [self.tableView reloadData];
}

#pragma mark - Action


#pragma mark - Private Methods

- (void)configureView {
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"WTRTimelineCell" bundle:nil] forCellReuseIdentifier:TimelineCellReuseIdentifier];
    
    self.tableView.estimatedRowHeight = 180;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    self.refreshControl = [UIRefreshControl new];
    [self.refreshControl addTarget:self action:@selector(handleRefresh) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:self.refreshControl];
}

- (void)initProperties {
    self.weiboStatuses = self.weiboStatuses ?: @[];
}

- (void)handleRefresh {
    [self.weiboTimelineListPresenter reloadWeiboTimelineData];
    [self.refreshControl endRefreshing];
}

@end
