//
//  WTRWeiboUserInfo+ResponseParser.m
//  WeiTwi
//
//  Created by zhangcheng on 11/3/15.
//  Copyright © 2015 XYZ. All rights reserved.
//

#import "WTRWeiboUserInfo+ResponseParser.h"
#import "NSDictionary+WTRUtility.h"
#import "WTRWeiboStatusInfo.h"
#import "WTRWeiboStatusInfo+ResponseParser.h"

@implementation WTRWeiboUserInfo (ResponseParser)

+ (instancetype)infoFromDictionaryData:(NSDictionary *)data {
    WTRWeiboUserInfo *userInfo = [WTRWeiboUserInfo new];
    userInfo.userId = [[data stringForKey:@"id"] integerValue] ;
    userInfo.userIdStr = [data stringForKey:@"idstr"];
    userInfo.userScreenName = [data stringForKey:@"screen_name"];
    userInfo.name = [data stringForKey:@"name"];
    userInfo.province = [[data stringForKey:@"province"] integerValue];
    userInfo.location = [[data stringForKey:@"location"] integerValue];
    userInfo.city = [[data stringForKey:@"city"] integerValue];
    userInfo.userDescription = [data stringForKey:@"description"];
    userInfo.blogUrl = [data stringForKey:@"url"];
    userInfo.profileImageUrl = [data stringForKey:@"profile_image_url"];
    userInfo.profileUrl = [data stringForKey:@"profile_url"];
    userInfo.domain = [data stringForKey:@"domain"];
    userInfo.weihao = [data stringForKey:@"weihao"];
    userInfo.gender = [data stringForKey:@"gender"];
    userInfo.statusesCount = [[data stringForKey:@"statuses_count"] integerValue];
    userInfo.friendsCount = [[data stringForKey:@"friends_count"] integerValue];
    userInfo.favouritesCount = [[data stringForKey:@"favourites_count"] integerValue];
    userInfo.createdAt = [data stringForKey:@"created_at"];
    userInfo.allowAllActMsg = [data stringForKey:@"allow_all_act_msg"];
    userInfo.geoEnabled = [data stringForKey:@"geo_enabled"];
    userInfo.verified = [data stringForKey:@"verified"];
    userInfo.verifiedType = [[data stringForKey:@"verified_type"] integerValue];
    userInfo.remark = [data stringForKey:@"remark"];
    //it will cause the infinite loop of statusinfo and userinfo ,dont use this propertiy
    id statusInfo = [data dictionaryForKey:@"status"];
    userInfo.status = statusInfo;
    userInfo.allowAllComment = [data stringForKey:@"allow_all_comment"];
    userInfo.avatarLargeUrl = [data stringForKey:@"avatar_large"];
    userInfo.avatarHdUrl = [data stringForKey:@"avatar_hd"];
    userInfo.verifiedReason = [data stringForKey:@"verified_reason"];
    userInfo.followMe = [data stringForKey:@"follow_me"];
    userInfo.onlineStatus = [data stringForKey:@"online_status"];
    userInfo.biFollowersCount = [[data stringForKey:@"bi_followers_count"] integerValue];
    userInfo.language = [data stringForKey:@"lang"];
    return userInfo;
}
@end
