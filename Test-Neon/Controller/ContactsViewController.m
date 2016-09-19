
#import "ContactsViewController.h"
#import "ContactViewCell.h"
#import "PersonsDAO.h"
#import "PersonModelView.h"
#import "UIColor+NeonColors.h"
#import "SendPopUpConfirmationViewController.h"
#import "TransferWS.h"
#import <STPopup.h>
#import <SVProgressHUD.h>

@interface ContactsViewController () <UITableViewDelegate, UITableViewDataSource, SendPopUpConfirmationProtocol>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ContactsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
    self.navigationItem.title = @"ENVIAR DINHEIRO";
}

-(void)openConfirmationViewController:(PersonModelView *)person {
    
    SendPopUpConfirmationViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"confirmationViewController"];
    vc.person = person;
    vc.delegate = self;
    STPopupController *popup = [[STPopupController alloc] initWithRootViewController:vc];
    popup.containerView.layer.cornerRadius = 4;
    popup.navigationBarHidden = YES;
    [popup presentInViewController:self];
}

#pragma mark - SendPopUpConfirmationProtocol

- (void)didSentConfirmMoneyTransfer:(TransferRequestModel *)transfer {
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD showWithStatus:@"Transferindo"];
    [TransferWS postTransfer:transfer withCompletion:^(NSString *string) {
        [SVProgressHUD showSuccessWithStatus:@"Concluído com Sucesso"];
        [SVProgressHUD dismissWithDelay:2.f];
    } error:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:error.description];
        [SVProgressHUD dismissWithDelay:2.f];
    }];
}

#pragma mark - Table View Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [PersonsDAO sharedInstance].allPersons.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ContactViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"contactCellIdentifier"];
    
    PersonModelView *p = [[PersonModelView alloc] initWithPerson:[PersonsDAO sharedInstance].allPersons[indexPath.row]];
    [cell populateCell:p];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    PersonModelView *p = [[PersonModelView alloc] initWithPerson:[PersonsDAO sharedInstance].allPersons[indexPath.row]];
    [self openConfirmationViewController:p];
}

@end
