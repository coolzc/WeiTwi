//
//  WTRTwitterManagerInteractor.h
//  WeiTwi
//
//  Created by zhangcheng on 10/27/15.
//  Copyright © 2015 XYZ. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    WTRTwitterRequestLogin,
    WTRTWitterRequestHomeTimeline,
} WTRTwitterRequestType;

typedef enum {
    WTRTwitterRequestMethodGet,
    WTRTwitterRequestMethodPost,
    WTRTwitterRequestMethodDelete,
    WTRTwitterRequestMethodPut,
} WTRTwitterRequestMethod;


@protocol WTRTwitterManagerDelegate;

@interface WTRTwitterManagerInteractor : NSObject

@property (nonatomic, weak) id<WTRTwitterManagerDelegate> delegate;

+ (id)twitterInteractorWithDeleate:(id <WTRTwitterManagerDelegate>)delegate;
- (void)sendRequest:(WTRTwitterRequestType)apiRequest;

@end

@protocol WTRTwitterManagerDelegate <NSObject>

- (void)twitterServiceDidFinishRequestWithResponse:(id)responseObject;

@end