
#import <Foundation/Foundation.h>

@interface BaseDAO : NSObject

+ (void)saveFile:(NSString *)name withObject:(id)object;
+ (id)loadFile:(NSString *)name;

@end
