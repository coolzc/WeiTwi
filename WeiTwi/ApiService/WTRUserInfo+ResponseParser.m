

#import "WTRUserInfo+ResponseParser.h"
#import "NSDictionary+WTRUtility.h"

@implementation WTRUserInfo (ResponseParser)

+ (instancetype)infoFromDictionaryData:(NSDictionary *)data {
  WTRUserInfo *userInfo = [WTRUserInfo new];
  userInfo.email = [data stringForKey:@"email"];
  userInfo.userId = [data stringForKey:@"id"];
  userInfo.ttl = [data stringForKey:@"ttl"];
  userInfo.createdTime = [data stringForKey:@"created"];
  
  return userInfo;
}

@end
