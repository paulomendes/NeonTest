
#import "ErrorHandler.h"

@implementation ErrorHandler

+ (NSError *)errorFor5xx {
    NSDictionary *userInfo = @{NSLocalizedDescriptionKey : @"Desculpe, estamos enfrentando problemas técnicos. Por favor, tente novamente mais tarde."};
    
    return [NSError errorWithDomain:WSErrorDomain
                               code:ErrorHandlerCodeServerError
                           userInfo:userInfo];
}

+ (NSError *)errorFor4xx {
    NSDictionary *userInfo = @{NSLocalizedDescriptionKey : @"Houve algum erro com o seu pedido"};
    
    return [NSError errorWithDomain:WSErrorDomain
                               code:ErrorHandlerCodeBadRequest
                           userInfo:userInfo];
}

+ (NSError *)errorForNoInternetConnection {
    NSDictionary *userInfo = @{NSLocalizedDescriptionKey : @"Parece que você está sem internet! Por favor, verifique a sua conexão e tente novamente."};
    
    return [NSError errorWithDomain:WSErrorDomain
                               code:ErrorHandlerCodeInternetConnection
                           userInfo:userInfo];
}

@end
