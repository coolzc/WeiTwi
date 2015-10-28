//
//  WTRTwitterTimelinePresenter.m
//  WeiTwi
//
//  Created by zhangcheng on 10/27/15.
//  Copyright © 2015 XYZ. All rights reserved.
//

#import "WTRTwitterTimelinePresenter.h"

@implementation WTRTwitterTimelinePresenter

- (void)logInTwitter {
    [self.twitterInteractor sendRequest:WTRTwitterRequestLogin];
}

- (void)twitterServiceDidFinishRequestWithResponse:(id)responseObject {
    [self.twitterTimelineDisplay displayTwtitterTimeline:responseObject];
}

@end
