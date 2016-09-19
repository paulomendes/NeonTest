
#import "ContactViewCell.h"
#import "PersonModelView.h"
#import "UIColor+NeonColors.h"

@interface ContactViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *fullName;
@property (weak, nonatomic) IBOutlet UILabel *telephony;
@property (weak, nonatomic) IBOutlet UIView *separatorView;

@end

@implementation ContactViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.profileImageView.layer.cornerRadius = self.profileImageView.frame.size.height / 2;
    self.profileImageView.clipsToBounds = YES;
    self.profileImageView.layer.borderWidth = 1.5;
    self.profileImageView.layer.borderColor = [[UIColor neonProfileBlueColor] CGColor];
    self.separatorView.backgroundColor = [UIColor neonProfileBlueColor];
}

- (void)populateCell:(PersonModelView *)contact {
    self.fullName.text = contact.fullName;
    self.telephony.text = contact.formatedPhoneNumber;
    self.profileImageView = [contact profileImage:self.profileImageView];
}

@end
