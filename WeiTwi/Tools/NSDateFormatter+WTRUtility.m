//
//  NSDateFormatter+WTRUtility.m
//  WeiTwi
//
//  Created by zhangcheng on 11/9/15.
//  Copyright © 2015 XYZ. All rights reserved.
//

#import "NSDateFormatter+WTRUtility.h"

@implementation NSDateFormatter (WTRUtility)

+ (NSString *)weiboDateConvertToCustomFormat:(NSString *)weiboTime {
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"EEE MMM d HH:mm:ss Z yyyy";
    dateFormatter.locale=[[NSLocale alloc]initWithLocaleIdentifier:@"en_US"];
    NSDate *weiboDate = [dateFormatter dateFromString:weiboTime];
    
    dateFormatter.dateFormat = @"HH:mm d/m";
    return [dateFormatter stringFromDate:weiboDate];
}

@end
