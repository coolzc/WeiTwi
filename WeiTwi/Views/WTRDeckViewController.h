//
//  WTRDeckViewController.h
//  WeiTwi
//
//  Created by zhangcheng on 10/9/15.
//  Copyright © 2015 XYZ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WTRUserGroupListDisplayInterface.h"
#import "WTRTransitionDelegate.h"
#import "WTRDeckPresenter.h"

@interface WTRDeckViewController : WTRBaseViewController <UITableViewDataSource, UITableViewDelegate, WTRUserGroupListDisplayInterface>

@property (nonatomic, strong) WTRDeckPresenter *deckListPresenter;

@property (weak, nonatomic) IBOutlet UIImageView *userImageView;
@property (weak, nonatomic) IBOutlet UITableView *divideListTableView;

@end
