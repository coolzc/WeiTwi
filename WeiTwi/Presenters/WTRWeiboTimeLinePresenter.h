//
//  WTRTimeLineListPresenter.h
//  WeiTwi
//
//  Created by zhangcheng on 10/20/15.
//  Copyright © 2015 XYZ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WTRBasePresenter.h"
#import "WTRWeiboManagerInteractor.h"
@interface WTRWeiboTimeLinePresenter : WTRBasePresenter <WTRWeiboManagerDelegate>

- (void)loginWeibo;
- (void)viewDetailOfTimelineWeibo;
- (void)viewGroupDeckListDetail;

@property (nonatomic, strong) WTRWeiboManagerInteractor *weiboInteractor;

@end
