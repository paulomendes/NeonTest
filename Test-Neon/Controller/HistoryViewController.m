
#import "HistoryViewController.h"
#import "ContactHistoryViewCell.h"
#import "TransferWS.h"
#import "TransferModelView.h"
#import <SVProgressHUD.h>

@interface HistoryViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *transfers;

@end

@implementation HistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
    
    [self callTransfers];
    self.navigationItem.title = @"HISTÓRICO DE ENVIOS";
    self.tableView.hidden = YES;
}

- (void)callTransfers {
    [SVProgressHUD showWithStatus:@"Atualziando"];
    __weak typeof(self) weakSelf = self;
    [TransferWS loadTransfersWithCompletion:^(NSArray *array) {
        [SVProgressHUD dismiss];
        weakSelf.transfers = array;
        weakSelf.tableView.hidden = NO;
        [weakSelf reloadTableData];
    } error:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:error.description];
        [SVProgressHUD dismissWithDelay:2.f];
    }];
}

- (void)reloadTableData {
    [self.tableView reloadData];
}

#pragma mark - TableView Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.transfers.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 75.f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ContactHistoryViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"historyCellIdentifier"];
    
    TransferModelView *transfer = [[TransferModelView alloc] initWithTransfer:self.transfers[indexPath.row]];
    [cell populateCell:transfer];
    
    return cell;
}

@end
