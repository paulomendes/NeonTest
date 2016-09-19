
#import "NeonDateFormatter.h"

@implementation NeonDateFormatter

+ (NSString *)dateOfTransfer:(NSDate *)date {
    static NSDateFormatter *dateFormatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *dateFormat = [NSString stringWithFormat:@"dd 'de' MMMM yyyy 'às' HH'h'mm"];
        
        dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.locale = [NSLocale localeWithLocaleIdentifier:@"pt_BR"];
        dateFormatter.dateFormat = dateFormat;
    });
    
    NSString *dateString = [dateFormatter stringFromDate:date];
    return [NSString stringWithFormat:NSLocalizedString(@"%@", nil), dateString];
}

@end
