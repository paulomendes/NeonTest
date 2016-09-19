
#import "PersonModelView.h"
#import "PersonModel.h"
#import <UIImageView+Letters.h>
#import "UIColor+NeonColors.h"

@interface PersonModelView ()

@property (nonatomic, strong) PersonModel *person;

@end

@implementation PersonModelView

- (instancetype)initWithPerson:(PersonModel *)person {
    self = [super init];
    if (self) {
        _person = person;
    }
    return self;
}

- (NSNumber *)identifier {
    return self.person.identifier;
}

- (NSString *)fullName {
    return [NSString stringWithFormat:@"%@ %@", self.person.firstName, self.person.lastName];
}

- (NSString *)formatedPhoneNumber {
    NSString *numberAsString = [self.person.telephoneNumber stringValue];
    NSString *code = [numberAsString substringWithRange:NSMakeRange(0, 2)];
    NSString *number = [numberAsString substringWithRange:NSMakeRange(2, numberAsString.length - 2)];
    
    return [NSString stringWithFormat:@"(%@) %@", code, number];
}

- (UIImageView *)profileImage:(UIImageView *)imageView {
    if (self.person.avatarImage) {
        [imageView setImage:self.person.avatarImage];
    } else {
        [imageView setImageWithString:self.fullName
                                color:[UIColor whiteColor]
                             circular:YES
                       textAttributes:@{NSFontAttributeName: [UIFont boldSystemFontOfSize:28],
                                        NSForegroundColorAttributeName: [UIColor neonProfileBlueColor]}];
    }
    return imageView;
}

@end
