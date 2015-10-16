//
//  WTRDataSyncInteractor.h
//  WeiTwi
//
//  Created by zhangcheng on 10/13/15.
//  Copyright © 2015 XYZ. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol WTRDataSyncInteractorDelegate;

@interface WTRDataSyncInteractor : NSObject

@property (nonatomic, assign) BOOL skipSyncMentors;
@property (nonatomic, weak) id<WTRDataSyncInteractorDelegate> delegate;

- (void)syncDataAfterTimestamp:(NSNumber *)timestamp;
//- (NSNumber *)latestSyncArticleTimestamp;
//- (NSNumber *)latestSyncMentorTimestamp;

@end

@protocol WTRDataSyncInteractorDelegate <NSObject>

@optional
- (void)dataSyncInteractorDidStartSync:(WTRDataSyncInteractor *)dataSyncInteractor;
- (void)dataSyncInteractorDidFinishSync:(WTRDataSyncInteractor *)dataSyncInteractor;

//- (void)dataSyncInteractor:(CFDataSyncInteractor *)dataSyncInteractor didSyncArticleDataWithPercentage:(CGFloat)percentage; // percentage value : 0 ~ 1
//- (void)dataSyncInteractor:(CFDataSyncInteractor *)dataSyncInteractor didSyncMentorDataWithPercentage:(CGFloat)percentage; // percentage value : 0 ~ 1

@end
