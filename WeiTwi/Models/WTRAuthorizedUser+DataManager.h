//
//  WTRAuthorizedUser+DataManager.h
//  WeiTwi
//
//  Created by zhangcheng on 10/31/15.
//  Copyright © 2015 XYZ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WTRAuthorizedUser.h"
#import "WTRAuthorizedUserInfo.h"

@interface WTRAuthorizedUser (DataManager)

+ (void)saveLoginUserInfo:(WTRAuthorizedUserInfo *)userInfo completion:(void(^)(BOOL success, NSError *error))completion;
+ (WTRAuthorizedUserInfo *)currentAuthorizedUserInfo;

@end
