
#import <Foundation/Foundation.h>

typedef void (^ArrayCompletionBlock)(NSArray *array);
typedef void (^StringCompletionBlock)(NSString *string);
typedef void (^ErrorBlock)(NSError *error);

@class PersonModel, TransferRequestModel;

@interface TransferWS : NSObject


+ (NSURLSessionTask *)loadUserToken:(StringCompletionBlock)completion
                              error:(ErrorBlock)errorBlock;

+ (NSURLSessionTask *)loadTransfersWithCompletion:(ArrayCompletionBlock)completion
                                            error:(ErrorBlock)errorBlock;

+ (NSURLSessionTask *)postTransfer:(TransferRequestModel *)transfer
                    withCompletion:(StringCompletionBlock)completion
                             error:(ErrorBlock)errorBlock;



@end
