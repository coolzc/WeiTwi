//
//  WTRWeiboUserInfo.h
//  WeiTwi
//
//  Created by zhangcheng on 10/30/15.
//  Copyright © 2015 XYZ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "WTRWeiboStatus.h"

@class WTRWeiboStatus;

@interface WTRWeiboUser : NSManagedObject

@property (nonatomic, assign) NSInteger userId;
@property (nonatomic, retain) NSString *userIdStr;
@property (nonatomic, retain) NSString *userScreenName;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, assign) NSInteger province;
@property (nonatomic, assign) NSInteger location;
@property (nonatomic, assign) NSInteger city;
@property (nonatomic, retain) NSString *userDescription;
@property (nonatomic, retain) NSString *blogUrl;
@property (nonatomic, retain) NSString *profileImageUrl;
@property (nonatomic, retain) NSString *profileUrl;
@property (nonatomic, retain) NSString *domain;
@property (nonatomic, retain) NSString *weihao;
@property (nonatomic, retain) NSString *gender;
@property (nonatomic, assign) NSInteger statusesCount;
@property (nonatomic, assign) NSInteger friendsCount;
@property (nonatomic, assign) NSInteger followersCount;
@property (nonatomic, assign) NSInteger favouritesCount;
@property (nonatomic, retain) NSString *createdAt;
@property (nonatomic, assign) BOOL allowAllActMsg;
@property (nonatomic, assign) BOOL geoEnabled;
@property (nonatomic, assign) BOOL verified;
@property (nonatomic, assign) NSInteger verifiedType;
@property (nonatomic, retain) NSString *remark;
@property (nonatomic, retain) WTRWeiboStatus *status;
@property (nonatomic, assign) BOOL allowAllComment;
@property (nonatomic, retain) NSString *avatarLargeUrl;
@property (nonatomic, retain) NSString *avatarHdUrl;
@property (nonatomic, retain) NSString *verifiedReason;
@property (nonatomic, retain) NSString *followMe;
@property (nonatomic, assign) BOOL onlineStatus;
@property (nonatomic, assign) NSInteger biFollowersCount;
@property (nonatomic, retain) NSString *language;


@end
