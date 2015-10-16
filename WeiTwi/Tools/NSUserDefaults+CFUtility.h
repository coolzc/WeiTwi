//
//  NSUserDefaults+CFUtility.h
//  ChaseFuture
//
//  Created by Sherlock on 12/22/14.
//  Copyright (c) 2014 ChaseFuture. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSUserDefaults (CFUtility)

+ (NSNumber *)getTimestampByKey:(NSString *)key;
+ (void)saveTimestamp:(NSNumber *)timestamp forKey:(NSString *)key;

@end
