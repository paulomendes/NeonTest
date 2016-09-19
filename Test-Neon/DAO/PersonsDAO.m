
#import "PersonsDAO.h"
#import "PersonModel.h"
#import "BaseDAO.h"

static NSString * const kPersonsFile = @"neon_personsFile";

@interface PersonsDAO ()

@property (nonatomic, strong) NSMutableArray *persons;

@end

@implementation PersonsDAO

+ (instancetype)sharedInstance {
    static PersonsDAO * _sharedDAO = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedDAO = [[PersonsDAO alloc] init];
    });
    
    return _sharedDAO;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.persons = [NSMutableArray array];
        [self load];
    }
    return self;
}

- (void)addPersons:(NSArray *)person {
    [self.persons addObjectsFromArray:[person copy]];
    [self save];
}

- (NSArray *)allPersons {
    return self.persons;
}

- (void)removeAllPersons {
    [self.persons removeAllObjects];
    [self save];
}

- (PersonModel *)personWithIdentifier:(NSNumber *)identifier {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.identifier = %@", identifier];
    NSArray *filter = [[PersonsDAO sharedInstance].allPersons filteredArrayUsingPredicate:predicate];
    if (filter.count) {
        return  [filter firstObject];
    } else {
        return nil;
    }
}

#pragma mark - PrivateMethods

- (void)save {
    [BaseDAO saveFile:kPersonsFile withObject:self.persons];
}

- (void)load {
    NSMutableArray *response = [BaseDAO loadFile:kPersonsFile];
    if (response) {
        self.persons = response;
    }
}

@end
