//
//  WTRDeckPresenter.h
//  WeiTwi
//
//  Created by zhangcheng on 10/19/15.
//  Copyright © 2015 XYZ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WTRBasePresenter.h"
#import "WTRUserGroupListDisplayInterface.h"

@interface WTRDeckPresenter : WTRBasePresenter

@property (nonatomic, weak) id<WTRUserGroupListDisplayInterface> userGroupListDisplay;

- (void)selectToDisplayGroup:(NSString *)group;

@end
