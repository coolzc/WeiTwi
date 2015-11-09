//
//  WTRWeiboGeoInfo+ResponseParser.m
//  WeiTwi
//
//  Created by zhangcheng on 11/3/15.
//  Copyright © 2015 XYZ. All rights reserved.
//

#import "WTRWeiboGeoInfo+ResponseParser.h"
#import "WTRWeiboGeoInfo.h"
#import "NSDictionary+WTRUtility.h"

@implementation WTRWeiboGeoInfo (ResponseParser)

+ (instancetype)infoFromDictionaryData:(NSDictionary *)data {
    WTRWeiboGeoInfo *geoInfo = [WTRWeiboGeoInfo new];
    geoInfo.longitude = [data stringForKey:@"longitude"];
    geoInfo.latitude = [data stringForKey:@"latitude"];
    geoInfo.city = [data stringForKey:@"city"];
    geoInfo.province = [data stringForKey:@"province"];
    geoInfo.cityName = [data stringForKey:@"cityName"];
    geoInfo.provinceName = [data stringForKey:@"provinceName"];
    geoInfo.address = [data stringForKey:@"address"];
    geoInfo.pinyin = [data stringForKey:@"pinyin"];
    geoInfo.more = [data stringForKey:@"more"];
    return geoInfo;
}

@end
