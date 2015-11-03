//
//  WTRLoginSyncInteracotr.h
//  WeiTwi
//
//  Created by zhangcheng on 11/2/15.
//  Copyright © 2015 XYZ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WTRWeiboSDKDelegate.h"

@protocol WTRWeiboLoginInteractorDelegate;

@interface WTRLoginSyncInteracotr : NSObject <WeiboUserAuthorizedDelegate>

@property (nonatomic, weak) id<WTRWeiboLoginInteractorDelegate> loginDelegate;

- (void)syncLoginWeiboAuthorized;

@end

@protocol WTRWeiboLoginInteractorDelegate <NSObject>

@optional
- (void)loginSyncInteractorDidStartSync:(WTRLoginSyncInteracotr *)loginSyncInteractor;
- (void)loginSyncInteractorDidFinishSync:(WTRLoginSyncInteracotr *)loginSyncInteractor;

//- (void)dataSyncInteractor:(CFDataSyncInteractor *)dataSyncInteractor didSyncArticleDataWithPercentage:(CGFloat)percentage; // percentage value : 0 ~ 1
//- (void)dataSyncInteractor:(CFDataSyncInteractor *)dataSyncInteractor didSyncMentorDataWithPercentage:(CGFloat)percentage; // percentage value : 0 ~ 1

@end