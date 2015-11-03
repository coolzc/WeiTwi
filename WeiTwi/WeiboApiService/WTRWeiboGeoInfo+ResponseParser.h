//
//  WTRWeiboGeoInfo+ResponseParser.h
//  WeiTwi
//
//  Created by zhangcheng on 11/3/15.
//  Copyright © 2015 XYZ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WTRWeiboGeoInfo.h"

@interface WTRWeiboGeoInfo (ResponseParser)

+(instancetype)infoFromDictionaryData:(NSDictionary *)data;

@end
