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
#import "WTRConfig.h"
#import "WTRStatusPhotosCollectionViewCell.h"
#import "NSString+WTRUtility.h"
#import "UINib+WeiTwi.h"
#import "NSDictionary+WTRUtility.h"

static NSString *const TimelineCellReuseIdentifier = @"TimelineCellReusedId";

static CGFloat const CellSizeFor3_5inchLenth = 125.f;
static CGFloat const CellSizeFor5_5inchLenth = 125.f;
static CGFloat const CollectionViewLayoutMinimumInteritemSpace = 4.f;
static CGFloat const CollectionViewLayoutMinimumLineSpace = 4.f;

@interface WTRTimeLineViewController () <UITableViewDataSource, UITableViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) NSMutableArray *weiboStatuses;

@property (nonatomic, strong) UIRefreshControl *refreshControl;
@property (nonatomic, strong) UIView *tableViewfooterView;

@property (nonatomic, assign) BOOL refreshWeiboFailure;
@property (nonatomic, strong) NSArray *photoCellUrls;
@property (nonatomic, strong) NSMutableDictionary *collectionMap;

@end

@implementation WTRTimeLineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initProperties];
    [self configureView];
}

- (NSArray *)presenters {
   return @[self.weiboTimelineListPresenter];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.weiboStatuses count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WTRTimelineCell *cell = [tableView dequeueReusableCellWithIdentifier:TimelineCellReuseIdentifier forIndexPath:indexPath];
    NSArray *photoUrls = @[];
    WTRWeiboStatusInfo *statusInfo = self.weiboStatuses[indexPath.row];
    if ([statusInfo.thumbnailPic isNotBlank]) {
        photoUrls = statusInfo.picUrls;
    } else if(statusInfo.retweetedStatus.thumbnailPic){
        photoUrls = statusInfo.retweetedStatus.picUrls;
    } else {
        photoUrls = @[];
    }

    NSString *collectionAddress = [NSString stringWithFormat:@"%p",cell.photosCollectionView];
    [self.collectionMap setObject:photoUrls forKey:collectionAddress];
    //reload collection when photos exist
    if (0 < [photoUrls count]) {
        [(WTRTimelineCell*)cell displayPhotosCollectionView];
        [(WTRTimelineCell*)cell photosCollectionViewDelegate:self];
    } else {
        [(WTRTimelineCell*)cell removePhotosCollectionView];
    }
    [cell updateCellStatuses:self.weiboStatuses[indexPath.row]];

    return cell;
}

#pragma mark - UITableViewDelegate

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSString *collectionKey = [NSString stringWithFormat:@"%p", collectionView];
    return [self.collectionMap[collectionKey] count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    WTRStatusPhotosCollectionViewCell *photoCell = [collectionView dequeueReusableCellWithReuseIdentifier:StatusPhotoCellReuseIdentifier forIndexPath:indexPath];
    
    // prepare photos displayed in each collection of the cell
    NSString *collectionKey = [NSString stringWithFormat:@"%p", collectionView];
    NSArray *photoUrls = self.collectionMap[collectionKey];
    [photoCell updateWithPhoto:photoUrls[indexPath.row]];
    
    return photoCell;
}

#pragma mark - UICollectionViewLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGSize cellSizeFor5_5inch = CGSizeMake(CellSizeFor5_5inchLenth, CellSizeFor5_5inchLenth);
    CGSize cellSizeFor3_5inch = CGSizeMake(CellSizeFor3_5inchLenth, CellSizeFor3_5inchLenth);
    return [UIScreen is3_5InchScreen] ? cellSizeFor3_5inch : cellSizeFor5_5inch;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return [UIScreen is3_5InchScreen] ? CollectionViewLayoutMinimumInteritemSpace : 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return [UIScreen is3_5InchScreen] ? CollectionViewLayoutMinimumLineSpace : 0;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
}

#pragma mark - WTRTwitterTimelineDisplayInterface

- (void)displayWeiboTimelineStatuses:(NSArray *)statuses refreshDisplayType:(WTRWeiboRefreshDisplayType)refreshDisplayType {
    
    if (0 == statuses.count) {
        self.refreshWeiboFailure = YES;
        return;
    } else {
        self.refreshWeiboFailure = NO;
    }
    switch (refreshDisplayType) {
    case WTRWeiboTimelineViewRefresh:
    case WTRWeiboTimelineViewBottomRefresh: {
        [self.weiboStatuses addObjectsFromArray:statuses];
        if (refreshDisplayType == WTRWeiboTimelineViewRefresh) {
            [self.tableView reloadData];
        }
    }
        break;
    case WTRWeiboTimelineViewTopRefresh: {
        [statuses enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [self.weiboStatuses insertObject:obj atIndex:0];
        }];
    }
        break;
    default:
        break;
    }
}

#pragma mark - Action


#pragma mark - Private Methods

- (void)configureView {
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibForTimelineCell] forCellReuseIdentifier:TimelineCellReuseIdentifier];
    
    self.tableView.contentInset = UIEdgeInsetsMake(0 - 44 - 20, 0, 0, 0);
    /*
    * header view refresh
    */
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
    
    /*
    * footer view
    */
    MJRefreshAutoGifFooter *footer = [MJRefreshAutoGifFooter footerWithRefreshingTarget:self refreshingAction:@selector(toggleFooterToloadMoreData)];
    [footer setImages:imageArr forState:MJRefreshStateRefreshing];
    // 设置尾部
    self.tableView.mj_footer = footer;
    
    //cell layout
    self.tableView.estimatedRowHeight = 180;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
}

- (void)initProperties {
    self.weiboStatuses = [NSMutableArray arrayWithCapacity:WeiboStatusesDisplayedNumbers];
    self.refreshWeiboFailure = NO;
    self.photoCellUrls = @[];
    self.collectionMap = [NSMutableDictionary dictionaryWithDictionary:@{}];
}

- (void)toggleHeaderToloadMoreData {
    [self.weiboTimelineListPresenter reloadNewerWeiboTimelineDataSince:[self.weiboStatuses firstObject]];
    if (self.refreshWeiboFailure) {
        [self.tableView.mj_header endRefreshing];
        return;
    }
    [self.tableView.mj_header endRefreshing];
    [self.tableView reloadData];
}

- (void)toggleFooterToloadMoreData {
    [self.weiboTimelineListPresenter reloadOlderWeiboTimelineDataBefore:[self.weiboStatuses lastObject]];
    if (self.refreshWeiboFailure) {
        [self.tableView.mj_footer endRefreshing];
        return;
    }
    [self.tableView.mj_footer endRefreshing];
    [self.tableView reloadData];
}

@end
