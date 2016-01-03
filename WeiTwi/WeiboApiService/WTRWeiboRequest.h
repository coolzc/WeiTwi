//
//  WTRWeiboRequest.h
//  WeiTwi
//
//  Created by zhangcheng on 11/3/15.
//  Copyright © 2015 XYZ. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    WTRWeiboRequestAuthorized,
    WTRWeiboRequestUnAuthorized,
    WTRWeiboRequestHomeTimeline,
    WTRWeiboRequestHomeTimelineSince,
    WTRWeiboRequestHomeTimelineBefore,
} WTRWeiboRequestType;

typedef enum {
    WTRWeiboRequestMethodGet,
    WTRWeiboRequestMethodPost,
    WTRWeiboRequestMethodDelete,
    WTRWeiboRequestMethodPut,
} WTRWeiboRequestMethod;

typedef id (^WeiboApiResponseParser)(NSDictionary *data);

@interface WTRWeiboRequest : NSObject

@property (nonatomic, strong) NSString *url;
@property (nonatomic, assign) WTRWeiboRequestType type;
@property (nonatomic, assign) NSString *method;
@property (nonatomic, copy) WeiboApiResponseParser responseParser;
@property (nonatomic, strong) NSMutableDictionary *parameters;

+ (instancetype)requestForHometimelineCount:(NSInteger)count;
+ (instancetype)requestForHometimelineSince:(NSString *)sinceId refreshCount:(NSUInteger)count;
+ (instancetype)requestForHometimelineBefore:(NSString *)maxId refreshCount:(NSUInteger)count;

@end
