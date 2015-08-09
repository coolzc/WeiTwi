//
//  WTRTimeline+ResponseParser.m
//  WeiTwi
//
//  Created by zhangcheng on 7/5/15.
//  Copyright (c) 2015 XYZ. All rights reserved.
//

#import "WTRWeiboStatuses+ResponseParser.h"
#import "NSDictionary+WTRUtility.h"

@implementation WTRWeiboStatuses (ResponseParser)

+ (instancetype)infoFromDictionaryData:(NSDictionary *)data {
    WTRWeiboStatuses *timeline = [WTRWeiboStatuses new];
    timeline.text = [data stringForKey:@"text"];
    timeline.createdTime = [data stringForKey:@"created_at"];
    timeline.repostCount = [data stringForKey:@"reposts_count"];
    timeline.commentCount = [data stringForKey:@"comments_count"];
    return timeline;
}

@end
