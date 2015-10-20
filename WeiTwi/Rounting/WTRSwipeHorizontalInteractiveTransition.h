//
//  WTRSwipeHorizontalInteractiveTransition.h
//  WeiTwi
//
//  Created by zhangcheng on 10/20/15.
//  Copyright © 2015 XYZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WTRSwipeHorizontalInteractiveTransition : UIPercentDrivenInteractiveTransition

@property (nonatomic, assign) BOOL interacting;

- (void)wireToViewController:(UIViewController*)viewController;


@end
