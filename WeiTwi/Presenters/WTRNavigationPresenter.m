//
//  WTRNavigationPresenter.m
//  WeiTwi
//
//  Created by zhangcheng on 10/15/15.
//  Copyright © 2015 XYZ. All rights reserved.
//

#import "WTRNavigationPresenter.h"
#import "WTRWireframe.h"
#import "WTRPageMessenger.h"

@implementation WTRNavigationPresenter

- (void)goBack {
    [WTRWireframe moveToPreviousPageOfViewController:self.mainViewController];
}

- (void)goToNextScreen {
    WTRPageMessenger *messager = [WTRPageMessenger messenger];
    [WTRWireframe moveToNextPageOfViewController:self.mainViewController messenger:messager];
}

@end
