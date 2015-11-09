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
#import "WTRWeiboApiService.h"
#import "WTRConfig.h"

@interface WTRWeiboTimeLinePresenter () <WTRWeiboApiServiceDelegate>

@property (nonatomic, assign) BOOL needFetchRemoteData;
@property (nonatomic, strong) NSArray *statusesInfo;

@end

@implementation WTRWeiboTimeLinePresenter

- (void)viewDidLoad:(UIViewController *)viewController {
    [super viewDidLoad:viewController];
    self.statusesInfo = self.statusesInfo ?: @[];
    self.needFetchRemoteData = YES;
}

- (void)view:(UIViewController *)viewController willAppear:(BOOL)animated {
    [super view:viewController willDisappear:animated];
    if (self.needFetchRemoteData) {
        //TODO
        if (0 < [self.statusesInfo count]) {
            [self.weiboTimelineDisplay displayWeiboTimelineStatuses:self.statusesInfo];
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

- (void)weiboServiceDidFinishRequest:(WTRWeiboRequest *)request withResponse:(WTRWeiboResponse *)response {
    [self.progressView updateProgress:1.f message:NSLocalizedString(@"init-progress-text-end", nil)];
    [self.progressView endProgress];
    self.statusesInfo = response.responseObject;
    [self.weiboTimelineDisplay displayWeiboTimelineStatuses:self.statusesInfo];
}

#pragma mark - Private Methods

- (void)fetchTimelineInfoFromRemote {
    WTRWeiboApiService *weiboApiservice = [WTRWeiboApiService weiboApiServiceWithDeleate:self];
    WTRWeiboRequest *apiRequest = [WTRWeiboRequest requestForHometimelineCount:25];
    [weiboApiservice sendRequest:apiRequest];
}

@end