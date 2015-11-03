//
//  WTRStatusInfo+ResponseParser.h
//  WeiTwi
//
//  Created by zhangcheng on 11/3/15.
//  Copyright © 2015 XYZ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WTRWeiboStatusInfo.h"

@interface WTRWeiboStatusInfo (ResponseParser)

+ (instancetype)infoFromDictionaryData:(NSDictionary *)data;

@end
