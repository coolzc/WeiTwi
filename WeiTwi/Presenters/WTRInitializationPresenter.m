//
//  WTRInitializationPresenter.m
//  WeiTwi
//
//  Created by zhangcheng on 10/13/15.
//  Copyright © 2015 XYZ. All rights reserved.
//

#import "WTRInitializationPresenter.h"
#import "WTRWireframe.h"
#import "NSUserDefaults+WRUtility.h"

@interface WTRInitializationPresenter ()

@property (nonatomic, strong)dispatch_queue_t serialQueue;

@end

@implementation WTRInitializationPresenter

- (instancetype)init {
    self = [super init];
    if (self) {
        _serialQueue = dispatch_queue_create("weitwi.initializaiton", DISPATCH_QUEUE_SERIAL);
    }
    return self;
}

- (void)view:(UIViewController *)viewController willAppear:(BOOL)animated {
    [super view:viewController willAppear:animated];
    [self.progressView beginProgress];
    dispatch_async(self.serialQueue, ^{
        sleep(2.5);
    });
    //TODO
    
}

#pragma mark - WTRWeiboLoginInteractorDelegate

- (void)loginSyncInteractorDidStartSync:(WTRLoginSyncInteracotr *)loginSyncInteractor {
    CGFloat randomStartProgress = (arc4random() % 5 + 1) / 100.f;
    [self.progressView updateProgress:randomStartProgress message:NSLocalizedString(@"init-progress-text-begin", nil)];
}

- (void)loginSyncInteractorDidFinishSync:(WTRLoginSyncInteracotr *)loginSyncInteractor {
    [self.progressView updateProgress:1.f message:NSLocalizedString(@"init-progress-text-end", nil)];
    [self.progressView endProgress];
    //TODO
    dispatch_async(self.serialQueue, ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [WTRWireframe moveToNextPageOfViewController:self.mainViewController];
        });
    });
}

#pragma mark - Public Methods

- (void)loginWeiboAuthorizedUser {
    [self.loginSyncInteractor syncLoginWeiboAuthorized];
}

@end
