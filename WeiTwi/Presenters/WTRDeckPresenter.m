//
//  WTRDeckPresenter.m
//  WeiTwi
//
//  Created by zhangcheng on 10/19/15.
//  Copyright © 2015 XYZ. All rights reserved.
//

#import "WTRDeckPresenter.h"

@interface WTRDeckPresenter ()

@property (nonatomic, strong) NSArray *userGroupList;

@end

@implementation WTRDeckPresenter



#pragma mark - Helper Methods

- (void)displayGroupList:(NSArray *)list {
    [self.userGroupListDisplay displayUserGroupList:list];
}

@end
