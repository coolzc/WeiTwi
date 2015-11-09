//
//  WTRWeiboTimeline.h
//  WeiTwi
//
//  Created by zhangcheng on 7/5/15.
//  Copyright (c) 2015 XYZ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WTRWeiboGeoInfo.h"
#import "WTRWeiboUserInfo.h"

@class WTRWeiboUserInfo;

@interface WTRWeiboStatusInfo : NSObject

@property (nonatomic, strong) NSString *createdAt;
@property (nonatomic, assign) NSInteger statusId;
@property (nonatomic, assign) NSInteger statusMid;
@property (nonatomic, strong) NSString *idStr;
@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSString *source;
@property (nonatomic, assign) BOOL favorited;
@property (nonatomic, assign) BOOL truncated;
@property (nonatomic, strong) NSString *thumbnailPic;
@property (nonatomic, strong) NSString *bmiddlePic;
@property (nonatomic, strong) NSString *originalPic;
@property (nonatomic, strong) WTRWeiboGeoInfo *geo;
@property (nonatomic, strong) WTRWeiboUserInfo *user;
@property (nonatomic, strong) id retweetedStatus;
@property (nonatomic, assign) NSInteger repostsCount;
@property (nonatomic, assign) NSInteger commentsCount;
@property (nonatomic, assign) NSInteger attitudesCount;
@property (nonatomic, assign) NSInteger visible;
//TODO  type not sure
@property (nonatomic, strong) NSString *picIds;
@property (nonatomic, strong) NSString *weiboAd;
@end
