
#import "BaseTest.h"
#import "PersonsDAO.h"
#import "PersonModel.h"

@interface PersonsDAOTests : BaseTest

@end

@implementation PersonsDAOTests

- (void)testAddPersonsToPersonsDAO {
    PersonModel *p1 = [[PersonModel alloc] init];
    PersonModel *p2 = [[PersonModel alloc] init];
    
    p1.identifier = @20;
    p1.firstName = @"Paulo";
    p1.lastName = @"Mendes";
    p1.telephoneNumber = @(19981818181);
    
    p2.identifier = @21;
    p2.firstName = @"Daniela";
    p2.lastName = @"Mendes";
    p2.telephoneNumber = @(19991991991);
    
    [[PersonsDAO sharedInstance] addPersons:@[p1, p2]];
    
    expect([[PersonsDAO sharedInstance] allPersons].count).to.beGreaterThan(0);
}

- (void)testGetPersonsFromArchivedFile {
    NSArray *results = [[PersonsDAO sharedInstance] allPersons];
    expect(results.count).to.beGreaterThan(0);
}

@end
