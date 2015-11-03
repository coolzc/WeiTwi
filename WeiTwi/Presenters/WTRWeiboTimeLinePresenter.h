//
//  WTRTimeLineListPresenter.h
//  WeiTwi
//
//  Created by zhangcheng on 10/20/15.
//  Copyright © 2015 XYZ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WTRBasePresenter.h"
#import "WTRWeiboApiService.h"
#import "WTRWeiboTimelineDisplayInterface.h"
#import "WTRProgressViewInterface.h"

@interface WTRWeiboTimeLinePresenter : WTRBasePresenter <WTRWeiboApiServiceDelegate>

- (void)viewDetailOfTimelineWeibo;
- (void)viewGroupDeckListDetail;

@property (nonatomic, weak) id<WTRProgressViewInterface> progressView;
@property (nonatomic, weak) id<WTRWeiboTimelineDisplayInterface> weiboTimelineDisplay;

@end
