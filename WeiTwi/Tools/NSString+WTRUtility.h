//
//  NSString+CFUtility.h
//  ChaseFuture
//
//  Created by Sherlock on 9/3/14.
//  Copyright (c) 2014 ChaseFuture. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIkit.h>


@interface NSString (WTRUtility)

- (NSString *)conj:(NSString *)str;

- (NSString *)youkuVideoIdFromURL;
- (NSString *)htmlStringWithFontSize:(long)fontSize;

- (BOOL)isNotBlank;
- (BOOL)isContain:(NSString *)subString;

- (CGFloat)heightOfTextInLabelWithWidth:(CGFloat)width;

@end
