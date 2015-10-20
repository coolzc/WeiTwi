//
//  WTRDeckViewInterface.h
//  WeiTwi
//
//  Created by zhangcheng on 10/19/15.
//  Copyright © 2015 XYZ. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol WTRUserGroupListDisplayInterface <NSObject>

@optional

- (void)displayUserGroupList:(NSArray *)deckList;

@end