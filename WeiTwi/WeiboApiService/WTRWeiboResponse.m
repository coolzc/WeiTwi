//
//  WTRWeiboResponse.m
//  WeiTwi
//
//  Created by zhangcheng on 11/4/15.
//  Copyright © 2015 XYZ. All rights reserved.
//

#import "WTRWeiboResponse.h"
#import "NSDictionary+WTRUtility.h"

//TODO : to change to align to the weibo open dev

static const NSInteger CodeSuccess = 20200;
static const NSInteger CodeNotAllowed = 20405;
static const NSInteger CodeNotAcceptable = 20406;
static const NSInteger CodeMissingData = 20460;
static const NSInteger CodeNotExists = 20461;
static const NSInteger CodeNotMatch = 20462;
static const NSInteger CodeInternalError = -1;

@implementation WTRWeiboResponse

+ (instancetype)responseWithResponseData:(NSDictionary *)data {
    WTRWeiboResponse *response = [WTRWeiboResponse new];
    response.code = [[data stringForKey:@"code"] integerValue];
    response.message = [data stringForKey:@"message"];
    return response;
}

+ (instancetype)responseWithErrorMessage:(NSString *)message {
    WTRWeiboResponse *response = [WTRWeiboResponse new];
    response.code = CodeInternalError;
    response.message = message;
    return response;
}

- (BOOL)isSuccess {
    return CodeSuccess == self.code;
}

- (BOOL)isNotAllowed {
    return CodeNotAllowed == self.code;
}

- (BOOL)isNotAcceptable {
    return CodeNotAcceptable == self.code;
}

- (BOOL)isMissigData {
    return CodeMissingData == self.code;
}

- (BOOL)isNotExists {
    return CodeNotExists == self.code;
}

- (BOOL)isNotMatch {
    return CodeNotMatch == self.code;
}

- (BOOL)isInternalError {
    return CodeInternalError == self.code;
}

@end
