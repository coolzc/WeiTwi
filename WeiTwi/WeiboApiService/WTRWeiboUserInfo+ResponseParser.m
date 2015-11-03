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

+(instancetype)infoFromDictionaryData:(NSDictionary *)data {
    WTRWeiboUserInfo *userInfo = [WTRWeiboUserInfo new];
    userInfo.userId = [[data stringForKey:@"userId"] integerValue] ;
    userInfo.userIdStr = [data stringForKey:@"userIdStr"];
    userInfo.userScreenName = [data stringForKey:@"userScreenName"];
    userInfo.name = [data stringForKey:@"name"];
    userInfo.province = [[data stringForKey:@"province"] integerValue];
    userInfo.location = [[data stringForKey:@"location"] integerValue];
    userInfo.city = [[data stringForKey:@"city"] integerValue];
    userInfo.userDescription = [data stringForKey:@"userDescription"];
    userInfo.blogUrl = [data stringForKey:@"blogUrl"];
    userInfo.profileImageUrl = [data stringForKey:@"profileImageUrl"];
    userInfo.profileUrl = [data stringForKey:@"profileUrl"];
    userInfo.domain = [data stringForKey:@"domain"];
    userInfo.weihao = [data stringForKey:@"weihao"];
    userInfo.gender = [data stringForKey:@"gender"];
    userInfo.statusesCount = [[data stringForKey:@"statusesCount"] integerValue];
    userInfo.friendsCount = [[data stringForKey:@"friendsCount"] integerValue];
    userInfo.favouritesCount = [[data stringForKey:@"favouritesCount"] integerValue];
    userInfo.createdAt = [data stringForKey:@"createdAt"];
    userInfo.allowAllActMsg = [data stringForKey:@"allowAllActMsg"];
    userInfo.geoEnabled = [data stringForKey:@"geoEnabled"];
    userInfo.verified = [data stringForKey:@"verified"];
    userInfo.verifiedType = [[data stringForKey:@"verifiedType"] integerValue];
    userInfo.remark = [data stringForKey:@"remark"];
    WTRWeiboStatusInfo *statusInfo = [WTRWeiboStatusInfo infoFromDictionaryData:[data dictionaryForKey:@"status"]];
    userInfo.status = statusInfo;
    userInfo.allowAllComment = [data stringForKey:@"allowAllComment"];
    userInfo.avatarLargeUrl = [data stringForKey:@"avatarLargeUrl"];
    userInfo.avatarHdUrl = [data stringForKey:@"avatarHdUrl"];
    userInfo.verifiedReason = [data stringForKey:@"verifiedReason"];
    userInfo.followMe = [data stringForKey:@"followMe"];
    userInfo.onlineStatus = [data stringForKey:@"onlineStatus"];
    userInfo.biFollowersCount = [[data stringForKey:@"biFollowersCount"] integerValue];
    userInfo.language = [data stringForKey:@"language"];
    return userInfo;
}
@end
