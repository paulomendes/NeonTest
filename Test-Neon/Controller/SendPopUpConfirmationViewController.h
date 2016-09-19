
#import <UIKit/UIKit.h>

@class PersonModelView, TransferRequestModel;

@protocol SendPopUpConfirmationProtocol <NSObject>

- (void)didSentConfirmMoneyTransfer:(TransferRequestModel *)transfer;

@end

@interface SendPopUpConfirmationViewController : UIViewController

@property (nonatomic, strong) PersonModelView *person;
@property (nonatomic, weak) id<SendPopUpConfirmationProtocol> delegate;

@end
