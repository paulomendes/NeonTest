
#import "UserDAO.h"

@interface UserDAO ()

@property (nonatomic, strong) NSString *token;

@end

static NSString * const kUserFile = @"neon_userFile";

@implementation UserDAO

+ (instancetype)sharedInstance {
    static UserDAO * _sharedDAO = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedDAO = [[UserDAO alloc] init];
    });
    
    return _sharedDAO;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.token = [NSString string];
        [self load];
    }
    return self;
}


- (NSString *)userName {
    return @"Paulo Mendes Martin";
}

- (NSString *)userEmail {
    return @"paulo@paul.me";
}

- (NSString *)userToken {
    return self.token;
}

- (void)configureUserToken:(NSString *)userToken {
    _token = userToken;
    [self save];
}

#pragma mark - PrivateMethods

- (void)save {
    [BaseDAO saveFile:kUserFile withObject:self.token];
}

- (void)load {
    NSString *response = [BaseDAO loadFile:kUserFile];
    if (response) {
        self.token = response;
    }
}


@end
