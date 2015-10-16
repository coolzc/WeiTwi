//
//  NSUserDefaults+CFUtility.m
//  ChaseFuture
//
//  Created by Sherlock on 12/22/14.
//  Copyright (c) 2014 ChaseFuture. All rights reserved.
//

#import "NSUserDefaults+CFUtility.h"

@implementation NSUserDefaults (CFUtility)

+ (NSNumber *)getTimestampByKey:(NSString *)key {
  NSNumber *timestamp = [[self standardUserDefaults] objectForKey:key];
  return timestamp;
}

+ (void)saveTimestamp:(NSNumber *)timestamp forKey:(NSString *)key {
  NSUserDefaults *userDefaultes = [self standardUserDefaults];
  [userDefaultes setObject:timestamp forKey:key];
  [userDefaultes synchronize];
}

@end
