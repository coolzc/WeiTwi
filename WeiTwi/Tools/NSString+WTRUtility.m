//
//  NSString+CFUtility.m
//  ChaseFuture
//
//  Created by Sherlock on 9/3/14.
//  Copyright (c) 2014 ChaseFuture. All rights reserved.
//

#import "NSString+WTRUtility.H"

@implementation NSString (WTRUtility)

- (NSString *)conj:(NSString *)str {
  return [NSString stringWithFormat:@"%@%@", self, str];
}

- (NSString *)youkuVideoIdFromURL {
  static NSRegularExpression *regex = nil;
  if (!regex) {
    regex = [NSRegularExpression regularExpressionWithPattern:@"/sid/(\\w+)/" options:0 error:nil];
  }
  NSString *videoId = nil;
  NSTextCheckingResult *match = [regex firstMatchInString:self options:0 range:NSMakeRange(0, [self length])];
  if (match) {
    videoId = [self substringWithRange:[match rangeAtIndex:1]];
  }
  return videoId;
}

- (NSString *)htmlStringWithFontSize:(long)fontSize {
  return [NSString stringWithFormat:@"<html>\n<head>\n<style type=\"text/css\">\n"
          "body {font-size: %lupx; padding: 30px;}\n</style>\n</head>\n<body>%@</body>\n</html>", fontSize, self];
}

- (BOOL)isNotBlank {
  BOOL isNotBlank = NO;
  NSCharacterSet *whitespace = [NSCharacterSet whitespaceAndNewlineCharacterSet];
  NSString *trimmed = [self stringByTrimmingCharactersInSet:whitespace];
  if ([trimmed length] > 0) {
    isNotBlank = YES;
  }
  return isNotBlank;
}

- (BOOL)isContain:(NSString *)subString {
  return [self rangeOfString:subString].location == NSNotFound ? NO : YES;
}

@end
