
#import "WebServiceClient.h"
#import <AFNetworkActivityIndicatorManager.h>

static NSString * const WebServiceClientURL = @"http://processoseletivoneon.azurewebsites.net";

@implementation WebServiceClient

+ (instancetype)sharedClient {
    static WebServiceClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[WebServiceClient alloc] initWithBaseURL:[NSURL URLWithString:WebServiceClientURL]];
        [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
    });
    
    return _sharedClient;
}

- (instancetype)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    if (self) {
        self.requestSerializer = [AFJSONRequestSerializer serializer];
        
    }
    
    return self;
}


@end
