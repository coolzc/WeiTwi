//
//  WTRWeiboComment.h
//  WeiTwi
//
//  Created by zhangcheng on 10/30/15.
//  Copyright © 2015 XYZ. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "WTRWeiboUser.h"
#import "WTRWeiboStatus.h"

@interface WTRWeiboComment : NSManagedObject

@property (nonatomic, retain) NSString *created_at;
@property (nonatomic, assign) NSInteger commentId;
@property (nonatomic, retain) NSString *text;
@property (nonatomic, retain) NSString *source;
@property (nonatomic, retain) WTRWeiboUser *user;
@property (nonatomic, retain) NSString *commentMid;
@property (nonatomic, retain) NSString *idstr;
@property (nonatomic, retain) WTRWeiboStatus *status;
@property (nonatomic, retain) WTRWeiboComment *replyComment;

@end
