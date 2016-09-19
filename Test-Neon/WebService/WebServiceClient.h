
#import <AFNetworking/AFNetworking.h>

@interface WebServiceClient : AFHTTPSessionManager

+ (instancetype)sharedClient;

@end
