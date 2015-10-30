//
//  AuthorizedUserInfo.h
//  WeiTwi
//
//  Created by zhangcheng on 10/30/15.
//  Copyright © 2015 XYZ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface WTRAuthorizedUser : NSManagedObject

@property (nonatomic, retain) NSString *wbtoken;
@property (nonatomic, retain) NSString *wbRefreshToken;
@property (nonatomic, retain) NSString* wbCurrentUserID;

@end
