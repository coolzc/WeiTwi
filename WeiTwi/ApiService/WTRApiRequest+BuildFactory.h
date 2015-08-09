

#import "WTRApiRequest.h"

@interface WTRApiRequest (BuildFactory)

+ (instancetype)requestForCreateAccountWithEmail:(NSString *)email password:(NSString *)password;
+ (instancetype)requestForLoginWithAccount:(NSString *)account password:(NSString *)password;

+ (instancetype)requestForUserTimeline;

@end
