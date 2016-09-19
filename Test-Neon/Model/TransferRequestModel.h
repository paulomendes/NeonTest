
#import "BaseModel.h"

@interface TransferRequestModel : BaseModel

@property (nonatomic, copy) NSString *clientId;
@property (nonatomic, strong) NSNumber *amount;

@end
