//
//  WTRTwitterTimelineDisplayInterface.h
//  WeiTwi
//
//  Created by zhangcheng on 10/27/15.
//  Copyright © 2015 XYZ. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol WTRTwitterTimelineDisplayInterface <NSObject>

@optional

- (void)displayTwtitterTimeline:(NSArray *)timeline;

@end