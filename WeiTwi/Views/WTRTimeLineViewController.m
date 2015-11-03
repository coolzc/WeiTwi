//
//  HomeViewController.m
//  BuddhaSaid
//
//  Created by zhangcheng on 6/8/15.
//  Copyright (c) 2015 XYZ. All rights reserved.
//


#import "WTRTimeLineViewController.h"
#import "WTRTimelineCell.h"
#import "STTwitter.h"
#import "WTRWireframe.h"
#import "WeiboSDK.h"
#import "WTRPageMessenger.h"
#import "MMDrawerBarButtonItem.h"

static NSString *const TimelineCellReuseIdentifier = @"TimelineCellReusedId";
static NSInteger const TimelineDisplayCount = 25;

@interface WTRTimeLineViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSArray* postTime;
@property (nonatomic, strong) NSArray* posterName;
@property (nonatomic, strong) NSArray* contentText;
@property (nonatomic, strong) NSArray* originSource;
@property (nonatomic, strong) NSArray* praiseCount;
@property (nonatomic, strong) NSArray* repostCount;
@property (nonatomic, strong) NSArray* commentCount;

@end

@implementation WTRTimeLineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureView];
    [self configureProperties];
}

- (NSArray *)presenters {
   return @[self.navigationPresenter, self.weiboTimelineListPresenter, self.twitterTimelinePresenter];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return TimelineDisplayCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WTRTimelineCell *cell = [tableView dequeueReusableCellWithIdentifier:TimelineCellReuseIdentifier forIndexPath:indexPath];
    
    return cell;
}

#pragma mark - WTRTwitterTimelineDisplayInterface

- (void)displayTwtitterTimeline:(NSArray *)timeline {
}

- (void)displayWeiboTimelineContentText:(NSArray *)contentTextInfo PostUserName:(NSArray *)nameInfo postTime:(NSArray *)timeInfo originSource:(NSArray *)originSourceInfo praiseCount:(NSArray *)praiseCountInfo repostCount:(NSArray *)repostCountInfo commentCount:(NSArray *)commentCountInfo {
}

#pragma mark - Action

- (IBAction)timelineButtonTouchUpInside:(id)sender {
    [self.weiboTimelineListPresenter viewDetailOfTimelineWeibo];
}
- (IBAction)weiboTwitterSwitchValueChanged:(id)sender {
}

#pragma mark - Private Methods

- (void)configureView {
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"WTRTimelineCell" bundle:nil] forCellReuseIdentifier:TimelineCellReuseIdentifier];
}

- (void)configureProperties {
    self.postTime = [NSArray new];
    self.posterName = [NSArray new];
    self.contentText = [NSArray new];
    self.originSource = [NSArray new];
    self.praiseCount = [NSArray new];
    self.repostCount = [NSArray new];
    self.commentCount = [NSArray new];
}

@end
