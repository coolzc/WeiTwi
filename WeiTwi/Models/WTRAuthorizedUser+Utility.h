//
//  WTRAuthorizedUser+Utility.h
//  WeiTwi
//
//  Created by zhangcheng on 10/31/15.
//  Copyright © 2015 XYZ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WTRAuthorizedUser.h"
#import "WTRAuthorizedUserInfo.h"

@interface WTRAuthorizedUser (Utility)

- (void)updateWithAuthorizedInfo:(WTRAuthorizedUserInfo *)userinfo;

@end
