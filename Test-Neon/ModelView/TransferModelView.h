
#import <Foundation/Foundation.h>
#import "PersonModelView.h"

@class TransferModel;

@interface TransferModelView : NSObject

@property (nonatomic, strong) PersonModelView *person;
@property (nonatomic, copy) NSString *formattedDate;

- (instancetype)initWithTransfer:(TransferModel *)transfer;

@end
