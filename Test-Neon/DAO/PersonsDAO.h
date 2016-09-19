
#import <Foundation/Foundation.h>

@class PersonModel;

@interface PersonsDAO : NSObject

@property (nonatomic, strong, readonly) NSArray *allPersons;

+ (instancetype)sharedInstance;
- (void)addPersons:(NSArray *)person;
- (PersonModel *)personWithIdentifier:(NSNumber *)identifier;

- (void)removeAllPersons;

@end
