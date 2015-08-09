

#import <Foundation/Foundation.h>
#import "WTRApiResponse.h"
#import "WTRApiRequest.h"

@protocol WTRApiServiceDelegate;

@interface WTRApiService : NSObject

@property(nonatomic, weak) NSObject <WTRApiServiceDelegate> *delegate;

+ (id)serviceWithDeleate:(id <WTRApiServiceDelegate>)delegate;

- (void)sendRequest:(WTRApiRequest *)apiRequest;

@end


@protocol WTRApiServiceDelegate <NSObject>

@optional
- (void)apiService:(WTRApiService *)service didFinishRequest:(WTRApiRequest *)request withResponse:(WTRApiResponse *)response;

@end