
#import "TransferModelView.h"
#import "TransferModel.h"
#import "PersonsDAO.h"
#import "PersonModel.h"
#import "NeonDateFormatter.h"

@interface TransferModelView ()

@property (nonatomic, strong) TransferModel *transfer;

@end

@implementation TransferModelView

- (instancetype)initWithTransfer:(TransferModel *)transfer {
    self = [super init];
    if (self) {
        _transfer = transfer;
        [self initializer];
    }
    return self;
}

- (void)initializer {
    PersonModel *personModel = [[PersonsDAO sharedInstance] personWithIdentifier:self.transfer.personId];
    self.person = [[PersonModelView alloc] initWithPerson:personModel];
}

- (NSString *)formattedDate {
    return [NeonDateFormatter dateOfTransfer:self.transfer.date];
}

@end
