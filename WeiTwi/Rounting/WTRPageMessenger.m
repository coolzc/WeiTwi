//
//  WTRPageMessenger.m
//  WeiTwi
//
//  Created by zhangcheng on 10/10/15.
//  Copyright © 2015 XYZ. All rights reserved.
//

#import "WTRPageMessenger.h"

static NSString *const DefaultName = @"DefaultName";
static NSString *const HomeName = @"Home";
static NSString *const DeckName = @"Deck";

@interface WTRPageMessenger ()

@property (nonatomic, strong) NSString *theName;
@property (nonatomic, strong) NSMutableDictionary *parameters;

@end

@implementation WTRPageMessenger

- (id)init {
    self = [super init];
    if (self) {
        _parameters = [NSMutableDictionary dictionary];
    }
    return self;
}

+ (instancetype)messenger {
    return [self messengerWithName:DefaultName];
}

+ (instancetype)messengerWithName:(NSString *)name {
    WTRPageMessenger *messenger = [WTRPageMessenger new];
    messenger.theName = name;
    return messenger;
}

+ (NSString *)defaultName {
    return DefaultName;
}

+ (NSString *)homeName {
    return HomeName;
}

+ (NSString *)deckName {
    return DeckName;
}

- (void)addParam:(NSString *)name value:(id)value {
    [self.parameters setValue:value forKeyPath:name];
}

- (NSString *)name {
    return self.theName ? self.theName : DefaultName;
}

- (NSDictionary *)params {
    return [NSDictionary dictionaryWithDictionary:self.parameters];
}

@end
