
#import <UIKit/UIKit.h>

@class PersonModel;

@interface PersonModelView : NSObject

@property (nonatomic, copy, readonly) NSString *fullName;
@property (nonatomic, copy, readonly) NSString *formatedPhoneNumber;
@property (nonatomic, copy, readonly) NSNumber *identifier;

- (UIImageView *)profileImage:(UIImageView *)imageView;

- (instancetype)initWithPerson:(PersonModel *)person;

@end
