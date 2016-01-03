//
//  WTRSplashScreenViewController.m
//  WeiTwi
//
//  Created by zhangcheng on 10/13/15.
//  Copyright © 2015 XYZ. All rights reserved.
//

#import "WTRSplashScreenViewController.h"

@implementation WTRSplashScreenViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.splashImageLeftContraint.constant = 0.f;
    self.splashImageTopContraint.constant = 0.f;
    [self.view layoutIfNeeded];
    [UIView animateWithDuration:6.f animations:^{
        self.splashImageTopContraint.constant = -160.f;
        self.splashImageLeftContraint.constant = -140.f;
        [self.view layoutIfNeeded];
    }];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.splashImageView.layer removeAllAnimations];
}

- (NSArray *)presenters {
    return @[self.initializaitonPresenter];
}

#pragma mark - Actions

- (IBAction)loginButtonTouchUpInside:(id)sender {
    [self.initializaitonPresenter loginWeiboAuthorizedUser];
}

#pragma mark - WTRProgressViewInterface

- (void)beginProgress {
    self.textLabel.hidden = NO;
}

- (void)endProgress {
    self.textLabel.hidden = YES;
}

- (void)updateProgress:(CGFloat)progress message:(NSString *)message {
    NSInteger percentage = (int)(progress * 100);
    self.textLabel.text = [NSString stringWithFormat:@"%@ %lu%%", message, (long)percentage];
}

@end
