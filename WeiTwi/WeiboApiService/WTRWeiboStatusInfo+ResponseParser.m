//
//  WTRStatusInfo+ResponseParser.m
//  WeiTwi
//
//  Created by zhangcheng on 11/3/15.
//  Copyright © 2015 XYZ. All rights reserved.
//

#import "WTRWeiboStatusInfo+ResponseParser.h"
#import "WTRWeiboUserInfo.h"
#import "WTRWeiboUserInfo+ResponseParser.h"
#import "WTRWeiboGeoInfo.h"
#import "WTRWeiboGeoInfo+ResponseParser.h"
#import "NSDictionary+WTRUtility.h"

@implementation WTRWeiboStatusInfo (ResponseParser)

+ (instancetype)infoFromDictionaryData:(NSDictionary *)data {
    WTRWeiboStatusInfo *statusInfo = [WTRWeiboStatusInfo new];
    statusInfo.createdAt = [data stringForKey:@"created_at"];
    statusInfo.statusId = [[data integerForKey:@"id" ] integerValue];
    statusInfo.statusMid = [[data stringForKey:@"mid" ] integerValue];
    statusInfo.idStr = [data stringForKey:@"idstr"];
    statusInfo.text = [data stringForKey:@"text"];
    statusInfo.source = [data stringForKey:@"source"];
    statusInfo.favorited = [data stringForKey:@"favorited"];
    statusInfo.truncated = [data stringForKey:@"truncated"];
    statusInfo.thumbnailPic = [data stringForKey:@"thumbnail_pic"];
    statusInfo.bmiddlePic = [data stringForKey:@"bmiddle_pic"];
    statusInfo.originalPic = [data stringForKey:@"original_pic"];
    WTRWeiboGeoInfo *geoInfo = [WTRWeiboGeoInfo infoFromDictionaryData:[data dictionaryForKey:@"geo"]];
    statusInfo.geo = geoInfo;
    WTRWeiboUserInfo *userInfo = [WTRWeiboUserInfo infoFromDictionaryData:[data dictionaryForKey:@"user"]];
    statusInfo.user = userInfo;
    //TODO: it may casue definite loop,so need to judge if it is @{}
    statusInfo.retweetedStatus = [self weiboStatusInfoParse:data];
    
    statusInfo.repostsCount = [[data stringForKey:@"reposts_count"] integerValue];
    statusInfo.commentsCount = [[data stringForKey:@"comments_count"] integerValue];
    statusInfo.attitudesCount = [[data stringForKey:@"attitudes_count"] integerValue];
    statusInfo.visible = [[data stringForKey:@"visible"] integerValue];
    //pic_id
    statusInfo.picUrls = [self picUrlsParse:data];
    statusInfo.weiboAd = [data stringForKey:@"ad"];
    return statusInfo;
}

+ (WTRWeiboStatusInfo *)weiboStatusInfoParse:(NSDictionary *)data {
    id reTweetStatus = [data dictionaryForKey:@"retweeted_status"];
    WTRWeiboStatusInfo *reTweetStatusInfo = nil;
    if (![reTweetStatus isEqual: @{}]) {
        reTweetStatusInfo = [WTRWeiboStatusInfo infoFromDictionaryData:reTweetStatus];
    }
    return reTweetStatusInfo;
}

+ (NSArray *)picUrlsParse:(NSDictionary *)data {
    NSArray *picData = [data arrayForKey:@"pic_urls"];
    NSMutableArray *picUrls = [NSMutableArray arrayWithCapacity:[picData count]];
    for (NSDictionary *picUrl in picData) {
        [picUrls addObject:[picUrl objectForKey:@"thumbnail_pic"]];
    }
    return [picUrls copy];
}

@end
