//
//  WTRTimeLineListPresenter.m
//  WeiTwi
//
//  Created by zhangcheng on 10/20/15.
//  Copyright © 2015 XYZ. All rights reserved.
//

#import "WTRTimeLineListPresenter.h"
#import "WTRWireframe.h"

@implementation WTRTimeLineListPresenter

- (void)viewDetailOfTimelineWeibo:(NSArray *)weibo {
//    [WTRWireframe moveToNextPageOfViewController:self.mainViewController];
}

- (void)viewGroupDeckListDetail {
    [WTRWireframe moveToDeckViewController:self.mainViewController Messenger:[WTRPageMessenger messenger]];
}

@end
