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

//twitter
static NSString *const TimelineCellReuseIdentifier = @"TimelineCellReusedId";

typedef void (^accountChooserBlock_t)(ACAccount *account, NSString *errorMessage); // don't bother with NSError for that
@interface WTRTimeLineViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSArray* twitterFeed;
@property (nonatomic, strong) NSArray* weiboFeed;
@property (nonatomic, strong) NSArray* tableSoucreFeed;
@property (nonatomic, strong) STTwitterAPI *twitter;
@property (nonatomic, strong) NSArray *iOSAccounts;
@property (nonatomic, strong) accountChooserBlock_t accountChooserBlock;

@property (nonatomic, strong) UIView *circleView;

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
    return self.tableSoucreFeed.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WTRTimelineCell *cell = [tableView dequeueReusableCellWithIdentifier:TimelineCellReuseIdentifier forIndexPath:indexPath];

    if ([self.tableSoucreFeed count]) {
        NSDictionary *timelineContent = self.tableSoucreFeed[indexPath.row];
        [cell updateCellContent:timelineContent];
    }
    
    return cell;
}

#pragma mark - WTRTwitterTimelineDisplayInterface

- (void)displayTwtitterTimeline:(NSArray *)timeline {
    self.twitterFeed = timeline;
}

- (void)displayWeiboTimeline:(NSArray *)timeline {
    self.weiboFeed = timeline;
    self.tableSoucreFeed = self.weiboFeed;
    [self.tableView reloadData];
}

#pragma mark - Action

- (IBAction)loginWeiboButtonTouchUpInside:(id)sender {
    if (self.weiboTwitterSwitch.on) {
        [self.weiboTimelineListPresenter loginWeibo];
    } else {
        
    }
}

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
    self.twitterFeed = [NSArray new];
    self.weiboFeed = [NSArray new];
    self.tableSoucreFeed = [NSArray new];
}

@end
