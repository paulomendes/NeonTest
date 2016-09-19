
#import "HomeViewController.h"
#import "UIColor+NeonColors.h"
#import "UserDAO.h"
#import "TransferWS.h"

@interface HomeViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UIView *containerProfileView;
@property (weak, nonatomic) IBOutlet UIButton *sendMoneyButton;
@property (weak, nonatomic) IBOutlet UIButton *historyButton;

@end

@implementation HomeViewController

- (void)showTryAgain {
    NSString *s = @"Não foi possível carregar o seu token de usuário, por favor tente novamente mais tarde";
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"Aviso"
                                                                    message:s
                                                             preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *retryAction = [UIAlertAction actionWithTitle:@"Tentar Novamente"
                                                       style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction * action) {
                                                         [alert dismissViewControllerAnimated:YES completion:^{
                                                             [self loadUserToken];
                                                         }];
                                                     }];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK"
                                                       style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction * action) {
                                                         [alert dismissViewControllerAnimated:YES completion:nil];
                                                     }];
    
    [alert addAction:okAction];
    [alert addAction:retryAction];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)loadUserToken {
    if (![[UserDAO sharedInstance] userToken].length) {
        [TransferWS loadUserToken:^(NSString *string) {
            [[UserDAO sharedInstance] configureUserToken:string];
        } error:^(NSError *error) {
            [self showTryAgain];
        }];
    }
}

- (void)roundView:(UIView *)view {
    view.layer.cornerRadius = view.frame.size.width / 2;
    view.clipsToBounds = YES;
    [view layoutIfNeeded];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    [self roundView:self.profileImage];
    [self roundView:self.containerProfileView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
}

- (void)interfaceTweaks {
    self.profileImage.layer.borderWidth = 1;
    self.profileImage.layer.borderColor = [[UIColor neonProfileBlueColor] CGColor];
    
    self.containerProfileView.layer.borderWidth = 1;
    self.containerProfileView.layer.borderColor = [[UIColor whiteColor] CGColor];
    
    self.sendMoneyButton.layer.cornerRadius = 22;
    self.sendMoneyButton.clipsToBounds = YES;
    
    self.historyButton.layer.cornerRadius = 22;
    self.historyButton.clipsToBounds = YES;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)tweakAppearance {
    [self setNeedsStatusBarAppearanceUpdate];
    [[UINavigationBar appearance] setBarTintColor:[UIColor neonGreenColor]];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes: @{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadUserToken];
    
    [self tweakAppearance];
    [self interfaceTweaks];
}

@end
