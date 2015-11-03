//
//  WTRWeiboManager.m
//  WeiTwi
//
//  Created by zhangcheng on 10/24/15.
//  Copyright © 2015 XYZ. All rights reserved.
//

#import "WTRWeiboApiService.h"
#import "WBHttprequest.h"
#import "WTRConfig.h"
#import "WTRWeiboSDKDelegate.h"
#import "WTRAuthorizedUser.h"
#import "WTRAuthorizedUser+DataManager.h"
#import "WTRWeiboStatusInfo+ResponseParser.h"

static NSString *const BaseUrl = @"https://api.weibo.com/2";
static NSString *const HomeTimelinePath = @"/statuses/home_timeline.json";
static NSString *const UserTimelinPath = @"/statuses/user_timeline.json";

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

- (void)sendRequest:(WTRWeiboRequestType)apiRequest {
    switch (apiRequest) {
        case WTRWeiboRequestHomeTimeline:
            self.url = [BaseUrl stringByAppendingString:HomeTimelinePath];
            [self homeTimelineRequest];
            break;
            
        default:
            break;
    }
}

#pragma mark - Private Methods
//TODO: to get from coredata authorizedUserInfo
- (void)homeTimelineRequest {
   WTRAuthorizedUserInfo *currentAuthorizedUser = [WTRAuthorizedUser currentAuthorizedUserInfo];
    NSDictionary *dicFormat = @{@"source":WeiboAppKey,@"access_token":currentAuthorizedUser.wbtoken,@"count":@"30"};
    [WBHttpRequest requestWithURL:self.url
                       httpMethod:@"GET"
                           params:dicFormat
                            queue:nil
            withCompletionHandler:^(WBHttpRequest *httpRequest, id result, NSError *error) {
                if (error) {
                    NSLog(@"%@",error);
                } else {
                    if ([self.delegate respondsToSelector:@selector(weiboServiceDidFinishRequestWithResponse:)]) {
                        [self.delegate weiboServiceDidFinishRequestWithResponse:result];
                    }
                }
            }];
}



@end
