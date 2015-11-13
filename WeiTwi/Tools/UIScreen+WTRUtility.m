//
//  UIScreen+WTRUtility.m
//  WeiTwi
//
//  Created by zhangcheng on 11/11/15.
//  Copyright © 2015 XYZ. All rights reserved.
//

#import "UIScreen+WTRUtility.h"

@implementation UIScreen (WTRUtility)

+ (CGRect)bounds {
    return [[self mainScreen] bounds];
}

+ (CGFloat)screenWidth {
    return [[self mainScreen] bounds].size.width;
}

+ (CGFloat)screenHeight {
    return [[self mainScreen] bounds].size.height;
}

+ (BOOL)is3_5InchScreen {
    return 480 == [self screenHeight];
}

+ (BOOL)is4_7InchScreen {
    return 667 == [self screenHeight];
}

+ (BOOL)is5_5InchScreen {
    // Scale is only 3 when not in scaled mode for iPhone 6 Plus
    return 2.9 < [self mainScreen].scale;
}

@end
