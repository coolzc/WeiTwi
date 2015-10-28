//
//  WTRTwitterManagerInteractor.m
//  WeiTwi
//
//  Created by zhangcheng on 10/27/15.
//  Copyright © 2015 XYZ. All rights reserved.
//

#import "WTRTwitterManagerInteractor.h"
#import "WTRConfig.h"

#import "STTwitterAPI.h"
#import "STTwitterOS.h"
#import "STTwitterOAuth.h"
#import "NSString+STTwitter.h"
#import "STTwitterAppOnly.h"
#import <Accounts/Accounts.h>
#import "STHTTPRequest.h"
#import "STHTTPRequest+STTwitter.h"

typedef void (^accountChooserBlock_t)(ACAccount *account, NSString *errorMessage); // don't bother with NSError for that

@interface WTRTwitterManagerInteractor ()

@property (nonatomic, strong) STTwitterAPI *twitter;
@property (nonatomic, strong) ACAccountStore *accountStore;
@property (nonatomic, strong) NSArray *iOSAccounts;
@property (nonatomic, strong) accountChooserBlock_t accountChooserBlock;

@end

@implementation WTRTwitterManagerInteractor

- (void)sendRequest:(WTRTwitterRequestType)apiRequest {
    switch (apiRequest) {
        case WTRTwitterRequestLogin:
            [self authorizedLogin];
            break;
        case WTRTWitterRequestHomeTimeline:
            [self homeTimelineRequest];
            break;
        default:
            break;
    }
}

#pragma mark - Private Methods

-(void)authorizedLogin {
    __weak typeof (self)weakSelf = self;
    self.accountChooserBlock = ^(ACAccount *account, NSString *errorMessage) {
        NSString *status = nil;
        if (account) {
            status = [NSString stringWithFormat:@"Did Select:%@",account.username];
            [weakSelf loginWithSystemAccount:account];
        } else {
            status = errorMessage;
        }
    };
    //TODO
    [self chooseAccount];
}

- (void)loginWithSystemAccount:(ACAccount *)account {
    self.twitter = nil;
    self.twitter = [STTwitterAPI twitterAPIOSWithAccount:account];
    
    [_twitter verifyCredentialsWithUserSuccessBlock:^(NSString *username, NSString *userID) {
       NSLog(@"username and userId:%@",[NSString stringWithFormat:@"@%@ (%@)", username, userID]);
    } errorBlock:^(NSError *error) {
      NSLog(@"error occurs:%@",[error localizedDescription]);
    }];
}

- (void)homeTimelineRequest {
    [_twitter getHomeTimelineSinceID:nil
                               count:20
                        successBlock:^(NSArray *statuses) {
                            NSLog(@"-- statuses: %@", statuses);
                            NSLog(@"statuses count:%@",[NSString stringWithFormat:@"%lu statuses", (unsigned long)[statuses count]]);
                            [self.delegate twitterServiceDidFinishRequestWithResponse:statuses];
                        } errorBlock:^(NSError *error) {
                            NSLog(@"error occurs:%@",[error localizedDescription]);
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
                for(ACAccount *account in _iOSAccounts) {
                    NSLog(@"account.username:%@",[NSString stringWithFormat:@"@%@", account.username]);
                }
            }
        }];
    };
    [self.accountStore requestAccessToAccountsWithType:accountType
                                               options:NULL
                                            completion:accountStoreRequestCompletionHandler];
}


@end
