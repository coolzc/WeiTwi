//
//  WTRUserInfo.h
//  HeinekenGreenRoom
//
//  Created by zhangcheng on 4/23/15.
//  Copyright (c) 2015 MobileNow. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WTRWeiboStatusInfo.h"

@class WTRWeiboStatusInfo;

@interface WTRWeiboUserInfo : NSObject

@property (nonatomic, assign) NSInteger userId;
@property (nonatomic, strong) NSString *userIdStr;
@property (nonatomic, strong) NSString *userScreenName;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) NSInteger province;
@property (nonatomic, assign) NSInteger location;
@property (nonatomic, assign) NSInteger city;
@property (nonatomic, strong) NSString *userDescription;
@property (nonatomic, strong) NSString *blogUrl;
@property (nonatomic, strong) NSString *profileImageUrl;
@property (nonatomic, strong) NSString *profileUrl;
@property (nonatomic, strong) NSString *domain;
@property (nonatomic, strong) NSString *weihao;
@property (nonatomic, strong) NSString *gender;
@property (nonatomic, assign) NSInteger statusesCount;
@property (nonatomic, assign) NSInteger friendsCount;
@property (nonatomic, assign) NSInteger followersCount;
@property (nonatomic, assign) NSInteger favouritesCount;
@property (nonatomic, strong) NSString *createdAt;
@property (nonatomic, assign) BOOL allowAllActMsg;
@property (nonatomic, assign) BOOL geoEnabled;
@property (nonatomic, assign) BOOL verified;
@property (nonatomic, assign) NSInteger verifiedType;
@property (nonatomic, strong) NSString *remark;
@property (nonatomic, strong) WTRWeiboStatusInfo *status;
@property (nonatomic, assign) BOOL allowAllComment;
@property (nonatomic, strong) NSString *avatarLargeUrl;
@property (nonatomic, strong) NSString *avatarHdUrl;
@property (nonatomic, strong) NSString *verifiedReason;
@property (nonatomic, strong) NSString *followMe;
@property (nonatomic, assign) BOOL onlineStatus;
@property (nonatomic, assign) NSInteger biFollowersCount;
@property (nonatomic, strong) NSString *language;


@end
