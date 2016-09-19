
#import "AppDelegate.h"
#import "GeneratePersonsUtil.h"
#import "PersonsDAO.h"
#import "UserDAO.h"
#import "TransferWS.h"

@interface AppDelegate () <UISplitViewControllerDelegate>

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    if (![[PersonsDAO sharedInstance] allPersons].count) {
        [GeneratePersonsUtil generatePersons];
    }
    
    return YES;
}

@end
