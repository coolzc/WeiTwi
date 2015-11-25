//
//  WTRWeiboRequest.m
//  WeiTwi
//
//  Created by zhangcheng on 11/3/15.
//  Copyright © 2015 XYZ. All rights reserved.
//

#import "WTRWeiboRequest.h"
#import "WTRConfig.h"
#import "WTRAuthorizedUser+DataManager.h"
#import "WTRAuthorizedUserInfo.h"
#import "NSDictionary+WTRUtility.h"
#import "WTRWeiboStatusInfo+ResponseParser.h"

static NSString *const HomeTimelinePath = @"/statuses/home_timeline.json";
static NSString *const UserTimelinPath = @"/statuses/user_timeline.json";

@implementation WTRWeiboRequest

- (id)init {
    if (self = [super init]) {
        _parameters = [NSMutableDictionary dictionary];
    }
    return self;
}

#pragma mark - Public Methods

+ (instancetype)requestForHometimelineCount:(NSInteger)count {
    WTRWeiboRequest *weiboRequest = [self requestForTimeline:HomeTimelinePath type:WTRWeiboRequestHomeTimeline method:WTRWeiboRequestMethodGet];
    [weiboRequest addParameter:@"count" value:[NSString stringWithFormat:@"%ld",(long)count]];
    return weiboRequest;
}

+ (instancetype)requestForHometimelineSince:(NSString *)sinceId {
    WTRWeiboRequest *weiboRequest = [self requestForTimeline:HomeTimelinePath type:WTRWeiboRequestHomeTimelineSince method:WTRWeiboRequestMethodGet];
    [weiboRequest addParameter:@"since_id" value:sinceId];
    [weiboRequest addParameter:@"count" value:[NSString stringWithFormat:@"%d",100]];
    return weiboRequest;
}

+ (instancetype)requestForHometimelineBefore:(NSString *)maxId {
    WTRWeiboRequest *weiboRequest = [self requestForTimeline:HomeTimelinePath type:WTRWeiboRequestHomeTimelineBefore method:WTRWeiboRequestMethodGet];
    [weiboRequest addParameter:@"max_id" value:maxId];
    [weiboRequest addParameter:@"count" value:[NSString stringWithFormat:@"%d",100]];
    return weiboRequest;
}

#pragma mark - Private Methods

+ (instancetype)requestForTimeline:(NSString *)path type:(WTRWeiboRequestType)type method:(WTRWeiboRequestMethod)method {
    WTRWeiboRequest *weiboRequest = [self requestForPath:path type:type method:method];
    weiboRequest.responseParser = ^id(NSDictionary *data) {
        NSArray *statusesData = [data arrayForKey:@"statuses"];
        NSMutableArray *statuses = [NSMutableArray arrayWithCapacity:[statusesData count]];
        for (NSDictionary *statusData in statusesData) {
            [statuses addObject:[WTRWeiboStatusInfo infoFromDictionaryData:statusData]];
        }
        return statuses;
    };
    return weiboRequest;
}

+ (instancetype)requestForPath:(NSString *)path type:(WTRWeiboRequestType)type method:(WTRWeiboRequestMethod)method {
    WTRWeiboRequest *request = [self requestToPath:path];
    request.type = type;
    switch (method) {
        case WTRWeiboRequestMethodGet:
            request.method = @"Get";
            break;
        case WTRWeiboRequestMethodPost:
            request.method = @"Post";
            break;
        case WTRWeiboRequestMethodPut:
            request.method = @"Put";
            break;
        case WTRWeiboRequestMethodDelete:
            request.method = @"Delete";
            break;
        default:
            break;
    }
    return request;
}

+ (instancetype)requestToPath:(NSString *)path {
    WTRWeiboRequest *request = [self requestWithAccessToken];
    request.url = [NSString stringWithFormat:@"%@%@", WeiboAPIServerHost, path];
    return request;
}

+ (instancetype)requestWithAccessToken {
    WTRWeiboRequest *request = [WTRWeiboRequest new];
    WTRAuthorizedUserInfo *currentAuthorizedUser = [WTRAuthorizedUser currentAuthorizedUserInfo];
    [request.parameters setObject:WeiboAppKey forKey:@"source"];
    //cancel the authorized processing 
    if (currentAuthorizedUser.wbtoken) {
        [request.parameters setObject:currentAuthorizedUser.wbtoken forKey:@"access_token"];
    }
    return request;
}

- (void)addParameter:(NSString *)name value:(id)value {
    [self.parameters setObject:value forKey:name];
}

- (void)addParameters:(NSDictionary *)parameters {
    [self.parameters addEntriesFromDictionary:parameters];
}


@end
