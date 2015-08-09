//
//  WTRUserInfo.m
//  HeinekenGreenRoom
//
//  Created by zhangcheng on 4/23/15.
//  Copyright (c) 2015 MobileNow. All rights reserved.
//

#import "WTRUserInfo.h"
#import "NSString+WTRUtility.h"

@implementation WTRUserInfo

- (BOOL)isLogin {
  return [self.accessToken isNotBlank];
}

@end
