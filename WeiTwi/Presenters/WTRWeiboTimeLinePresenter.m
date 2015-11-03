//
//  WTRTimeLineListPresenter.m
//  WeiTwi
//
//  Created by zhangcheng on 10/20/15.
//  Copyright © 2015 XYZ. All rights reserved.
//

#import "WTRWeiboTimeLinePresenter.h"
#import "WTRWireframe.h"
#import "WTRWeiboUserInfo.h"
#import "WTRWeiboUser+Utility.h"
#import "WTRWeiboStatusInfo.h"
#import "WTRWeiboStatus+Utility.h"
#import "WTRWeiboGeo+Utility.h"
#import "WTRWeiboGeoInfo.h"

@interface WTRWeiboTimeLinePresenter ()

@property (nonatomic, assign) BOOL needFetchRemoteData;
@property (nonatomic, strong) NSArray *statusInfo;
@property (nonatomic, strong) NSArray *postUserNameInfo;
@property (nonatomic, strong) NSArray *contentTextInfo;
@property (nonatomic, strong) NSArray *postTimeInfo;
@property (nonatomic, strong) NSArray *originSourceInfo;
@property (nonatomic, strong) NSArray *praiseCountInfo;
@property (nonatomic, strong) NSArray *repostCountInfo;
@property (nonatomic, strong) NSArray *commentCountInfo;

@end

@implementation WTRWeiboTimeLinePresenter

- (void)viewDidLoad:(UIViewController *)viewController {
    [super viewDidLoad:viewController];
    self.postUserNameInfo = [NSArray new];
    self.contentTextInfo = [NSArray new];
    self.postTimeInfo = [NSArray new];
    self.originSourceInfo = [NSArray new];
    self.praiseCountInfo = [NSArray new];
    self.repostCountInfo = [NSArray new];
    self.commentCountInfo = [NSArray new];
    self.needFetchRemoteData = YES;
}

- (void)view:(UIViewController *)viewController willAppear:(BOOL)animated {
    [super view:viewController willDisappear:animated];
    if (self.needFetchRemoteData) {
        //TODO
        if (0 < [self.postUserNameInfo count]) {
            [self.weiboTimelineDisplay displayWeiboTimelineContentText:self.contentTextInfo PostUserName:self.postUserNameInfo postTime:self.postTimeInfo originSource:self.originSourceInfo praiseCount:self.praiseCountInfo repostCount:self.repostCountInfo commentCount:self.commentCountInfo];
        } else {
            [self.progressView beginProgress];
        }
        self.needFetchRemoteData = NO;
        [self fetchTimelineInfoFromRemote];
    }
}

- (void)viewDetailOfTimelineWeibo {
//    [WTRWireframe moveToNextPageOfViewController:self.mainViewController];
}

- (void)viewGroupDeckListDetail {
    [WTRWireframe moveToDeckViewController:self.mainViewController Messenger:[WTRPageMessenger messenger]];
}

#pragma mark - WTRWeiboApiServiceDelegate

- (void)weiboServiceDidFinishRequestWithResponse:(id)responseObject {
    [self.progressView updateProgress:1.f message:NSLocalizedString(@"init-progress-text-end", nil)];
    [self.progressView endProgress];
    self.statusInfo = responseObject;
    [self handleTimelineResponseData:responseObject];
}

#pragma mark - Private Methods

- (void)fetchTimelineInfoFromRemote {
    WTRWeiboApiService *weiboApiservice = [WTRWeiboApiService weiboApiServiceWithDeleate:self];
    [weiboApiservice sendRequest:WTRWeiboRequestHomeTimeline];
}

- (void)handleTimelineResponseData:(id)data {
    NSLog(@"");
}

@end
