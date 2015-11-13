//
//  WTRTimeLineListPresenter.h
//  WeiTwi
//
//  Created by zhangcheng on 10/20/15.
//  Copyright © 2015 XYZ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WTRBasePresenter.h"
#import "WTRWeiboTimelineDisplayInterface.h"
#import "WTRProgressViewInterface.h"

@interface WTRWeiboTimeLinePresenter : WTRBasePresenter

- (void)viewDetailOfTimelineWeibo;
- (void)viewGroupDeckListDetail;
- (void)reloadWeiboTimelineData;

@property (nonatomic, weak) id<WTRProgressViewInterface> progressView;
@property (nonatomic, weak) id<WTRWeiboTimelineDisplayInterface> weiboTimelineDisplay;

@end
