//
//  UINib+WeiTwi.m
//  WeiTwi
//
//  Created by zhangcheng on 10/12/15.
//  Copyright © 2015 XYZ. All rights reserved.
//

#import "UINib+WeiTwi.h"

static NSString* const UserGroupListCellNibName = @"WTRDecListTableViewCell";
static NSString* const StatusPhotoCellNibName = @"WTRStatusPhotosCollectionViewCell";
static NSString* const TimelineCellNibName = @"WTRTimelineCell";
@implementation UINib (WeiTwi)

+ (instancetype)nibForUserGroupCell {
    return [self nibWithNibName:UserGroupListCellNibName bundle:nil];
}

+ (instancetype)nibForStatusPhotoCell {
    return [self nibWithNibName:StatusPhotoCellNibName bundle:nil];
}

+ (instancetype)nibForTimelineCell {
    return [self nibWithNibName:TimelineCellNibName bundle:nil];
}

@end
