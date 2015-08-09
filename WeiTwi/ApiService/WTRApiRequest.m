

#import "WTRApiRequest.h"

@interface WTRApiRequest ()

@property (nonatomic, strong) NSMutableDictionary *parameters;
@property (nonatomic, strong) NSMutableDictionary *headers;

@end


@implementation WTRApiRequest

- (id)init {
  if (self = [super init]) {
    _parameters = [NSMutableDictionary dictionary];
    _headers = [NSMutableDictionary dictionary];
  }
  return self;
}

#pragma mark - Public Methods

- (void)addHeader:(NSString *)heaerField value:(NSString *)value {
   [self.headers setObject:value forKey:heaerField];
}

- (void)addParameters:(NSDictionary *)parameters {
  [self.parameters addEntriesFromDictionary:parameters];
}

- (void)addParameter:(NSString *)name value:(id)value {
  [self.parameters setObject:value forKey:name];
}

- (void)appendParametersToURL {
  NSString *paramString = [self parametersString];
  if (0 < [paramString length]) {
    self.url = [NSString stringWithFormat:@"%@?%@", self.url, paramString];
  }
}

- (AFHTTPRequestOperation *)httpRequestOperationValue {
  NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:self.url]];
  for (NSString *headerField in [self.headers allKeys]) {
    [request addValue:self.headers[headerField] forHTTPHeaderField:headerField];
  }
  [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
  [request setHTTPMethod:[self methodName]];
  [request setHTTPBody:self.body];
  AFHTTPRequestOperation *requestOperation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
  requestOperation.responseSerializer = [AFJSONResponseSerializer serializer];
  requestOperation.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
  return requestOperation;
}

#pragma mark - Private Methods

- (NSString *)methodName {
  NSString *methodName = @"GET";
  switch (self.method) {
    case WTRApiRequestMethodPost:
      methodName = @"POST";
      break;
      
    case WTRApiRequestMethodPut:
      methodName = @"PUT";
      break;
      
    case WTRApiRequestMethodDelete:
      methodName = @"DELETE";
      break;
      
    default:
      break;
  }
  return methodName;
}

- (NSString *)parametersString {
  NSMutableArray *parts = [NSMutableArray array];
  for (NSString *key in [self.parameters allKeys]) {
    NSString *part = [NSString stringWithFormat:@"%@=%@", key, [self.parameters valueForKey:key]];
    [parts addObject: part];
  }
  
  return [parts componentsJoinedByString: @"&"];
}

@end
