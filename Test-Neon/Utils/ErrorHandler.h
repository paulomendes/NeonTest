
#import <Foundation/Foundation.h>

static NSString * const WSErrorDomain = @"br.com.nubank.nubill-assignment:NBABillsWSErrorDomain";

typedef NS_ENUM(NSUInteger, ErrorHandlerCode) {
    ErrorHandlerCodeInternetConnection,
    ErrorHandlerCodeBadRequest,
    ErrorHandlerCodeServerError,
};

@interface ErrorHandler : NSObject

+ (NSError *)errorFor5xx;

+ (NSError *)errorFor4xx;

+ (NSError *)errorForNoInternetConnection;


@end
