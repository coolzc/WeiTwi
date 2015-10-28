//
//  WTRTwitterTimelinePresenter.h
//  WeiTwi
//
//  Created by zhangcheng on 10/27/15.
//  Copyright © 2015 XYZ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WTRTwitterManagerInteractor.h"
#import "WTRTwitterTimelineDisplayInterface.h"
#import "WTRBasePresenter.h"
@interface WTRTwitterTimelinePresenter : WTRBasePresenter <WTRTwitterManagerDelegate>

@property (nonatomic, strong) WTRTwitterManagerInteractor *twitterInteractor;
@property (nonatomic, weak) id<WTRTwitterTimelineDisplayInterface> twitterTimelineDisplay;

-(void)logInTwitter;

@end
