//
//  WTRWeiboPrivacey.h
//  WeiTwi
//
//  Created by zhangcheng on 10/30/15.
//  Copyright © 2015 XYZ. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface WTRWeiboPrivacey : NSManagedObject

@property (nonatomic, assign) NSInteger comment;
@property (nonatomic, assign) NSInteger geo;
@property (nonatomic, assign) NSInteger message;
@property (nonatomic, assign) NSInteger realname;
@property (nonatomic, assign) NSInteger badge;
@property (nonatomic, assign) NSInteger mobile;
@property (nonatomic, assign) NSInteger webim;

@end
