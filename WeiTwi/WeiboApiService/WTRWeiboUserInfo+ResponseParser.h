//
//  WTRWeiboUserInfo+ResponseParser.h
//  WeiTwi
//
//  Created by zhangcheng on 11/3/15.
//  Copyright © 2015 XYZ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WTRWeiboUserInfo.h"

@interface WTRWeiboUserInfo (ResponseParser)

+ (instancetype)infoFromDictionaryData:(NSDictionary *)data;


@end
