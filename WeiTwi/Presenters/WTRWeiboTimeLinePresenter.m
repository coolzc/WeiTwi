//
//  WTRTimeLineListPresenter.m
//  WeiTwi
//
//  Created by zhangcheng on 10/20/15.
//  Copyright © 2015 XYZ. All rights reserved.
//

#import "WTRWeiboTimeLinePresenter.h"
#import "WTRWireframe.h"

@interface WTRWeiboTimeLinePresenter ()

@property (nonatomic, strong) NSArray *timelineInfo;
@property (nonatomic, assign) BOOL neeedFetchRemoteData;

@end

@implementation WTRWeiboTimeLinePresenter

- (void)viewDidLoad:(UIViewController *)viewController {
    [super viewDidLoad:viewController];
    self.timelineInfo = [NSArray new];
    self.neeedFetchRemoteData = YES;
}

- (void)view:(UIViewController *)viewController willAppear:(BOOL)animated {
    [super view:viewController willDisappear:animated];
    if (self.neeedFetchRemoteData) {
        //TODO
        
    }
    self.neeedFetchRemoteData = NO;
    [self fetchTimelineInfoFromRemote];
}

- (void)loginWeibo {
    [self.weiboInteractor sendRequest:WTRWeiboRequestSSO];
}

- (void)viewDetailOfTimelineWeibo {
//    [WTRWireframe moveToNextPageOfViewController:self.mainViewController];
    [self.weiboInteractor sendRequest:WTRWeiboRequestHomeTimeline];
}

- (void)viewGroupDeckListDetail {
    [WTRWireframe moveToDeckViewController:self.mainViewController Messenger:[WTRPageMessenger messenger]];
}

#pragma mark - WTRWeiboManagerDelegate

- (void)weiboServiceDidFinishRequestWithResponse:(id)responseObject {
    self.timelineInfo = responseObject;
    [self.weiboTimelineDisplay displayWeiboTimeline:responseObject];
    NSLog(@"weibo status:%@",responseObject);
}

#pragma mark - Private Methods

- (void)fetchTimelineInfoFromRemote {

}

@end
