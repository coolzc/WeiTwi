//
//  WTRAuthorizedUserInfo.h
//  WeiTwi
//
//  Created by zhangcheng on 10/30/15.
//  Copyright © 2015 XYZ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WTRAuthorizedUserInfo : NSObject

@property (nonatomic, strong) NSString *wbtoken;
@property (nonatomic, strong) NSString *wbRefreshToken;
@property (nonatomic, strong) NSString* wbCurrentUserID;


@end
