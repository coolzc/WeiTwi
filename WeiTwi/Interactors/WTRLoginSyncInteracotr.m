//
//  WTRLoginSyncInteracotr.m
//  WeiTwi
//
//  Created by zhangcheng on 11/2/15.
//  Copyright © 2015 XYZ. All rights reserved.
//

#import "WTRLoginSyncInteracotr.h"
#import "WTRWeiboApiService.h"
#import "AppDelegate.h"
#import "WBHttprequest.h"
#import "WTRConfig.h"
#import "WTRWeiboSDKDelegate.h"
#import "WTRAuthorizedUser+DataManager.h"

@interface WTRLoginSyncInteracotr ()

@property (nonatomic, strong) WTRAuthorizedUserInfo *authorizedUserInfo;

@end

@implementation WTRLoginSyncInteracotr

- (instancetype)init {
    self = [super init];
    if (self) {
        //the weibo api is very ugly
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        appDelegate.weiboSDKDelegate.delegate = self;
        _authorizedUserInfo = [WTRAuthorizedUserInfo new];
    }
    return self;
}

- (void)syncLoginWeiboAuthorized {
    [self startLoginAuthorizedWeiboUser];
}

#pragma mark - WeiboUserAuthorizedDelegate

- (void)weiboAuthorizedWithUserToken:(NSString *)wbToken wbRefreshToken:(NSString *)wbRefreshToken wbCurrentUserID:(NSString *)wbCurrentUserID {
    self.authorizedUserInfo.wbtoken = wbToken;
    self.authorizedUserInfo.wbCurrentUserID = wbCurrentUserID;
    self.authorizedUserInfo.wbRefreshToken = wbRefreshToken;
    [self saveAuthorizedUser];
}

#pragma mark - Privata Methods

- (void)startLoginAuthorizedWeiboUser {
    if ([self.loginDelegate respondsToSelector:@selector(loginSyncInteractorDidStartSync:)]) {
        [self.loginDelegate loginSyncInteractorDidStartSync:self];
    }
    [self ssoAuthorizedRequest];
}

- (void)finishLoginAuthorizedWeiboUser {
    if ([self.loginDelegate respondsToSelector:@selector(loginSyncInteractorDidFinishSync:)]) {
        [self.loginDelegate loginSyncInteractorDidFinishSync:self];
    }
}

- (void)ssoAuthorizedRequest {
    WBAuthorizeRequest *request = [WBAuthorizeRequest request];
    request.redirectURI = kRedirectURI;
    request.scope = @"all";
    //    request.userInfo = @{@"SSO_From": @"WTRWeiboManagerInteractor",
    //                         @"Other_Info_1": [NSNumber numberWithInt:123],
    //                         @"Other_Info_2": @[@"obj1", @"obj2"],
    //                         @"Other_Info_3": @{@"key1": @"obj1", @"key2": @"obj2"}};
    [WeiboSDK sendRequest:request];
}

- (void)saveAuthorizedUser {
    [WTRAuthorizedUser saveLoginUserInfo:self.authorizedUserInfo completion:nil];
    [self finishLoginAuthorizedWeiboUser];
}


@end
