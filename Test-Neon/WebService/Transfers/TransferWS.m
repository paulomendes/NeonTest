
#import "TransferWS.h"
#import "WebServiceClient.h"
#import "UserDAO.h"
#import "ErrorHandler.h"
#import "TransferRequestModel.h"
#import "TransferModel.h"

typedef void (^AFNetworkingErrorBlock)(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error);

@implementation TransferWS

AFNetworkingErrorBlock static afnetworkingError(ErrorBlock errorBlock) {
    
    void (^returnBlock)(NSURLSessionDataTask *, NSError *);
    
    returnBlock = ^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSError *returnedError;
        
        if ([error.domain isEqualToString:NSURLErrorDomain]) {
            returnedError = [ErrorHandler errorForNoInternetConnection];
            if (errorBlock) {
                errorBlock(returnedError);
            }
            return;
        }
        
        NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
        if (response.statusCode >= 400 && response.statusCode <= 499) {
            returnedError = [ErrorHandler errorFor4xx];
        } else if (response.statusCode >= 500 && response.statusCode <= 599) {
            returnedError = [ErrorHandler errorFor5xx];
        } else {
            returnedError = error;
        }
        
        if (errorBlock) {
            errorBlock(returnedError);
        }
    };
    
    return returnBlock;
}
+ (NSURLSessionTask *)loadUserToken:(StringCompletionBlock)completion
                              error:(ErrorBlock)errorBlock {
    WebServiceClient *client = [WebServiceClient sharedClient];
    
    client.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSDictionary *p = @{@"nome" : [[UserDAO sharedInstance] userName],
                        @"email" : [[UserDAO sharedInstance] userEmail]};
    
    return [client GET:@"GenerateToken"
            parameters:p
              progress:NULL
               success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
                   NSString *string = [[NSString alloc] initWithData:responseObject
                                                            encoding:NSUTF8StringEncoding];
                   if (completion) {
                       completion(string);
                   }
    } failure:afnetworkingError(errorBlock)];
}

+ (NSURLSessionTask *)loadTransfersWithCompletion:(ArrayCompletionBlock)completion
                                            error:(ErrorBlock)errorBlock {
    WebServiceClient *client = [WebServiceClient sharedClient];
    
    client.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingMutableContainers];
    
    NSDictionary *p = @{@"token" : [[UserDAO sharedInstance] userToken]};
    
    return [client GET:@"GetTransfers"
            parameters:p
              progress:NULL
               success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
                   NSArray *transfers = [MTLJSONAdapter modelsOfClass:[TransferModel class]
                                                        fromJSONArray:responseObject
                                                                error:nil];
                   if (completion) {
                       completion(transfers);
                   }
               } failure:afnetworkingError(errorBlock)];
}

+ (NSURLSessionTask *)postTransfer:(TransferRequestModel *)transfer
                    withCompletion:(StringCompletionBlock)completion
                             error:(ErrorBlock)errorBlock {
    
    WebServiceClient *client = [WebServiceClient sharedClient];
    
    client.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSDictionary *p = @{@"ClienteId" : transfer.clientId,
                        @"token" : [[UserDAO sharedInstance] userToken],
                        @"valor": transfer.amount};
    
    return [client POST:@"SendMoney"
             parameters:p
               progress:NULL
               success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
                   NSString *string = [[NSString alloc] initWithData:responseObject
                                                            encoding:NSUTF8StringEncoding];
                   if (completion) {
                       completion(string);
                   }
               } failure:afnetworkingError(errorBlock)];
}

@end
