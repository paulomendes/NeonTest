
#import "GeneratePersonsUtil.h"
#import "PersonModel.h"
#import "PersonsDAO.h"

@implementation GeneratePersonsUtil

+ (NSNumber *)randomPhoneNumber {
    NSUInteger y =  (arc4random() % 19000000000) + 19999999999;
    return [NSNumber numberWithInteger:y];
}

+ (void)generatePersons {
    NSArray *firstNames = @[@"Paulo", @"João", @"Bianca", @"Madalena", @"Lídia", @"Diogo", @"Diego"];
    NSArray *lasttNames = @[@"Martin", @"Mendes", @"Osasco", @"Iwai", @"Vilas Boas", @"Powel", @"Vitoria"];
    NSDictionary *d = @{@1 : [UIImage imageNamed:@"1"],
                        @2 : [UIImage imageNamed:@"2"],
                        @5 : [UIImage imageNamed:@"5"],
                        @6 : [UIImage imageNamed:@"6"],
                        @7 : [UIImage imageNamed:@"7"],
                        @10 : [UIImage imageNamed:@"10"],
                        @14 : [UIImage imageNamed:@"14"]};
    
    NSMutableArray *persons = [NSMutableArray array];
    for (NSInteger i = 0; i < 15; i++) {
        NSUInteger r1 = arc4random() % [firstNames count];
        NSUInteger r2 = arc4random() % [lasttNames count];
        
        PersonModel *p = [[PersonModel alloc] init];
        p.firstName = firstNames[r1];
        p.lastName = lasttNames[r2];
        p.telephoneNumber = [self randomPhoneNumber];
        p.identifier = @(i);
        p.avatarImage = [d objectForKey:@(i)] ? d[@(i)] : nil;
        [persons addObject:p];
    }
    
    [[PersonsDAO sharedInstance] addPersons:persons];
}

@end
