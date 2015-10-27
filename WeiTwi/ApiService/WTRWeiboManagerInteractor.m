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
static NSString *const BaseUrl = @"https://api.weibo.com/2";
static NSString *const HomeTimelinePath = @"/statuses/public_timeline.json";


@interface WBBaseRequest ()
- (void)debugPrint;
@end

@interface WBBaseResponse ()
- (void)debugPrint;
@end

@interface WTRWeiboManagerInteractor ()

@property (nonatomic, strong) NSArray *receivedData;
@property (nonatomic, strong) NSString *url;

@end

@implementation WTRWeiboManagerInteractor

- (instancetype)init {
    self = [super init];
    if (self) {
        _receivedData = [NSArray new];
        _url = [NSString new];
        _wbCurrentUserID = [NSString new];
        _wbRefreshToken = [NSString new];
        _wbtoken = [NSString new];
    }
    return self;
}

+ (id)weiboInteractorWithDeleate:(id <WTRWeiboManagerDelegate>)delegate {
    WTRWeiboManagerInteractor *weiboInteractor = [self new];
    weiboInteractor.delegate = delegate;
    return weiboInteractor;
}

#pragma mark - WeiboSDKDelegate

- (void)didReceiveWeiboResponse:(WBBaseResponse *)response {
    if ([response isKindOfClass:WBSendMessageToWeiboResponse.class]) {
        NSString *title = NSLocalizedString(@"发送结果", nil);
        NSString *message = [NSString stringWithFormat:@"%@: %d\n%@: %@\n%@: %@", NSLocalizedString(@"响应状态", nil), (int)response.statusCode, NSLocalizedString(@"响应UserInfo数据", nil), response.userInfo, NSLocalizedString(@"原请求UserInfo数据", nil),response.requestUserInfo];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                        message:message
                                                       delegate:nil
                                              cancelButtonTitle:NSLocalizedString(@"确定", nil)
                                              otherButtonTitles:nil];
        WBAuthorizeResponse* authorizedResponse = (WBAuthorizeResponse*)response;
        if (authorizedResponse.accessToken) {
            self.wbtoken = authorizedResponse.accessToken;
        }
        if (authorizedResponse.userID) {
            self.wbCurrentUserID = authorizedResponse.userID;
        }
        [alert show];
    } else if ([response isKindOfClass:WBAuthorizeResponse.class]) {
        NSString *title = NSLocalizedString(@"认证结果", nil);
        NSString *message = [NSString stringWithFormat:@"%@: %d\nresponse.userId: %@\nresponse.accessToken: %@\n%@: %@\n%@: %@", NSLocalizedString(@"响应状态", nil), (int)response.statusCode,[(WBAuthorizeResponse *)response userID], [(WBAuthorizeResponse *)response accessToken],  NSLocalizedString(@"响应UserInfo数据", nil), response.userInfo, NSLocalizedString(@"原请求UserInfo数据", nil), response.requestUserInfo];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                        message:message
                                                       delegate:nil
                                              cancelButtonTitle:NSLocalizedString(@"确定", nil)
                                              otherButtonTitles:nil];
        
        if (response.statusCode == -1) {
            NSLog(@"登录失败");
        } else {
            NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
            [user setObject:[(WBAuthorizeResponse *)response accessToken] forKey:@"token"];
            [user setObject:[(WBAuthorizeResponse *)response userID] forKey:@"userId"];
            [user setObject:@"1" forKey:@"login"];
            [user synchronize];
        }

        self.wbtoken = [(WBAuthorizeResponse *)response accessToken];
        self.wbCurrentUserID = [(WBAuthorizeResponse *)response userID];
        self.wbRefreshToken = [(WBAuthorizeResponse *)response refreshToken];
        [alert show];
    } else if ([response isKindOfClass:WBSDKAppRecommendResponse.class]) {
        NSString *title = NSLocalizedString(@"邀请结果", nil);
        NSString *message = [NSString stringWithFormat:@"accesstoken:\n%@\nresponse.StatusCode: %d\n响应UserInfo数据:%@\n原请求UserInfo数据:%@",[(WBSDKAppRecommendResponse *)response accessToken],(int)response.statusCode,response.userInfo,response.requestUserInfo];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                        message:message
                                                       delegate:nil
                                              cancelButtonTitle:NSLocalizedString(@"确定", nil)
                                              otherButtonTitles:nil];
        [alert show];
    }
}

- (void)didReceiveWeiboRequest:(WBBaseRequest *)request {

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

- (void)requestForUserTimeline:(NSString *)groupName {
    if ([self.delegate respondsToSelector:@selector(weiboServiceDidFinishRequestWithResponse:)]) {
        [self.delegate weiboServiceDidFinishRequestWithResponse:self.receivedData];
    }
}



#pragma mark - Private Methods

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
    NSDictionary *dicFormat = @{@"source":WeiboAppKey,@"access_token":self.wbtoken,@"count":@"30"};
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
