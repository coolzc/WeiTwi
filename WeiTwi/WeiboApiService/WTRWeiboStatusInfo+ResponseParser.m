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
    //TODO: it may casue definite loop
    id reTweetStatusInfo = [data dictionaryForKey:@"retweeted_status"];
    statusInfo.retweetedStatus = reTweetStatusInfo;
    statusInfo.repostsCount = [[data stringForKey:@"reposts_count"] integerValue];
    statusInfo.commentsCount = [[data stringForKey:@"comments_count"] integerValue];
    statusInfo.attitudesCount = [[data stringForKey:@"attitudes_count"] integerValue];
    statusInfo.visible = [[data stringForKey:@"visible"] integerValue];
    statusInfo.picIds = [data stringForKey:@"pic_ids"];
    statusInfo.weiboAd = [data stringForKey:@"ad"];
    return statusInfo;
}

@end
