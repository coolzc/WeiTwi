

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

typedef enum {
  WTRApiRequestCreateAccount,
  WTRApiRequestLogin,
  WTRApiRequestFriendTimeline,
} WTRApiRequestType;

typedef enum {
  WTRApiRequestMethodGet,
  WTRApiRequestMethodPost,
  WTRApiRequestMethodDelete,
  WTRApiRequestMethodPut,
} WTRApiRequestMethod;

typedef id (^WTRApiResponseParser)(NSDictionary *data);


@interface WTRApiRequest : NSObject

@property (nonatomic, strong) NSString *url;
@property (nonatomic, assign) WTRApiRequestType type;
@property (nonatomic, assign) WTRApiRequestMethod method;
@property(nonatomic,copy) WTRApiResponseParser responseParser;
@property (nonatomic, strong) NSData *body;
@property (nonatomic, strong) id extraInfo;

- (void)addHeader:(NSString *)heaerField value:(NSString *)value;
- (void)addParameters:(NSDictionary *)parameters;
- (void)addParameter:(NSString *)name value:(id)value;
- (void)appendParametersToURL;

- (AFHTTPRequestOperation *)httpRequestOperationValue;

@end
