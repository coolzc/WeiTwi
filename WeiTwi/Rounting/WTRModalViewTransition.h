//
//  WTRModalViewTransition.h
//  WeiTwi
//
//  Created by zhangcheng on 10/16/15.
//  Copyright © 2015 XYZ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef enum {
    WTRTransitionShow,//push or present
    WTRTransitionDismiss,
    WTRTransitionPop,
} WTRTransitionType;

@interface WTRModalViewTransition : NSObject <UIViewControllerAnimatedTransitioning>

@property (readonly, nonatomic, assign) WTRTransitionType type;
@property (readonly, nonatomic, assign) BOOL moveInFromTop;

+ (instancetype)moveInTransitionFromTop:(BOOL)moveInFromTop type:(WTRTransitionType)type;

@end
