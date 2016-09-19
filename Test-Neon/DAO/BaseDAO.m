
#import "BaseDAO.h"

@implementation BaseDAO

+ (void)saveFile:(NSString *)name withObject:(id)object {
    if (!object) {
        return;
    }
    [NSKeyedArchiver archiveRootObject:object toFile:[self pathForFile:name]];
}

+ (id)loadFile:(NSString *)name {
    return [NSKeyedUnarchiver unarchiveObjectWithFile:[self pathForFile:name]];
}

+ (NSString *)getPrivateDocsDirectory {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    documentsDirectory = [documentsDirectory stringByAppendingPathComponent:[self getMainApplicationDirectory]];
    
    NSError *error;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if (![fileManager fileExistsAtPath:documentsDirectory]) {
        [fileManager createDirectoryAtPath:documentsDirectory withIntermediateDirectories:YES attributes:nil error:&error];
    }
    
    return documentsDirectory;
}

+ (NSString *)pathForFile:(NSString *)file {
    return [[self getPrivateDocsDirectory] stringByAppendingPathComponent:file];
}

+ (NSString *)getMainApplicationDirectory {
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleName"];
}

@end
