//
//  WTRInitializationPresenter.h
//  WeiTwi
//
//  Created by zhangcheng on 10/13/15.
//  Copyright © 2015 XYZ. All rights reserved.
//

#import "WTRBasePresenter.h"
#import "WTRProgressViewInterface.h"
#import "WTRDataSyncInteractor.h"

@interface WTRInitializationPresenter : WTRBasePresenter <WTRDataSyncInteractorDelegate>

@property (nonatomic, weak) id<WTRProgressViewInterface>progressView;
@property (nonatomic, strong) WTRDataSyncInteractor *dataSyncInteractor;

@end
