//
//  WTRWeiboTimelineDisplayInterface.h
//  WeiTwi
//
//  Created by zhangcheng on 10/27/15.
//  Copyright © 2015 XYZ. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    WTRWeiboTimelineViewRefresh,
    WTRWeiboTimelineViewTopRefresh,
    WTRWeiboTimelineViewBottomRefresh,
} WTRWeiboRefreshDisplayType;

@protocol WTRWeiboTimelineDisplayInterface <NSObject>

@optional

- (void)displayWeiboTimelineStatuses:(NSArray *)statuses withCellConfigure:(NSArray *)totalHeights statusTextHeight:(NSArray *)statusTextHeights reTweetTextHeight:(NSArray *)reTweetTextHeights pictureViewConfigure:(NSArray *)pictureViewConfigures refreshDisplayType:(WTRWeiboRefreshDisplayType)refreshDisplayType;

@end
