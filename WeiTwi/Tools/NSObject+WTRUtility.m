//
//  NSObject+WTRUtility.m
//  WeiTwi
//
//  Created by zhangcheng on 11/24/15.
//  Copyright © 2015 XYZ. All rights reserved.
//

#import "NSObject+WTRUtility.h"
#import <objc/runtime.h>

@implementation NSObject (WTRUtility)

- (NSDictionary *)properties_aps {
    NSMutableDictionary *props = [NSMutableDictionary dictionary];
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
    for (i = 0; i<outCount; i++) {
        objc_property_t property = properties[i];
        const char* char_f =property_getName(property);
        NSString *propertyName = [NSString stringWithUTF8String:char_f];
        id propertyValue = [self valueForKey:(NSString *)propertyName];
        if (propertyValue) [props setObject:propertyValue forKey:propertyName];
    }
    free(properties);
    return props;
}

@end
