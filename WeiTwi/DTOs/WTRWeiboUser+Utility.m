//
//  WTRWeiboUser+Utility.m
//  WeiTwi
//
//  Created by zhangcheng on 10/31/15.
//  Copyright © 2015 XYZ. All rights reserved.
//

#import "WTRWeiboUser+Utility.h"
#import "WTRWeiboStatus+Utility.h"

@implementation WTRWeiboUser (Utility)

- (void)updateWithUserInfo:(WTRWeiboUserInfo *)userinfo {
    self.userId = userinfo.userId;
    self.userIdStr = userinfo.userIdStr;
    self.userScreenName = userinfo.userScreenName;
    self.userScreenName = userinfo.name;
    self.province = userinfo.province;
    self.location = userinfo.location;
    self.city = userinfo.city;
    self.userDescription = userinfo.userDescription;
    self.blogUrl = userinfo.blogUrl;
    self.profileImageUrl = userinfo.profileImageUrl;
    self.profileUrl = userinfo.profileUrl;
    self.domain = userinfo.domain;
    self.weihao = userinfo.weihao;
    self.gender = userinfo.gender;
    self.statusesCount = userinfo.statusesCount;
    self.friendsCount = userinfo.friendsCount;
    self.followersCount = userinfo.followersCount;
    self.favouritesCount = userinfo.favouritesCount;
    self.createdAt = userinfo.createdAt;
    self.allowAllActMsg = userinfo.allowAllActMsg;
    self.geoEnabled = userinfo.geoEnabled;
    self.verified = userinfo.verified;
    self.verifiedType = userinfo.verifiedType;
    self.remark = userinfo.remark;
    //TODO:
    [self.status updateWeiboStatusInfo:userinfo.status];
    self.allowAllComment = userinfo.allowAllComment;
    self.avatarLargeUrl = userinfo.avatarLargeUrl;
    self.avatarHdUrl = userinfo.avatarHdUrl;
    self.verifiedReason = userinfo.verifiedReason;
    self.followMe = userinfo.followMe;
    self.onlineStatus = userinfo.onlineStatus;
    self.biFollowersCount = userinfo.biFollowersCount;
    self.language = userinfo.language;
    
}


@end
