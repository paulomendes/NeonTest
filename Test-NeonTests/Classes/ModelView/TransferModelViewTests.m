
#import "BaseTest.h"
#import "TransferModel.h"
#import "TransferModelView.h"
#import "PersonModelView.h"
#import "PersonModel.h"
#import "PersonsDAO.h"

@interface TransferModelViewTests : BaseTest

@end

@implementation TransferModelViewTests

- (void)testTransferModelViewParser {
    PersonModel *personModel = [[PersonModel alloc] init];
    personModel.identifier = @111;
    personModel.firstName = @"Paulo";
    personModel.lastName = @"Mendes";
    personModel.telephoneNumber = @19981817466;
    
    [[PersonsDAO sharedInstance] addPersons:@[personModel]];
    
    TransferModel *transferModel = [[TransferModel alloc] init];
    
    transferModel.identifier = @1;
    transferModel.amount = @22.2;
    transferModel.date = [NSDate date];
    transferModel.personId = @111;
    transferModel.token = @"token-abc";
    
    TransferModelView *transferModelView = [[TransferModelView alloc] initWithTransfer:transferModel];
    
    expect(transferModelView.person.identifier).to.equal(personModel.identifier);
    expect(transferModelView.formattedDate).to.beKindOf([NSString class]);
}

@end
