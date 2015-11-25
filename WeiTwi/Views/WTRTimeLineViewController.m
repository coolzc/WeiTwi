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
#import "NSBundle+WeiTwi.h"
#import "UIScreen+WTRUtility.h"
#import "MJRefresh.h"

static NSString *const TimelineCellReuseIdentifier = @"TimelineCellReusedId";

@interface WTRTimeLineViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *weiboStatuses;
@property (nonatomic, strong) NSMutableArray *cellsHeights;
@property (nonatomic, strong) NSMutableArray *statusTextHeights;
@property (nonatomic, strong) NSMutableArray *reTweetTextHeights;
@property (nonatomic, strong) NSMutableArray *picturesViewConfigures;
@property (nonatomic, assign) BOOL cellsDataShouldUpdate;

@property (nonatomic, strong) UIRefreshControl *refreshControl;
@property (nonatomic, strong) UIView *tableViewfooterView;

@end

@implementation WTRTimeLineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initProperties];
    [self configureView];
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
    if (([self.weiboStatuses count] - 1) == indexPath.row) {
        self.cellsDataShouldUpdate = YES;
    } else {
        self.cellsDataShouldUpdate = NO;
    }
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

//- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
//    if ([indexPath isEqual:[NSIndexPath indexPathForRow:[self tableView:self.tableView numberOfRowsInSection:0]-1 inSection:0]]) {
//        self.tableView.tableFooterView.hidden = NO;
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [self.weiboTimelineListPresenter reloadWeiboTimelineData];
//        });
////        [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
//    } else {
//        self.tableView.tableFooterView.hidden = YES;
//    }
//}

#pragma mark - UIScrollViewDelegate

//- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
//    if (self.cellsDataShouldUpdate) {
//        self.tableView.tableFooterView.hidden = NO;
//        [self.tableViewfooterView startRefreshing];
//    } else {
//        self.tableView.tableFooterView.hidden = YES;
//        [self.tableViewfooterView stopRefreshing];
//    }
//}

#pragma mark - WTRTwitterTimelineDisplayInterface

- (void)displayWeiboTimelineStatuses:(NSArray *)statuses withCellConfigure:(NSArray *)cellHeights statusTextHeight:(NSArray *)statusTextHeights reTweetTextHeight:(NSArray *)reTweetTextHeights pictureViewConfigure:(NSArray *)pictureViewConfigures refreshDisplayType:(WTRWeiboRefreshDisplayType)refreshDisplayType {
        switch (refreshDisplayType) {
        case WTRWeiboTimelineViewRefresh:
        case WTRWeiboTimelineViewBottomRefresh: {
            [self.weiboStatuses addObjectsFromArray:statuses];
            [self.cellsHeights addObjectsFromArray:cellHeights];
            [self.statusTextHeights addObjectsFromArray:statusTextHeights];
            [self.reTweetTextHeights addObjectsFromArray:reTweetTextHeights];
            [self.picturesViewConfigures addObjectsFromArray:pictureViewConfigures];
        }
            break;
        case WTRWeiboTimelineViewTopRefresh: {
            [self.weiboStatuses insertObject:statuses atIndex:0];
            [self.cellsHeights insertObject:cellHeights atIndex:0];
            [self.statusTextHeights insertObject:statusTextHeights atIndex:0];
            [self.reTweetTextHeights insertObject:reTweetTextHeights atIndex:0];
            [self.picturesViewConfigures insertObject:pictureViewConfigures atIndex:0];
        }
            break;
        default:
            break;
    }

    [self.tableView reloadData];
}

#pragma mark - Action


#pragma mark - Private Methods

- (void)configureView {
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"WTRTimelineCell" bundle:nil] forCellReuseIdentifier:TimelineCellReuseIdentifier];
    
    self.tableView.contentInset = UIEdgeInsetsMake(0 - 44 - 20, 0, 0, 0);
    //*******************
    //header view refresh
    //*******************
    NSMutableArray *imageArr = [NSMutableArray arrayWithCapacity:12];
    for (int i = 0; i < 3; i ++ ) {
        NSString *imageName = [@"dropdown_loading_0" stringByAppendingString:[NSNumber numberWithInt:i+1].stringValue];
        UIImage *image = [UIImage imageNamed:imageName];
        [imageArr addObject:image];
    }
    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(toggleHeaderToloadMoreData)];
    // 设置普通状态的动画图片
    [header setImages:imageArr forState:MJRefreshStateIdle];
    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
    [header setImages:imageArr forState:MJRefreshStatePulling];
    // 设置正在刷新状态的动画图片
    [header setImages:imageArr forState:MJRefreshStateRefreshing];
    // 设置header
    self.tableView.mj_header = header;
    
    //*******************
    //footer view
    //*******************
    MJRefreshAutoGifFooter *footer = [MJRefreshAutoGifFooter footerWithRefreshingTarget:self refreshingAction:@selector(toggleFooterToloadMoreData)];
    [footer setImages:imageArr forState:MJRefreshStateRefreshing];
    // 设置尾部
    self.tableView.mj_footer = footer;
    
    //cell layout
    self.tableView.estimatedRowHeight = 180;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
}

- (void)initProperties {
    self.weiboStatuses = [NSMutableArray arrayWithCapacity:25];
    self.cellsHeights = [NSMutableArray arrayWithCapacity:25];
    self.statusTextHeights = [NSMutableArray arrayWithCapacity:25];
    self.reTweetTextHeights = [NSMutableArray arrayWithCapacity:25];
    self.picturesViewConfigures = [NSMutableArray arrayWithCapacity:25];
    self.cellsDataShouldUpdate = NO;
}

- (void)toggleHeaderToloadMoreData {
    [self.weiboTimelineListPresenter reloadNewerWeiboTimelineDataSince:[self.weiboStatuses firstObject]];
    [self.tableView reloadData];
    [self.tableView.mj_header endRefreshing];
}

- (void)toggleFooterToloadMoreData {
    [self.weiboTimelineListPresenter reloadOlderWeiboTimelineDataBefore:[self.weiboStatuses lastObject]];
    [self.tableView reloadData];
    [self.tableView.mj_footer endRefreshing];
}

@end
