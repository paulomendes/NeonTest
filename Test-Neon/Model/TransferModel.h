
#import "BaseModel.h"

@class PersonModel;

@interface TransferModel : BaseModel <MTLJSONSerializing>

@property (nonatomic, copy) NSNumber *identifier;
@property (nonatomic, strong) NSNumber *amount;
@property (nonatomic, strong) NSDate *date;
@property (nonatomic, copy) NSNumber *personId;
@property (nonatomic, copy) NSString *token;

@end
