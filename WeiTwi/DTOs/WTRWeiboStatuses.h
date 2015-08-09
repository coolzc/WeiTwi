//
//  WTRWeiboTimeline.h
//  WeiTwi
//
//  Created by zhangcheng on 7/5/15.
//  Copyright (c) 2015 XYZ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WTRWeiboStatuses : NSObject

@property (nonatomic, strong) NSString *createdTime;
@property (nonatomic, strong) NSString *repostCount;
@property (nonatomic, strong) NSString *commentCount;
@property (nonatomic, strong) NSString *text;

@end
