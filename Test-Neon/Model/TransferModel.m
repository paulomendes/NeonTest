
#import "TransferModel.h"
#import "DateConverter.h"

@implementation TransferModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{ @"identifier" : @"Id",
              @"amount" : @"Valor",
              @"date" : @"Data",
              @"personId" : @"ClienteId",
              @"token" : @"Token" };
}

+ (NSValueTransformer *)dateJSONTransformer {
    return [MTLValueTransformer transformerUsingForwardBlock:^NSDate *(NSString *string, BOOL *success, NSError *__autoreleasing *error) {
        NSDate *date = [DateConverter dateFromString:string];
        return date;
    } reverseBlock:^NSString *(NSDate *value, BOOL *success, NSError *__autoreleasing *error) {
        return [DateConverter stringFromDate:value];
    }];
}

@end
