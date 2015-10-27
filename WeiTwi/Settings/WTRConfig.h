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

//extern NSString *const ThirdPartyServiceFlurryToken;
//
//extern NSString *const ParamKeyCardInfo;
//extern NSString *const ParamKeyCardInfos;
//extern NSString *const ParamKeyDeckInfo;
//extern NSString *const ParamKeyIndex;
//extern NSString *const ParamKeyTitleName;
//extern NSString *const ParamKeyFlags;
//extern NSString *const ParamKeyExploreAlbum;
//extern NSString *const ParamKeyPhotoSetInfo;
//extern NSString *const ParamKeySearchTags;
//
//extern NSString *const NotificationNameUpdateCard;
//extern NSString *const NotificationNameUnboundCard;
//extern NSString *const NotificationNameUpdateDeck;
//extern NSString *const NotificationNameAnalyseSubscriptionEvent;
//extern NSString *const NotificationNameAnalyseLocation;
//extern NSString *const NotificationNameAnalyseExplore;
//extern NSString *const NotificationNameServiceMining;
//extern NSString *const NotificationNameUpdateSearchTag;
//
//extern NSString *const UserInfoKeyPictureUrlKeyedCardInfoMap;
//extern NSString *const UserInfoKeyCardInfoSet;
//extern NSString *const UserInfoKeyBoundDeckInfo;
//extern NSString *const UserInfoKeyUpdatedDeckInfo;
//extern NSString *const UserInfoKeyUpdatedDeckIds;
//extern NSString *const UserInfoKeySearchText;
//
//extern NSString *const UserDefaultesKeyMomentLastAnalysedAssetDate;
//extern NSString *const UserDefaultesKeyExploreLastAnalysedAssetDate;
//extern NSString *const UserDefaultesKeyGridNumberOption;
//extern NSString *const UserDefaultesKeyIntroSkip;
//extern NSString *const UserDefaultesKeySelectionSkip;

extern NSString *const WeiboAppKey;
extern NSString *const kRedirectURI;
extern NSString *const SettingKeyLastWeiboContentUpdateTimestamp;
