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
#import "WTRWeiboStatus+Utility.h"
#import "WTRWeiboGeo+Utility.h"
#import "WTRWeiboGeoInfo.h"
#import "WTRWeiboApiService.h"
#import "WTRConfig.h"
#import "NSString+WTRUtility.h"
#import "UIScreen+WTRUtility.h"
#import "NSObject+WTRUtility.h"

@interface WTRWeiboTimeLinePresenter () <WTRWeiboApiServiceDelegate>

@property (nonatomic, assign) BOOL needFetchRemoteData;
@property (nonatomic, strong) NSMutableArray *statusesInfo;

@end

@implementation WTRWeiboTimeLinePresenter

- (void)viewDidLoad:(UIViewController *)viewController {
    [super viewDidLoad:viewController];
    self.needFetchRemoteData = YES;
}

- (void)view:(UIViewController *)viewController willAppear:(BOOL)animated {
    [super view:viewController willAppear:animated];
    if (self.needFetchRemoteData) {
        //TODO
        if (0 < [self.statusesInfo count]) {
            [self.weiboTimelineDisplay displayWeiboTimelineStatuses:[self.statusesInfo copy]
                                                 refreshDisplayType:WTRWeiboTimelineViewRefresh
             ];
        } else {
            [self.progressView beginProgress];
        }
        self.needFetchRemoteData = NO;
        [self fetchTimelineInfoFromRemote];
    }
}

#pragma mark Public Methods

- (void)viewDetailOfTimelineWeibo {
//    [WTRWireframe moveToNextPageOfViewController:self.mainViewController];
}

- (void)viewGroupDeckListDetail {
    [WTRWireframe moveToDeckViewController:self.mainViewController Messenger:[WTRPageMessenger messenger]];
}

- (void)reloadWeiboTimelineData {
    [self fetchTimelineInfoFromRemote];
}

- (void)reloadNewerWeiboTimelineDataSince:(WTRWeiboStatusInfo *)status {
    [self fetchNewerTimelineInfoFromRemote:status.idStr];
}

- (void)reloadOlderWeiboTimelineDataBefore:(WTRWeiboStatusInfo *)status {
    [self fetchOlderTimelineInfoFromRemote:status.idStr];
}

#pragma mark - WTRWeiboApiServiceDelegate

- (void)weiboServiceDidFinishRequest:(WTRWeiboRequest *)request withResponse:(WTRWeiboResponse *)response {
    [self.progressView updateProgress:1.f message:NSLocalizedString(@"init-progress-text-end", nil)];
    [self.progressView endProgress];
    self.statusesInfo = [NSMutableArray arrayWithArray:response.responseObject];
    //in case there is no refresh data from remote,then directly return
    if (0 == [response.responseObject count]) {
        return;
    }
    
    WTRWeiboRefreshDisplayType refreshType;
    switch (request.type) {
        case WTRWeiboRequestHomeTimeline:
            refreshType = WTRWeiboTimelineViewRefresh;
            break;
        case WTRWeiboRequestHomeTimelineSince: {
            refreshType = WTRWeiboTimelineViewTopRefresh;
        }
            break;
        case WTRWeiboRequestHomeTimelineBefore: {
            refreshType = WTRWeiboTimelineViewBottomRefresh;
            [self.statusesInfo removeObjectAtIndex:0];
        }
            break;
        default:
            break;
    }
    
    [self.weiboTimelineDisplay displayWeiboTimelineStatuses:[self.statusesInfo copy]
                                         refreshDisplayType:refreshType
     ];
}

#pragma mark - Private Methods

- (void)fetchTimelineInfoFromRemote {
    WTRWeiboApiService *weiboApiservice = [WTRWeiboApiService weiboApiServiceWithDeleate:self];
    WTRWeiboRequest *apiRequest = [WTRWeiboRequest requestForHometimelineCount:WeiboStatusesDisplayedNumbers];
    [weiboApiservice sendRequest:apiRequest];
}

- (void)fetchNewerTimelineInfoFromRemote:(NSString *)sinceId {
    if (!sinceId) {
        return;
    }
    WTRWeiboApiService *weiboApiservice = [WTRWeiboApiService weiboApiServiceWithDeleate:self];
    WTRWeiboRequest *apiRequest = [WTRWeiboRequest requestForHometimelineSince:sinceId refreshCount:WeiboStatusesDisplayedNumbers];
    [weiboApiservice sendRequest:apiRequest];
}


- (void)fetchOlderTimelineInfoFromRemote:(NSString *)beforeId {
    if (!beforeId) {
        return;
    }
    WTRWeiboApiService *weiboApiservice = [WTRWeiboApiService weiboApiServiceWithDeleate:self];
    WTRWeiboRequest *apiRequest = [WTRWeiboRequest requestForHometimelineBefore:beforeId refreshCount:WeiboStatusesDisplayedNumbers];
    [weiboApiservice sendRequest:apiRequest];
}
@end