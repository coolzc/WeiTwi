

#import "WTRUserInfo+ResponseParser.h"
#import "NSDictionary+WTRUtility.h"

@implementation WTRWeiboUserInfo (ResponseParser)

+ (instancetype)infoFromDictionaryData:(NSDictionary *)data {
  WTRWeiboUserInfo *userInfo = [WTRWeiboUserInfo new];
  userInfo.userId = [data stringForKey:@"email"];
  userInfo.userId = [data stringForKey:@"id"];
  userInfo.userName = [data stringForKey:@"ttl"];
  userInfo.userScreenName = [data stringForKey:@"created"];
  
  return userInfo;
}

@end
