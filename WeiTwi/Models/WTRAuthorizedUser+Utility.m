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
    self.wbRefreshToken = userinfo.wbtoken;
    self.wbCurrentUserID =userinfo.wbCurrentUserID;
    self.wbtoken = userinfo.wbtoken;
}

@end
