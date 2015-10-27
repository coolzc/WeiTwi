//
//  WTRTwitterManagerInteractor.h
//  WeiTwi
//
//  Created by zhangcheng on 10/27/15.
//  Copyright © 2015 XYZ. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol WTRTwitterManagerDelegate;

@interface WTRTwitterManagerInteractor : NSObject

@property (nonatomic, weak) id<WTRTwitterManagerDelegate> delegate;

@end

@protocol WTRTwitterManagerDelegate <NSObject>

- (void)weiboServiceDidFinishRequestWithResponse:(id)responseObject;

@end