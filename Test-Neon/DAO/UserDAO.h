
#import "BaseDAO.h"

@interface UserDAO : BaseDAO

+ (instancetype)sharedInstance;

- (NSString *)userName;
- (NSString *)userEmail;
- (NSString *)userToken;
- (void)configureUserToken:(NSString *)userToken;

@end
