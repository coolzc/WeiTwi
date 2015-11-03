//
//  WTRInitializationPresenter.h
//  WeiTwi
//
//  Created by zhangcheng on 10/13/15.
//  Copyright © 2015 XYZ. All rights reserved.
//

#import "WTRBasePresenter.h"
#import "WTRProgressViewInterface.h"
#import "WTRWeiboApiService.h"
#import "WTRLoginSyncInteracotr.h"

@interface WTRInitializationPresenter : WTRBasePresenter <WTRWeiboLoginInteractorDelegate>

- (void)loginWeiboAuthorizedUser;

@property (nonatomic, weak) id<WTRProgressViewInterface> progressView;
@property (nonatomic, strong) WTRLoginSyncInteracotr *loginSyncInteractor;

@end
