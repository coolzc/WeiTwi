//
//  NSDictionary+CFUtility.h
//  ChaseFuture
//
//  Created by Sherlock on 11/27/14.
//  Copyright (c) 2014 ChaseFuture. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (WTRUtility)

- (BOOL)booleanForkey:(NSString *)key;

- (NSNumber *)integerForKey:(NSString *)key;
- (NSNumber *)doubleForKey:(NSString *)key;

- (NSString *)stringForKey:(NSString *)key;

- (NSArray *)arrayForKey:(NSString *)key;

- (NSDictionary *)dictionaryForKey:(NSString *)key;

@end
