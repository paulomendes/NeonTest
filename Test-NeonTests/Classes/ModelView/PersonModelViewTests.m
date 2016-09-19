
#import "BaseTest.h"
#import "PersonModel.h"
#import "PersonModelView.h"

@interface PersonModelViewTests : BaseTest

@end

@implementation PersonModelViewTests

- (void)testPersonModelViewParser {
    PersonModel *personModel = [[PersonModel alloc] init];
    personModel.identifier = @1;
    personModel.firstName = @"Paulo";
    personModel.lastName = @"Mendes";
    personModel.telephoneNumber = @19981817466;
    
    PersonModelView *personModelView = [[PersonModelView alloc] initWithPerson:personModel];
    
    expect(personModelView.fullName).to.equal(@"Paulo Mendes");
    expect(personModelView.formatedPhoneNumber).to.equal(@"(19) 981817466");
    
}

@end
