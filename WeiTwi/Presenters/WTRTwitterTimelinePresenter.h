//
//  WTRTwitterTimelinePresenter.h
//  WeiTwi
//
//  Created by zhangcheng on 10/27/15.
//  Copyright © 2015 XYZ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WTRTwitterManagerInteractor.h"

@interface WTRTwitterTimelinePresenter : NSObject <WTRTwitterManagerDelegate>

@property (nonatomic, strong) WTRTwitterManagerInteractor *twitterInteractor;

@end
