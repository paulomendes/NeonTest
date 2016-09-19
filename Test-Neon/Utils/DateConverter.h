
#import <Foundation/Foundation.h>

@interface DateConverter : NSObject

+ (NSDate *)dateFromString:(NSString *)string;
+ (NSString *)stringFromDate:(NSDate *)date;


@end
