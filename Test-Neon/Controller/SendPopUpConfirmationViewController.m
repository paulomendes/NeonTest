
#import "SendPopUpConfirmationViewController.h"
#import "PersonModelView.h"
#import "TransferRequestModel.h"
#import <STPopup/STPopup.h>
#import "UIColor+NeonColors.h"

@interface SendPopUpConfirmationViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *fullName;
@property (weak, nonatomic) IBOutlet UILabel *telephony;
@property (weak, nonatomic) IBOutlet UITextField *amountTextField;
@property (weak, nonatomic) IBOutlet UIButton *sendButton;

@property (nonatomic, strong) NSMutableArray *stack;

@end

@implementation SendPopUpConfirmationViewController

- (void)awakeFromNib {
    [super awakeFromNib];
    self.contentSizeInPopup = CGSizeMake(300, 300);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.stack = [NSMutableArray array];
    [self tweakInterface];
    self.amountTextField.delegate = self;
    [self.amountTextField becomeFirstResponder];
}

- (void)tweakInterface {
    self.profileImageView.layer.cornerRadius = self.profileImageView.frame.size.height / 2;
    self.profileImageView.clipsToBounds = YES;
    self.profileImageView.layer.borderWidth = 1.5;
    self.profileImageView.layer.borderColor = [[UIColor neonProfileBlueColor] CGColor];
    
    self.fullName.text = self.person.fullName;
    self.telephony.text = self.person.formatedPhoneNumber;
    self.profileImageView = [self.person profileImage:self.profileImageView];
    
    CGRect frame = self.amountTextField.frame;
    frame.size.height = 55;
    self.amountTextField.frame = frame;
    self.amountTextField.text = @"R$ 0,00";
    
    self.amountTextField.layer.borderWidth = 1.5;
    self.amountTextField.layer.borderColor = [[UIColor neonProfileBlueColor] CGColor];
    self.amountTextField.textColor = [UIColor neonProfileBlueColor];
    self.amountTextField.layer.cornerRadius = 25;
    self.amountTextField.clipsToBounds = YES;
    
    self.sendButton.backgroundColor = [UIColor neonProfileBlueColor];
    self.sendButton.layer.cornerRadius = 22;
    self.sendButton.clipsToBounds = YES;
}

#pragma mark - Actions

- (IBAction)closeButtonTapped:(id)sender {
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void)showWarningForZeroValue {
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"Aviso"
                                                                    message:@"Você precisa inserir um valor maior que zero"
                                                             preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK"
                                                       style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction * action) {
                                                         [alert dismissViewControllerAnimated:YES completion:nil];
                                                     }];
    
    [alert addAction:okAction];
    [self presentViewController:alert animated:YES completion:nil];
}

- (IBAction)sendButtonTapped:(id)sender {
    NSNumber *amount = [self amountOfTransfer];
    
    if ([amount isEqualToNumber:@0]) {
        [self showWarningForZeroValue];
    } else {
        TransferRequestModel *transfer = [[TransferRequestModel alloc] init];
        transfer.amount = amount;
        transfer.clientId = [self.person.identifier stringValue];
        
        [self dismissViewControllerAnimated:YES completion:^{
            if ([self.delegate respondsToSelector:@selector(didSentConfirmMoneyTransfer:)]) {
                [self.delegate didSentConfirmMoneyTransfer:transfer];
            }
        }];
    }
}

#pragma mark - Private Functions

- (NSNumber *)amountOfTransfer {
    NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
    f.numberStyle = NSNumberFormatterDecimalStyle;
    f.decimalSeparator = @",";
    NSString *number = self.amountTextField.text;
    NSNumber *myNumber = [f numberFromString:[number substringWithRange:NSMakeRange(2, number.length - 2)]];
    
    return myNumber;
}

- (void)formatForCurrency {
    NSMutableString *amout = [NSMutableString string];
    for (NSString *i in self.stack) {
        [amout appendString:i];
    }
    
    if (amout.length == 0) {
        self.amountTextField.text = @"R$ 0,00";
    } else if (amout.length == 1) {
        self.amountTextField.text = [NSString stringWithFormat:@"R$ 0,0%@", amout];
    } else if (amout.length == 2) {
        self.amountTextField.text = [NSString stringWithFormat:@"R$ 0,%@", amout];
    } else {
        NSString *cents = [amout substringWithRange:NSMakeRange(amout.length - 2, 2)];
        NSString *bucks = [amout substringWithRange:NSMakeRange(0, amout.length - 2)];
        self.amountTextField.text = [NSString stringWithFormat:@"R$ %@,%@", bucks, cents];
    }
}

#pragma mark - TextField Delegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (string.length) {
        [self.stack addObject:string];
    } else {
        [self.stack removeLastObject];
    }
    
    [self formatForCurrency];
    return NO;
}

@end
