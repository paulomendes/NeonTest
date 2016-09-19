
#import <Foundation/Foundation.h>

@interface ModelConverter : NSObject

+ (id)convertModelFromJSON:(NSDictionary *)JSON class:(Class)classToParse;
+ (NSArray *)convertModelsFromJSON:(NSArray *)JSON class:(Class)classToParse;

@end
