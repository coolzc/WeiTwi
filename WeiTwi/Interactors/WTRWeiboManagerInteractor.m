//
//  WTRWeiboManager.m
//  WeiTwi
//
//  Created by zhangcheng on 10/24/15.
//  Copyright © 2015 XYZ. All rights reserved.
//

#import "WTRWeiboManagerInteractor.h"
#import "WBHttprequest.h"
#import "WTRConfig.h"
#import "WTRWeiboSDKDelegate.h"
#import "WTRAuthorizedUser+DataManager.h"

static NSString *const BaseUrl = @"https://api.weibo.com/2";
static NSString *const HomeTimelinePath = @"/statuses/home_timeline.json";
static NSString *const UserTimelinPath = @"/statuses/user_timeline.json";

@interface WTRWeiboManagerInteractor ()

@property (nonatomic, strong) NSArray *receivedData;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) WTRAuthorizedUserInfo *authorizedUserInfo;


@end

@implementation WTRWeiboManagerInteractor

- (instancetype)init {
    self = [super init];
    if (self) {
        _receivedData = [NSArray new];
        _url = [NSString new];
        _authorizedUserInfo = [WTRAuthorizedUserInfo new];
    }
    return self;
}

+ (id)weiboInteractorWithDeleate:(id <WTRWeiboManagerDelegate>)delegate {
    WTRWeiboManagerInteractor *weiboInteractor = [self new];
    weiboInteractor.delegate = delegate;
    return weiboInteractor;
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

#pragma mark - WeiboUserAuthorizedDelegate

- (void)authorizedWeiboUserToken:(NSString *)wbToken wbRefreshToken:(NSString *)wbRefreshToken wbCurrentUserID:(NSString *)wbCurrentUserID {
    self.authorizedUserInfo.wbtoken = wbToken;
    self.authorizedUserInfo.wbCurrentUserID = wbCurrentUserID;
    self.authorizedUserInfo.wbRefreshToken = wbRefreshToken;
    [self saveAuthorizedUser];
}

#pragma mark - Public Methods

- (void)sendRequest:(WTRWeiboRequestType)apiRequest {
    switch (apiRequest) {
        case WTRWeiboRequestSSO:
            [self ssoAuthorizedRequest];
            break;
        case WTRWeiboRequestHomeTimeline:
            self.url = [BaseUrl stringByAppendingString:HomeTimelinePath];
            [self homeTimelineRequest];
            break;
            
        default:
            break;
    }
}

#pragma mark - Private Methods

- (void)saveAuthorizedUser {
    [WTRAuthorizedUser saveLoginUserInfo:self.authorizedUserInfo completion:nil];
}

- (void)ssoAuthorizedRequest {
    WBAuthorizeRequest *request = [WBAuthorizeRequest request];
    request.redirectURI = kRedirectURI;
    request.scope = @"all";
//    request.userInfo = @{@"SSO_From": @"WTRWeiboManagerInteractor",
//                         @"Other_Info_1": [NSNumber numberWithInt:123],
//                         @"Other_Info_2": @[@"obj1", @"obj2"],
//                         @"Other_Info_3": @{@"key1": @"obj1", @"key2": @"obj2"}};
    [WeiboSDK sendRequest:request];
}

- (void)homeTimelineRequest {
    NSDictionary *dicFormat = @{@"source":WeiboAppKey,@"access_token":self.authorizedUserInfo.wbtoken,@"count":@"30"};
    [WBHttpRequest requestWithURL:self.url
                       httpMethod:@"GET"
                           params:dicFormat
                            queue:nil
            withCompletionHandler:^(WBHttpRequest *httpRequest, id result, NSError *error) {
                if (error) {
                    NSLog(@"%@",error);
                } else {
                    self.receivedData = result[@"statuses"];
                    if ([self.delegate respondsToSelector:@selector(weiboServiceDidFinishRequestWithResponse:)]) {
                        [self.delegate weiboServiceDidFinishRequestWithResponse:self.receivedData];
                    }
                }
            }];
}



@end
