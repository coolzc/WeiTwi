

#import <Foundation/Foundation.h>

@interface WTRApiResponse : NSObject

@property (nonatomic, assign) NSInteger code;
@property (nonatomic, strong) NSString *message;
@property (nonatomic, strong) id responseObject;

+ (instancetype)responseWithErrorMessage:(NSString *)message;
+ (instancetype)responseWithResponseData:(NSDictionary *)data;

- (BOOL)isSuccess;
- (BOOL)isNotAllowed;
- (BOOL)isNotAcceptable;
- (BOOL)isMissigData;
- (BOOL)isNotExists;
- (BOOL)isNotMatch;
- (BOOL)isInternalError;

@end
