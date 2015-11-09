//
//  WTRWeiboManager.h
//  WeiTwi
//
//  Created by zhangcheng on 10/24/15.
//  Copyright © 2015 XYZ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WeiboSDK.h"
#import "WTRWeiboSDKDelegate.h"
#import "WTRWeiboRequest.h"
#import "WTRWeiboResponse.h"

@protocol WTRWeiboApiServiceDelegate;

@interface WTRWeiboApiService : NSObject 

@property (nonatomic, weak) id<WTRWeiboApiServiceDelegate> delegate;

+ (id)weiboApiServiceWithDeleate:(id <WTRWeiboApiServiceDelegate>)delegate;
- (void)sendRequest:(WTRWeiboRequest *)apiRequest;

@end

@protocol WTRWeiboApiServiceDelegate <NSObject>

- (void)weiboServiceDidFinishRequest:(WTRWeiboRequest *)request withResponse:(WTRWeiboResponse *)response;

@end