
#import "WTRApiRequest+BuildFactory.h"
#import "NSDictionary+WTRUtility.h"
#import "WTRWeiboUserInfo+ResponseParser.h"
#import "WTRWeiboUserInfo.h"

static NSString *const CreateAccountPath = @"/users";
static NSString *const LoginPath = @"/users/login";
static NSString *const FriendTimeline = @"statuses/friends_timeline";

NSString *const APIServerHost = @"https://api.weibo.com/2";
//NSString *const APIAccessToken = @"5HUFQJS9COPMB8I0G3YLZ6NAR71V4D2ETWXK";

@implementation WTRApiRequest (BuildFactory)

+ (instancetype)requestForLoginWithAccount:(NSString *)account password:(NSString *)password {
  WTRApiRequest *request = [self requestForPath:LoginPath type:WTRApiRequestLogin method:WTRApiRequestMethodPost];
  NSDictionary *data = @{@"email" : account, @"password" : password};
  request.body = [self rawJSONDataOfObject:data];
  request.responseParser = ^id(NSDictionary *data) {
    return [WTRWeiboUserInfo infoFromDictionaryData:data];
  };
  return request;
}

+ (instancetype)requestForCreateAccountWithEmail:(NSString *)email password:(NSString *)password {
  WTRApiRequest *request = [self requestForPath:CreateAccountPath type:WTRApiRequestCreateAccount method:WTRApiRequestMethodPost];
  NSDictionary *data = @{@"email" : email, @"password" : password};
  request.body = [self rawJSONDataOfObject:data];
  request.responseParser = ^id(NSDictionary *data) {
    return [WTRWeiboUserInfo infoFromDictionaryData:data];
  };
  return request;
}


#pragma mark - Private Method

+ (instancetype)requestForAuthoredPath:(NSString *)path type:(WTRApiRequestType)type method:(WTRApiRequestMethod)method {
  WTRApiRequest *request = [self requestForPath:path type:type method:method];
  //[request addUserToken];
  return request;
}

+ (instancetype)requestForPath:(NSString *)path type:(WTRApiRequestType)type method:(WTRApiRequestMethod)method {
  WTRApiRequest *request = [self requestToPath:path];
  request.type = type;
  request.method = method;
  return request;
}

+ (instancetype)requestToPath:(NSString *)path {
  WTRApiRequest *request = [WTRApiRequest new];
  request.url = [NSString stringWithFormat:@"%@%@", APIServerHost, path];
  return request;
}

+ (NSData *)rawJSONDataOfObject:(id)obj {
  NSError *error = nil;
  NSData *jsonData = [NSJSONSerialization dataWithJSONObject:obj options:0 error:&error];
  return error ? nil : jsonData;
}

@end
