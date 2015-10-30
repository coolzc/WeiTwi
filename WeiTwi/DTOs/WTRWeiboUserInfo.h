//
//  WTRUserInfo.h
//  HeinekenGreenRoom
//
//  Created by zhangcheng on 4/23/15.
//  Copyright (c) 2015 MobileNow. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WTRWeiboUserInfo : NSObject

@property (nonatomic, strong) NSString *avatarSmallUrl;
@property (nonatomic, strong) NSString *avatarLargeUrl;
@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *userStringId;
@property (nonatomic, strong) NSString *userScreenName;
@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *weihao;
@property (nonatomic, strong) NSString *domain;
@property (nonatomic, strong) NSString *location;
@property (nonatomic, strong) NSString *province;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *statusesCount;
@property (nonatomic, strong) NSString *friendsCount;
@property (nonatomic, strong) NSString *followersCount;


@end
