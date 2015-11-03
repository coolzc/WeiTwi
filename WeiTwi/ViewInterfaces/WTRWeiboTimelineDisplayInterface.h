//
//  WTRWeiboTimelineDisplayInterface.h
//  WeiTwi
//
//  Created by zhangcheng on 10/27/15.
//  Copyright © 2015 XYZ. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol WTRWeiboTimelineDisplayInterface <NSObject>

@optional

- (void)displayWeiboTimelineContentText:(NSArray *)contentTextInfo PostUserName:(NSArray *)nameInfo postTime:(NSArray *)timeInfo originSource:(NSArray *)originSourceInfo praiseCount:(NSArray *)praiseCountInfo repostCount:(NSArray *)repostCountInfo commentCount:(NSArray *)commentCountInfo;

@end
