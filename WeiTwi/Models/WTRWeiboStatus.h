//
//  WTRWeiboStatus.h
//  WeiTwi
//
//  Created by zhangcheng on 10/30/15.
//  Copyright © 2015 XYZ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "WTRWeiboUser.h"
#import "WTRWeiboGeo.h"

@class WTRWeiboUser;

@interface WTRWeiboStatus : NSManagedObject

@property (nonatomic, retain) NSString *createdAt;
@property (nonatomic, assign) NSInteger statusId;
@property (nonatomic, assign) NSInteger statusMid;
@property (nonatomic, retain) NSString *idStr;
@property (nonatomic, retain) NSString *text;
@property (nonatomic, retain) NSString *source;
@property (nonatomic, assign) BOOL favorited;
@property (nonatomic, assign) BOOL truncated;
@property (nonatomic, retain) NSString *thumbnailPic;
@property (nonatomic, retain) NSString *bmiddlePic;
@property (nonatomic, retain) NSString *originalPic;
@property (nonatomic, retain) WTRWeiboGeo *geo;
@property (nonatomic, retain) WTRWeiboUser *user;
@property (nonatomic, retain) WTRWeiboStatus *retweetedStatus;
@property (nonatomic, assign) NSInteger repostsCount;
@property (nonatomic, assign) NSInteger commentsCount;
@property (nonatomic, assign) NSInteger attitudesCount;
@property (nonatomic, assign) NSInteger visible;
//TODO  type not sure
@property (nonatomic, retain) NSString *picUrls;
@property (nonatomic, retain) NSString *weiboAd;

@end
