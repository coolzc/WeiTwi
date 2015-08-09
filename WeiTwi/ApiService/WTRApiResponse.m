

#import "WTRApiResponse.h"
#import "NSDictionary+WTRUtility.h"

//static const NSInteger CodeSuccess = 200;
//static const NSInteger CodeNotAllowed = 405;
//static const NSInteger CodeNotAcceptable = 406;
//static const NSInteger CodeMissingData = 460;
//static const NSInteger CodeNotExists = 461;
//static const NSInteger CodeNotMatch = 462;
static const NSInteger CodeInternalError = -1;


@implementation WTRApiResponse

+ (instancetype)responseWithErrorMessage:(NSString *)message {
  WTRApiResponse *response = [WTRApiResponse new];
  response.code = CodeInternalError;
  response.message = message;
  return response;
}

+ (instancetype)responseWithResponseData:(NSDictionary *)data {
  WTRApiResponse *response = [WTRApiResponse new];
  response.code = [[data integerForKey:@"code"] integerValue];
  response.message = [data stringForKey:@"message"];
  return response;
}

/**
- (BOOL)isSuccess {
  return CodeSuccess == self.code;
}

- (BOOL)isNotAllowed {
  return CodeNotAllowed == self.code;
}

- (BOOL)isNotAcceptable {
  return CodeNotAcceptable == self.code;
}

- (BOOL)isMissigData {
  return CodeMissingData == self.code;
}

- (BOOL)isNotExists {
  return CodeNotExists == self.code;
}

- (BOOL)isNotMatch {
  return CodeNotMatch == self.code;
}

- (BOOL)isInternalError {
  return CodeInternalError == self.code;
}
**/

@end
