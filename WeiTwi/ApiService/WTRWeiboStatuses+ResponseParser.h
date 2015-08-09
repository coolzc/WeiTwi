//
//  WTRTimeline+ResponseParser.h
//  WeiTwi
//
//  Created by zhangcheng on 7/5/15.
//  Copyright (c) 2015 XYZ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WTRWeiboStatuses.h"

@interface WTRWeiboStatuses (ResponseParser)

+ (instancetype)infoFromDictionaryData:(NSDictionary *)data;

@end
