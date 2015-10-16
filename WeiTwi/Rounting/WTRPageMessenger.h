//
//  WTRPageMessenger.h
//  WeiTwi
//
//  Created by zhangcheng on 10/10/15.
//  Copyright © 2015 XYZ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WTRPageMessenger : NSObject

+ (instancetype)messenger;
+ (instancetype)messengerWithName:(NSString *)name;

+ (NSString *)defaultName;
+ (NSString *)homeName;
+ (NSString *)deckName;

- (void)addParam:(NSString *)name value:(id)value;

- (NSString *)name;
- (NSDictionary *)params;

@end
