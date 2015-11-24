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
@property (nonatomic, strong) NSArray *statusesInfo;
//cells constraint configure
@property (nonatomic, assign) CGFloat cellHeight;
@property (nonatomic, strong) NSMutableArray *cellsHeights;
@property (nonatomic, strong) NSMutableArray *statusTextHeights;
@property (nonatomic, strong) NSMutableArray *reTweetTextHeights;
@property (nonatomic, strong) NSMutableArray *picturesViewConfigures;

@end

@implementation WTRWeiboTimeLinePresenter

- (void)viewDidLoad:(UIViewController *)viewController {
    [super viewDidLoad:viewController];
    self.statusesInfo = self.statusesInfo ? : @[];
    self.needFetchRemoteData = YES;
    self.cellHeight = 0.f;
}

- (void)view:(UIViewController *)viewController willAppear:(BOOL)animated {
    [super view:viewController willDisappear:animated];
    if (self.needFetchRemoteData) {
        //TODO
        if (0 < [self.statusesInfo count]) {
            [self.weiboTimelineDisplay displayWeiboTimelineStatuses:self.statusesInfo
                                                  withCellConfigure:[self.cellsHeights copy]
                                                   statusTextHeight:[self.statusTextHeights copy]
                                                  reTweetTextHeight:[self.reTweetTextHeights copy]
                                               pictureViewConfigure:[self.picturesViewConfigures copy]
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
    self.statusesInfo = response.responseObject;
    [self processStatuesDataToFitTimelineCellsConstraints];
    [self.weiboTimelineDisplay displayWeiboTimelineStatuses:self.statusesInfo
                                          withCellConfigure:[self.cellsHeights copy]
                                           statusTextHeight:[self.statusTextHeights copy]
                                          reTweetTextHeight:[self.reTweetTextHeights copy]
                                       pictureViewConfigure:[self.picturesViewConfigures copy]
     ];
}

#pragma mark - Private Methods

- (void)fetchTimelineInfoFromRemote {
    WTRWeiboApiService *weiboApiservice = [WTRWeiboApiService weiboApiServiceWithDeleate:self];
    WTRWeiboRequest *apiRequest = [WTRWeiboRequest requestForHometimelineCount:25];
    [weiboApiservice sendRequest:apiRequest];
}

- (void)fetchNewerTimelineInfoFromRemote:(NSString *)sinceId {
    WTRWeiboApiService *weiboApiservice = [WTRWeiboApiService weiboApiServiceWithDeleate:self];
    WTRWeiboRequest *apiRequest = [WTRWeiboRequest requestForHometimelineSince:sinceId];
    [weiboApiservice sendRequest:apiRequest];
}


- (void)fetchOlderTimelineInfoFromRemote:(NSString *)beforeId {
    WTRWeiboApiService *weiboApiservice = [WTRWeiboApiService weiboApiServiceWithDeleate:self];
    WTRWeiboRequest *apiRequest = [WTRWeiboRequest requestForHometimelineBefore:beforeId];
    [weiboApiservice sendRequest:apiRequest];
}

- (void)processStatuesDataToFitTimelineCellsConstraints {
    NSUInteger statusNum = [self.statusesInfo count];
    self.statusTextHeights = [NSMutableArray arrayWithCapacity:statusNum];
    self.reTweetTextHeights = [NSMutableArray arrayWithCapacity:statusNum];
    self.picturesViewConfigures = [NSMutableArray arrayWithCapacity:statusNum];
    self.cellsHeights = [NSMutableArray arrayWithCapacity:statusNum];
    
    for (WTRWeiboStatusInfo *statusInfo in self.statusesInfo) {
        [self caculateLabelHeightWith:statusInfo.text storedResults:self.statusTextHeights];
        [self caculateLabelHeightWith:statusInfo.retweetedStatus.text storedResults:self.reTweetTextHeights];
        if (statusInfo.retweetedStatus) {
            [self caculateStatusPicturesViewConfigurationWith:statusInfo.retweetedStatus.picUrls stroedResults:self.picturesViewConfigures];
        } else {
            [self caculateStatusPicturesViewConfigurationWith:statusInfo.picUrls stroedResults:self.picturesViewConfigures];
        }
        
        NSNumber *valueNumber = [NSNumber numberWithFloat:self.cellHeight];
        [self.cellsHeights addObject:valueNumber];
        self.cellHeight = 0.f;
    }
}

- (void)caculateLabelHeightWith:(NSString *)text storedResults:(NSMutableArray *)storedResults {
    CGFloat labeldHeight = 0.f;
    if ([text isNotBlank]) {
        labeldHeight = [text heightOfTextInLabelWithWidth:[UIScreen screenWidth]];
    } else {
        labeldHeight = 0.f;
    }
    [self addToCellHeight:ceilf(labeldHeight)];
    NSNumber *labeldHeightNumber = [NSNumber numberWithFloat:ceilf(labeldHeight)];
    [storedResults addObject:labeldHeightNumber];
}

- (void)caculateStatusPicturesViewConfigurationWith:(NSArray *)pictureUrls stroedResults:(NSMutableArray *)storedResults {
    NSInteger picturesNum = [pictureUrls count];
    CGFloat picturesViewHeight = 0.f;
    //viewConstraints contains:top bottom left right constraints(there are four seperator lines in xib)
    NSArray *viewConstraints = @[];
        switch (picturesNum) {
            case 0: {
                viewConstraints = @[@0,@0,@0,@0];
                picturesViewHeight = 0;
            }
                break;
            case 1: {
                CGFloat distance = ceilf([UIScreen screenWidth] / 2);
                NSNumber *distanceNum = [NSNumber numberWithFloat:distance];
                viewConstraints = @[distanceNum, @0, distanceNum, @0];
                picturesViewHeight = distance;
            }
                break;
            case 2: {
                CGFloat distance = ceilf([UIScreen screenWidth] / 2);
                NSNumber *distanceNum = [NSNumber numberWithFloat:distance];
                viewConstraints = @[distanceNum, @0, distanceNum, @0];
                picturesViewHeight = distance;
            }
                break;
            case 3: {
                CGFloat distance = ceilf([UIScreen screenWidth] / 3);
                NSNumber *distanceNum = [NSNumber numberWithFloat:distance];
                viewConstraints = @[distanceNum, @0, distanceNum, distanceNum];
                picturesViewHeight = distance;
            }
                break;
                // TODO:
            case 4: {
                CGFloat distance = ceilf([UIScreen screenWidth] / 2);
                NSNumber *distanceNum = [NSNumber numberWithFloat:distance];
                viewConstraints = @[distanceNum, @0, distanceNum, @0];
                picturesViewHeight = [UIScreen screenWidth];
            }
                break;
            case 5:
            case 6: {
                CGFloat distance = ceilf([UIScreen screenWidth] / 3);
                NSNumber *distanceNum = [NSNumber numberWithFloat:distance];
                viewConstraints = @[distanceNum, @0, distanceNum, distanceNum];
                picturesViewHeight = [UIScreen screenWidth];
            }
                break;
            case 7:
            case 8:
            case 9:{
                CGFloat distance = ceilf([UIScreen screenWidth] / 3);
                NSNumber *distanceNum = [NSNumber numberWithFloat:distance];
                viewConstraints = @[distanceNum, distanceNum, distanceNum, distanceNum];
                picturesViewHeight = [UIScreen screenWidth];
            }
                break;
                
            default: {
                viewConstraints = @[@0,@0,@0,@0];
                picturesViewHeight = 0;
            }
                break;
        }
    [self addToCellHeight:ceilf(picturesViewHeight)];
    [self.picturesViewConfigures addObject:viewConstraints];
}

- (void)addToCellHeight:(CGFloat)height {
   self.cellHeight += ceilf(height);
}

@end