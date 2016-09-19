
#import "BaseTest.h"
#import <MTLJSONAdapter.h>
#import "TransferModel.h"

@interface TransferModelTests : BaseTest

@end

@implementation TransferModelTests

- (void)testTransferModelParse {
    NSError *error;
    NSDictionary *d = @{@"ClienteId" : @1,
                        @"Id" : @1,
                        @"Valor" : @22.2,
                        @"Token" : @"token-abc",
                        @"Data" : @"2016­08­02T14:25:37.55" };
    TransferModel *model = [MTLJSONAdapter modelOfClass:[TransferModel class]
                                     fromJSONDictionary:d
                                                  error:&error];
    expect(model).notTo.equal(nil);
    expect(model.identifier).to.equal(d[@"Id"]);
    expect(model.personId).to.equal(d[@"ClienteId"]);
    expect(model.amount).to.equal(d[@"Valor"]);
}

@end
