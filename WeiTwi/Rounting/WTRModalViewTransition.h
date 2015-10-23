//
//  WTRModalViewTransition.h
//  WeiTwi
//
//  Created by zhangcheng on 10/16/15.
//  Copyright © 2015 XYZ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "WTRConfig.h"

@interface WTRModalViewTransition : NSObject <UIViewControllerAnimatedTransitioning>

@property (readonly, nonatomic, assign) WTRTransitionType type;
@property (readonly, nonatomic, assign) WTRTransitionDirection moveInDirection;

+ (instancetype)moveInTransitionType:(WTRTransitionType)type direction:(WTRTransitionDirection)direction;

@end
