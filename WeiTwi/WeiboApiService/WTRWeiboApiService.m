//
//  WTRWeiboManager.m
//  WeiTwi
//
//  Created by zhangcheng on 10/24/15.
//  Copyright © 2015 XYZ. All rights reserved.
//

/**
*   weibo authorized function is moved to WTRLoginSyncInteracotr,
*   because weibo login authorized code is very apart from the weibo open api source code
**/

#import "WTRWeiboApiService.h"
#import "WBHttprequest.h"
#import "WTRWeiboSDKDelegate.h"

@interface WTRWeiboApiService ()

@property (nonatomic, strong) NSArray *receivedData;
@property (nonatomic, strong) NSString *url;


@end

@implementation WTRWeiboApiService

- (instancetype)init {
    self = [super init];
    if (self) {
        _receivedData = [NSArray new];
        _url = [NSString new];
    }
    return self;
}

+ (id)weiboApiServiceWithDeleate:(id <WTRWeiboApiServiceDelegate>)delegate {
    WTRWeiboApiService *weiboApiService = [self new];
    weiboApiService.delegate = delegate;
    return weiboApiService;
}

#pragma WBHttpRequestDelegate

- (void)request:(WBHttpRequest *)request didFinishLoadingWithResult:(NSString *)result
{
    NSString *title = nil;
    UIAlertView *alert = nil;
    
    title = NSLocalizedString(@"收到网络回调", nil);
    alert = [[UIAlertView alloc] initWithTitle:title
                                       message:[NSString stringWithFormat:@"%@",result]
                                      delegate:nil
                             cancelButtonTitle:NSLocalizedString(@"确定", nil)
                             otherButtonTitles:nil];
    [alert show];
}

- (void)request:(WBHttpRequest *)request didFailWithError:(NSError *)error;
{
    NSString *title = nil;
    UIAlertView *alert = nil;
    
    title = NSLocalizedString(@"请求异常", nil);
    alert = [[UIAlertView alloc] initWithTitle:title
                                       message:[NSString stringWithFormat:@"%@",error]
                                      delegate:nil
                             cancelButtonTitle:NSLocalizedString(@"确定", nil)
                             otherButtonTitles:nil];
    [alert show];
}

#pragma mark - Public Methods

- (void)sendRequest:(WTRWeiboRequest *)apiRequest {
    [WBHttpRequest requestWithURL:apiRequest.url
                       httpMethod:apiRequest.method
                           params:apiRequest.parameters
                            queue:nil
            withCompletionHandler:^(WBHttpRequest *httpRequest, id result, NSError *error) {
                if (!error) {
                    [self finishRequest:apiRequest withResponseObject:result error:nil];
                } else {
                    [self finishRequest:apiRequest withResponseObject:nil error:error];
                }
            }];
}

#pragma mark - Private Methods

- (void)finishRequest:(WTRWeiboRequest *)apiRequest withResponseObject:(id)responseObject error:(NSError *)error {
    WTRWeiboResponse *apiResponse = nil;
    if (responseObject && [responseObject isKindOfClass:[NSDictionary class]]) {
        apiResponse = [WTRWeiboResponse responseWithResponseData:responseObject];
        if (apiRequest.responseParser) {
            apiResponse.responseObject = apiRequest.responseParser((NSDictionary *)responseObject);
        }
    } else {
        apiResponse = [WTRWeiboResponse responseWithErrorMessage:[error description]];
    }
    
    if ([self.delegate respondsToSelector:@selector(weiboServiceDidFinishRequest:withResponse:)]) {
        [self.delegate weiboServiceDidFinishRequest:apiRequest withResponse:apiResponse];
    }
}

@end
