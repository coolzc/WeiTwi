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

+(instancetype)infoFromDictionaryData:(NSDictionary *)data {
    WTRWeiboStatusInfo *statusInfo = [WTRWeiboStatusInfo new];
    statusInfo.createdAt = [data stringForKey:@"createdAt"];
    statusInfo.statusId = [[data integerForKey:@"statusId" ] integerValue];
    statusInfo.statusMid = [[data stringForKey:@"statusMid" ] integerValue];
    statusInfo.idStr = [data stringForKey:@"idStr"];
    statusInfo.text = [data stringForKey:@"text"];
    statusInfo.source = [data stringForKey:@"source"];
    statusInfo.favorited = [data stringForKey:@"favorited"];
    statusInfo.truncated = [data stringForKey:@"truncated"];
    statusInfo.thumbnailPic = [data stringForKey:@"thumbnailPic"];
    statusInfo.bmiddlePic = [data stringForKey:@"bmiddlePic"];
    statusInfo.originalPic = [data stringForKey:@"originalPic"];
    WTRWeiboGeoInfo *geoInfo = [WTRWeiboGeoInfo infoFromDictionaryData:[data dictionaryForKey:@"geo"]];
    statusInfo.geo = geoInfo;
    WTRWeiboUserInfo *userInfo = [WTRWeiboUserInfo infoFromDictionaryData:[data dictionaryForKey:@"user"]];
    statusInfo.user = userInfo;
    WTRWeiboStatusInfo *reTweetStatusInfo = [WTRWeiboStatusInfo infoFromDictionaryData:[data dictionaryForKey:@"retweetedStatus"]];
    statusInfo.retweetedStatus = reTweetStatusInfo;
    statusInfo.repostsCount = [[data stringForKey:@"repostsCount"] integerValue];
    statusInfo.commentsCount = [[data stringForKey:@"commentsCount"] integerValue];
    statusInfo.attitudesCount = [[data stringForKey:@"attitudesCount"] integerValue];
    statusInfo.visible = [[data stringForKey:@"visible"] integerValue];
    statusInfo.picIds = [data stringForKey:@"picIds"];
    statusInfo.weiboAd = [data stringForKey:@"weiboAd"];
    return statusInfo;
}

@end
