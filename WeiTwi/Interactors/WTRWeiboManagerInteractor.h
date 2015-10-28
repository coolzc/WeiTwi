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

@protocol WTRWeiboManagerDelegate;

@interface WTRWeiboManagerInteractor : NSObject <WeiboUserInfoDelegate>

@property (nonatomic, strong) NSString *wbtoken;
@property (nonatomic, strong) NSString *wbRefreshToken;
@property (nonatomic, strong) NSString* wbCurrentUserID;
@property (nonatomic, weak) id<WTRWeiboManagerDelegate> delegate;

+ (id)weiboInteractorWithDeleate:(id <WTRWeiboManagerDelegate>)delegate;
- (void)sendRequest:(WTRWeiboRequestType)apiRequest;

@end

@protocol WTRWeiboManagerDelegate <NSObject>

- (void)weiboServiceDidFinishRequestWithResponse:(id)responseObject;

@end