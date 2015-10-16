//
//  WTRBaseViewController.h
//  WeiTwi
//
//  Created by zhangcheng on 10/10/15.
//  Copyright © 2015 XYZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WTRBaseViewController : UIViewController

@property (nonatomic, assign) BOOL needInstantAnimation; // default NO
@property (nonatomic, assign) BOOL needObserveKeyboardAppearance; // default NO
@property (nonatomic, assign) BOOL needTapAnywhereToHideKeyboard; // default NO

@property (nonatomic, strong) NSDictionary *params;

- (NSArray *)presenters; // Overwrite this method to return all the presetners that want to have view related call backs, like viewDidLoad: etc.

- (void)keyboardWillShow:(NSNotification *)notification;
- (void)keyboardWillHide:(NSNotification *)notification;

- (CGFloat)animateDuration:(CGFloat)duration;


@end
