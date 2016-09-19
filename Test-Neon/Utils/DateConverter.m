
#import "DateConverter.h"
#import <ISO8601DateFormatter.h>

static ISO8601DateFormatter *_formatter;

@implementation DateConverter

+ (NSString *)stringFromDate:(NSDate *)date {
    return [[self formatter] stringFromDate:date];
}

+ (NSDate *)dateFromString:(NSString *)string {
    return [[self formatter] dateFromString:string];
}

#pragma mark - Private

+ (ISO8601DateFormatter *)formatter {
    
    if (!_formatter) {
        _formatter = [[ISO8601DateFormatter alloc] init];
    }
    
    return _formatter;
}


@end
