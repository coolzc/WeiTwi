//
//  WTRAuthorizedUser+Utility.m
//  WeiTwi
//
//  Created by zhangcheng on 10/31/15.
//  Copyright © 2015 XYZ. All rights reserved.
//

#import "WTRAuthorizedUser+Utility.h"

@implementation WTRAuthorizedUser (Utility)

- (void)updateWithAuthorizedInfo:(WTRAuthorizedUserInfo *)userinfo {
    self.wbRefreshToken = userinfo.wbRefreshToken;
    self.wbCurrentUserID =userinfo.wbCurrentUserID;
    self.wbtoken = userinfo.wbtoken;
}

- (WTRAuthorizedUserInfo *)authorizedUserInfo {
    WTRAuthorizedUserInfo *authorizedUserInfo = [WTRAuthorizedUserInfo new];
    authorizedUserInfo.wbtoken = self.wbtoken;
    authorizedUserInfo.wbRefreshToken = self.wbRefreshToken;
    authorizedUserInfo.wbCurrentUserID = self.wbCurrentUserID;
    return authorizedUserInfo;
}

@end
