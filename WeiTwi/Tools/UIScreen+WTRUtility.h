//
//  UIScreen+WTRUtility.h
//  WeiTwi
//
//  Created by zhangcheng on 11/11/15.
//  Copyright © 2015 XYZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScreen (WTRUtility)

+ (CGRect)bounds;
+ (CGFloat)screenWidth;
+ (CGFloat)screenHeight;

+ (BOOL)is3_5InchScreen;
+ (BOOL)is4_7InchScreen;
+ (BOOL)is5_5InchScreen;


@end
