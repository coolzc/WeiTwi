//
//  WTRWeiboResponse.h
//  WeiTwi
//
//  Created by zhangcheng on 11/4/15.
//  Copyright © 2015 XYZ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WTRWeiboResponse : NSObject

@property (nonatomic, assign) NSInteger code;
@property (nonatomic, strong) NSString *message;
@property (nonatomic, strong) id responseObject;

+ (instancetype)responseWithResponseData:(NSDictionary *)data;
+ (instancetype)responseWithErrorMessage:(NSString *)message;

- (BOOL)isSuccess;
- (BOOL)isNotAllowed;
- (BOOL)isNotAcceptable;
- (BOOL)isMissigData;
- (BOOL)isNotExists;
- (BOOL)isNotMatch;
- (BOOL)isInternalError;

@end
