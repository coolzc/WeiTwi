//
//  HomeViewController.m
//  BuddhaSaid
//
//  Created by zhangcheng on 6/8/15.
//  Copyright (c) 2015 XYZ. All rights reserved.
//


#import "HomeViewController.h"
#import "WTRTwitterCell.h"
#import "STTwitter.h"
#import "WTRWireframe.h"
#import <Accounts/Accounts.h>
#import "WeiboSDK.h"

//twitter
static NSString *const TwitterCellReuseIdentifier = @"TwitterCellReusedId";
static NSString *const ConsumerKey = @"C3SleTImiuZn5OfoDieHyoonJ";
static NSString *const ConsumerSecret = @"oqXgij1sz9ejPaSZ53KFfj92X9lwQsQvQLfPNUnm3Rd2bdcDaP";
//weibo
static NSString *const WeiboAppKey = @"1425082483";
static NSString *const WeiboAppSecret = @"2d3f9fcf083316cc12066edae8ffc408";

typedef void (^accountChooserBlock_t)(ACAccount *account, NSString *errorMessage); // don't bother with NSError for that
typedef void (^myBlock)(BOOL need, NSInteger num);

@interface HomeViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray* twitterFeed;
@property (nonatomic, strong) NSMutableArray* weiboFeed;
@property (nonatomic, strong) NSMutableArray* tableSoucreFeed;
@property (nonatomic, strong) STTwitterAPI *twitter;
@property (nonatomic, strong) ACAccountStore *accountStore;
@property (nonatomic, strong) NSArray *iOSAccounts;
@property (nonatomic, strong) accountChooserBlock_t accountChooserBlock;
@property (nonatomic, strong) myBlock myBolck;
@property (nonatomic, strong) WeiboRequestOperation* weiboquery;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureView];
    self.accountStore = [[ACAccountStore alloc] init];
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tableSoucreFeed.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WTRTwitterCell *cell = [tableView dequeueReusableCellWithIdentifier:TwitterCellReuseIdentifier forIndexPath:indexPath];
    if(0 == indexPath.row) {
        [cell updateCellContent:@"first cell"];
    }

    if (self.weiboFeed) {
        Status *statuses = self.tableSoucreFeed[indexPath.row][@"statuses"];
        [cell updateCellContent:statuses.text];
    } else {
        NSDictionary *t = self.tableSoucreFeed[indexPath.row];
        [cell updateCellContent:t[@"text"]];
    }
    
    return cell;
}
#pragma mark - UITableViewDelegate

#pragma mark -Action
- (IBAction)backButtonTouchUpInside:(id)sender {
    [WTRWireframe dismissToPreviousPageOfViewController:self];
}

- (IBAction)loginButtonTouchUpInside:(id)sender {
    _loginStatusLabel.text = @"Trying to login with iOS...";
    __weak typeof(self) weakSelf = self;
    self.accountChooserBlock = ^(ACAccount *account, NSString *errorMessage) {
        NSString *status = nil;
        if(account) {
            status = [NSString stringWithFormat:@"Did select %@", account.username];
            [weakSelf loginWithiOSAccount:account];
        } else {
            status = errorMessage;
        }
        weakSelf.loginStatusLabel.text = status;
    };
    [self chooseAccount];
}

- (IBAction)getTimelineAction:(id)sender {
    self.timelineStatusLabel.text = @"";
    [_twitter getHomeTimelineSinceID:nil
                               count:20
                        successBlock:^(NSArray *statuses) {
                            NSLog(@"-- statuses: %@", statuses);
                            self.timelineStatusLabel.text = [NSString stringWithFormat:@"%lu statuses", (unsigned long)[statuses count]];
                            self.twitterFeed = [NSMutableArray arrayWithArray:statuses];
                            [self reloadTableSourceData];
                        } errorBlock:^(NSError *error) {
                            self.timelineStatusLabel.text = [error localizedDescription];
                            self.twitterFeed = nil;
                            NSLog(@"%@",[error localizedDescription]);
                        }];
}

- (IBAction)changeButtonTouchUpInside:(id)sender {
    Weibo *weibo = [[Weibo alloc] initWithAppKey:WeiboAppKey withAppSecret:WeiboAppSecret];
    [Weibo setWeibo:weibo];
    if (weibo.isAuthenticated) {
        NSLog(@"current user: %@", weibo.currentAccount.user.name);
    }
    if (![Weibo.weibo isAuthenticated]) {
        [Weibo.weibo authorizeWithCompleted:^(WeiboAccount *account, NSError *error) {
            if (!error) {
                NSLog(@"Sign in successful: %@", account.user.screenName);
            }
            else {
                NSLog(@"Failed to sign in: %@", error);
            }
        }];
    } else {
        [self loadStatuses];
    }
}


#pragma mark - Private Methods

- (void)configureView {
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = 100.f;
    [self.tableView registerNib:[UINib nibWithNibName:@"WTRTwitterCell" bundle:nil] forCellReuseIdentifier:TwitterCellReuseIdentifier];
    self.myBolck = ^(BOOL need, NSInteger num){
        need = YES;
        num = 1;
    };
    [self testFunc];
}

- (void)testFunc {
    _myBolck(NO,2);
    return;
}

- (void)loginWithiOSAccount:(ACAccount *)account {
    
    self.twitter = [STTwitterAPI twitterAPIOSWithAccount:account];
    
    [_twitter verifyCredentialsWithSuccessBlock:^(NSString *username) {
        _loginStatusLabel.text = [NSString stringWithFormat:@"@%@", username];
    } errorBlock:^(NSError *error) {
        _loginStatusLabel.text = [error localizedDescription];
    }];
    
}

- (void)chooseAccount {
    ACAccountType *accountType = [_accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
    
    ACAccountStoreRequestAccessCompletionHandler accountStoreRequestCompletionHandler = ^(BOOL granted, NSError *error) {
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            
            if(granted == NO) {
                _accountChooserBlock(nil, @"Acccess not granted.");
                return;
            }
            
            self.iOSAccounts = [_accountStore accountsWithAccountType:accountType];
            
            if([_iOSAccounts count] == 1) {
                ACAccount *account = [_iOSAccounts lastObject];
                _accountChooserBlock(account, nil);
            } else {
                UIActionSheet *as = [[UIActionSheet alloc] initWithTitle:@"Select an account:"
                                                                delegate:self
                                                       cancelButtonTitle:@"Cancel"
                                                  destructiveButtonTitle:nil otherButtonTitles:nil];
                for(ACAccount *account in _iOSAccounts) {
                    [as addButtonWithTitle:[NSString stringWithFormat:@"@%@", account.username]];
                }
                [as showInView:self.view.window];
            }
        }];
    };
    
#if TARGET_OS_IPHONE &&  (__IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_6_0)
    if (floor(NSFoundationVersionNumber) < NSFoundationVersionNumber_iOS_6_0) {
        [self.accountStore requestAccessToAccountsWithType:accountType
                                     withCompletionHandler:accountStoreRequestCompletionHandler];
    } else {
        [self.accountStore requestAccessToAccountsWithType:accountType
                                                   options:NULL
                                                completion:accountStoreRequestCompletionHandler];
    }
#else
    [self.accountStore requestAccessToAccountsWithType:accountType
                                               options:NULL
                                            completion:accountStoreRequestCompletionHandler];
#endif
    
}

- (void)loadStatuses {
    self.weiboquery = [Weibo.weibo queryTimeline:StatusTimelineHome count:30 completed:^(NSMutableArray *statuses, NSError *error) {
        if (error) {
            self.weiboFeed = nil;
            NSLog(@"error:%@", error);
        } else {
            self.weiboFeed = statuses;
            [self reloadTableSourceData];
        }
    }];
}

- (void)reloadTableSourceData {
    if (self.twitterFeed) {
        self.tableSoucreFeed = self.twitterFeed;
        self.weiboFeed = nil;
    } else {
        self.tableSoucreFeed = self.weiboFeed;
        self.twitterFeed =nil;
    }
    [self.tableView reloadData];
}
                        
@end
