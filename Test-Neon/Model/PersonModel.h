
#import "BaseModel.h"

@class UIImage;

@interface PersonModel : BaseModel

@property (nonatomic, copy) NSNumber *identifier;
@property (nonatomic, copy) NSString *firstName;
@property (nonatomic, copy) NSString *lastName;
@property (nonatomic, strong) UIImage *avatarImage;
@property (nonatomic, copy) NSNumber *telephoneNumber;

@end
