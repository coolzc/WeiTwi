//
//  WTRAuthorizedUser+DataManager.m
//  WeiTwi
//
//  Created by zhangcheng on 10/31/15.
//  Copyright © 2015 XYZ. All rights reserved.
//

#import "WTRAuthorizedUser+DataManager.h"
#import <MagicalRecord/MagicalRecord.h>
#import "WTRAuthorizedUser+Utility.h"

@implementation WTRAuthorizedUser (DataManager)

+ (void)saveLoginUserInfo:(WTRAuthorizedUserInfo *)userInfo completion:(void (^)(BOOL, NSError *))completion {
    [MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext) {
        WTRAuthorizedUser *authorizedUser = [WTRAuthorizedUser MR_findFirstInContext:localContext];
        if (!authorizedUser) {
            authorizedUser = [WTRAuthorizedUser MR_createEntityInContext:localContext];
        }
        [authorizedUser updateWithAuthorizedInfo:userInfo];
    } completion:completion];
}

+ (WTRAuthorizedUserInfo *)currentAuthorizedUserInfo {
    WTRAuthorizedUser *user = [WTRAuthorizedUser MR_findFirst];
    return user ? [user authorizedUserInfo] : nil;
}

@end