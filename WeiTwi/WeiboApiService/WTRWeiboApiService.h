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

typedef enum {
    WTRWeiboRequestSSO,
    WTRWeiboRequestHomeTimeline,
} WTRWeiboRequestType;

typedef enum {
    WTRWeiboRequestMethodGet,
    WTRWeiboRequestMethodPost,
    WTRWeiboRequestMethodDelete,
    WTRWeiboRequestMethodPut,
} WTRWeiboRequestMethod;

@protocol WTRWeiboApiServiceDelegate;

@interface WTRWeiboApiService : NSObject 

@property (nonatomic, weak) id<WTRWeiboApiServiceDelegate> delegate;

+ (id)weiboApiServiceWithDeleate:(id <WTRWeiboApiServiceDelegate>)delegate;
- (void)sendRequest:(WTRWeiboRequestType)apiRequest;

@end

@protocol WTRWeiboApiServiceDelegate <NSObject>

- (void)weiboServiceDidFinishRequestWithResponse:(id)responseObject;

@end