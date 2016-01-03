//
//  WTRConfig.h
//  WeiTwi
//
//  Created by zhangcheng on 10/10/15.
//  Copyright © 2015 XYZ. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef NS_OPTIONS(NSUInteger, PNParamFlags) {
    WTRParamFlagsNone                = 0,
    WTRParamFlagsAutoEditing         = 1 << 0
};

typedef enum {
    WTRTransitionShow,//push or present
    WTRTransitionDismiss,
    WTRTransitionPop,
} WTRTransitionType;

typedef enum {
    WTRTransitionFromLeft,
    WTRTransitionFromRight,
    WTRTransitionFromTop,
    WTRTransitionFromBottom,
} WTRTransitionDirection;

extern NSString *const WeiboAppKey;
extern NSString *const kRedirectURI;
extern NSString *const WeiboAPIServerHost;

static NSUInteger const WeiboStatusesDisplayedNumbers = 3;

extern NSString *const TwitterConsumerKey;
extern NSString *const TwitterConsumerSecret;