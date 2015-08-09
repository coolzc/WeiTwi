//
//  WTRUserInfo.h
//  HeinekenGreenRoom
//
//  Created by zhangcheng on 4/23/15.
//  Copyright (c) 2015 MobileNow. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WTRUserInfo : NSObject

@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *accessToken;
@property (nonatomic, strong) NSString *ttl;
@property (nonatomic, strong) NSString *createdTime;

- (BOOL)isLogin;

@end
