//
//  WTRWeiboSDKDelegate.h
//  WeiTwi
//
//  Created by zhangcheng on 10/28/15.
//  Copyright © 2015 XYZ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WeiboSDK.h"

@protocol WeiboUserAuthorizedDelegate;

@interface WTRWeiboSDKDelegate : NSObject <WeiboSDKDelegate>

@property (nonatomic, strong) NSString *wbtoken;
@property (nonatomic, strong) NSString *wbRefreshToken;
@property (nonatomic, strong) NSString* wbCurrentUserID;

@property (nonatomic, weak) id<WeiboUserAuthorizedDelegate> delegate;

@end

@protocol WeiboUserAuthorizedDelegate <NSObject>

- (void)weiboAuthorizedWithUserToken:(NSString *)wbToken wbRefreshToken:(NSString *)wbRefreshToken wbCurrentUserID:(NSString *)wbCurrentUserID;

@end