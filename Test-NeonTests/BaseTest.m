
#import "BaseTest.h"

@implementation BaseTest

- (NSDictionary *)dictionaryWithContentsOfJSONString:(NSString*)fileLocation {
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    NSString *filePath = [bundle pathForResource:[fileLocation stringByDeletingPathExtension] ofType:[fileLocation pathExtension]];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    NSError *error = nil;
    
    id result = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    
    if (error != nil) {
        return nil;
    }
    
    return result;
}


@end
