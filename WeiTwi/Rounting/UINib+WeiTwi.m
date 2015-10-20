//
//  UINib+WeiTwi.m
//  WeiTwi
//
//  Created by zhangcheng on 10/12/15.
//  Copyright © 2015 XYZ. All rights reserved.
//

#import "UINib+WeiTwi.h"

static NSString* const UserGroupListCellNibName = @"WTRDecListTableViewCell";

@implementation UINib (WeiTwi)

+ (instancetype)nibForUserGroupCell {
    return [self nibWithNibName:UserGroupListCellNibName bundle:nil];
}

@end
