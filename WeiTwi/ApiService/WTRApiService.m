
#import "WTRApiService.h"
#import "AFNetworking.h"

@interface WTRApiService ()

@property (nonatomic, strong) AFHTTPRequestOperationManager *operationManager;

@end


@implementation WTRApiService

- (id)init {
  if (self = [super init]) {
    _operationManager = [AFHTTPRequestOperationManager manager];
  }
  return self;
}

+ (id)serviceWithDeleate:(id <WTRApiServiceDelegate>)delegate {
  WTRApiService *service = [self new];
  service.delegate = delegate;
  return service;
}

- (void)sendRequest:(WTRApiRequest *)apiRequest {
  AFHTTPRequestOperation *requestOperation = [apiRequest httpRequestOperationValue];
  [requestOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
    [self finishRequest:apiRequest withResponseObject:responseObject error:nil];
  } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    [self finishRequest:apiRequest withResponseObject:nil error:error];
  }];
  [self.operationManager.operationQueue addOperation:requestOperation];
}

#pragma mark - Private Methods

- (void)finishRequest:(WTRApiRequest *)apiRequest withResponseObject:(id)responseObject error:(NSError *)error {
  WTRApiResponse *apiResponse = nil;
  if (responseObject && [responseObject isKindOfClass:[NSDictionary class]]) {
    apiResponse = [WTRApiResponse responseWithResponseData:responseObject];
    if (apiRequest.responseParser) {
      apiResponse.responseObject = apiRequest.responseParser((NSDictionary *)responseObject);
    }
  } else {
    apiResponse = [WTRApiResponse responseWithErrorMessage:[error description]];
  }
  if ([self.delegate respondsToSelector:@selector(apiService:didFinishRequest:withResponse:)]) {
    [self.delegate apiService:self didFinishRequest:apiRequest withResponse:apiResponse];
  }
}


@end
