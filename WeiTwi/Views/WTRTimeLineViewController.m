//
//  HomeViewController.m
//  BuddhaSaid
//
//  Created by zhangcheng on 6/8/15.
//  Copyright (c) 2015 XYZ. All rights reserved.
//


#import "WTRTimeLineViewController.h"
#import "WTRTwitterCell.h"
#import "STTwitter.h"
#import "WTRWireframe.h"
#import "WeiboSDK.h"
#import "WTRPageMessenger.h"
#import "MMDrawerBarButtonItem.h"
//twitter
static NSString *const TwitterCellReuseIdentifier = @"TwitterCellReusedId";
static NSString *const ConsumerKey = @"C3SleTImiuZn5OfoDieHyoonJ";
static NSString *const ConsumerSecret = @"oqXgij1sz9ejPaSZ53KFfj92X9lwQsQvQLfPNUnm3Rd2bdcDaP";
//weibo
static NSString *const WeiboAppKey = @"1425082483";
static NSString *const WeiboAppSecret = @"2d3f9fcf083316cc12066edae8ffc408";

typedef void (^accountChooserBlock_t)(ACAccount *account, NSString *errorMessage); // don't bother with NSError for that
@interface WTRTimeLineViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray* twitterFeed;
@property (nonatomic, strong) NSMutableArray* weiboFeed;
@property (nonatomic, strong) NSMutableArray* tableSoucreFeed;
@property (nonatomic, strong) STTwitterAPI *twitter;
@property (nonatomic, strong) NSArray *iOSAccounts;
@property (nonatomic, strong) accountChooserBlock_t accountChooserBlock;

@property (nonatomic, strong) UIView *circleView;

@end

@implementation WTRTimeLineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureView];
}

- (NSArray *)presenters {
   return @[self.navigationPresenter, self.timelineListPresenter];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tableSoucreFeed.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WTRTwitterCell *cell = [tableView dequeueReusableCellWithIdentifier:TwitterCellReuseIdentifier forIndexPath:indexPath];
    if(0 == indexPath.row) {
        [cell updateCellContent:@"first cell"];
    }

    if (self.weiboFeed) {
        [cell updateCellContent:@""];
    } else {
        NSDictionary *t = self.tableSoucreFeed[indexPath.row];
        [cell updateCellContent:t[@"text"]];
    }
    
    return cell;
}

#pragma mark - Action

- (IBAction)loginWeiboButtonTouchUpInside:(id)sender {
    [self.timelineListPresenter loginWeibo];
}

- (IBAction)timelineButtonTouchUpInside:(id)sender {
    [self.timelineListPresenter viewDetailOfTimelineWeibo];
}

#pragma mark - Private Methods

- (void)configureView {

}

@end
