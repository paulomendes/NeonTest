
#import "ContactHistoryViewCell.h"
#import "TransferModelView.h"
#import "UIColor+NeonColors.h"

@interface ContactHistoryViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *fullName;
@property (weak, nonatomic) IBOutlet UILabel *telephony;
@property (weak, nonatomic) IBOutlet UILabel *transferDate;
@property (weak, nonatomic) IBOutlet UIView *separatorView;

@end

@implementation ContactHistoryViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.profileImageView.layer.cornerRadius = self.profileImageView.frame.size.height / 2;
    self.profileImageView.clipsToBounds = YES;
    self.profileImageView.layer.borderWidth = 1.5;
    self.profileImageView.layer.borderColor = [[UIColor neonProfileBlueColor] CGColor];
    self.separatorView.backgroundColor = [UIColor neonProfileBlueColor];
}

- (void)populateCell:(TransferModelView *)transfer {
    self.fullName.text = transfer.person.fullName;
    self.telephony.text = transfer.person.formatedPhoneNumber;
    self.profileImageView = [transfer.person profileImage:self.profileImageView];
    self.transferDate.text = transfer.formattedDate;
}


@end
