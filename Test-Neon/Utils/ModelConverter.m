
#import "ModelConverter.h"
#import <MTLJSONAdapter.h>

@implementation ModelConverter

+ (id)convertModelFromJSON:(NSDictionary *)JSON class:(Class)classToParse {
    NSParameterAssert(classToParse != nil);
    
    @try {
        NSError *error = nil;
        id object = [MTLJSONAdapter modelOfClass:classToParse
                              fromJSONDictionary:JSON
                                           error:&error];
        if (!error) {
            return object;
        } else {
            NSLog(@"%@", error);
            return nil;
        }
    }
    @catch (NSException *exception) {
        return nil;
    }
}

+ (NSArray *)convertModelsFromJSON:(NSArray *)JSON class:(Class)classToParse {
    NSParameterAssert(classToParse != nil);
    
    @try {
        NSError *error = nil;
        NSArray *objects = [MTLJSONAdapter modelsOfClass:classToParse
                                           fromJSONArray:JSON
                                                   error:&error];
        if (!error) {
            return objects;
        } else {
            NSLog(@"%@", error);
            return nil;
        }
    }
    @catch (NSException *exception) {
        return nil;
    }
}


@end
