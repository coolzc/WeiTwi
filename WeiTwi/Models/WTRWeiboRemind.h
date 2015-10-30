//
//  WTRWeiboRemind.h
//  WeiTwi
//
//  Created by zhangcheng on 10/30/15.
//  Copyright © 2015 XYZ. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface WTRWeiboRemind : NSManagedObject

@property (nonatomic, assign) NSInteger status;
@property (nonatomic, assign) NSInteger follower;
@property (nonatomic, assign) NSInteger cmt;
@property (nonatomic, assign) NSInteger dm;
@property (nonatomic, assign) NSInteger mentionStatus;
@property (nonatomic, assign) NSInteger mentionCmt;
@property (nonatomic, assign) NSInteger group;
@property (nonatomic, assign) NSInteger privateGroup;
@property (nonatomic, assign) NSInteger notice;
@property (nonatomic, assign) NSInteger invite;
@property (nonatomic, assign) NSInteger badge;
@property (nonatomic, assign) NSInteger photo;
@property (nonatomic, assign) NSInteger msgbox;


@end
