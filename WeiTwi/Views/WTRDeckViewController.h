//
//  WTRDeckViewController.h
//  WeiTwi
//
//  Created by zhangcheng on 10/9/15.
//  Copyright © 2015 XYZ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WTRNavigationPresenter.h"
#import "WTRUserGroupListDisplayInterface.h"

@interface WTRDeckViewController : WTRBaseViewController <UITableViewDataSource, UITableViewDelegate, WTRUserGroupListDisplayInterface>

@property (nonatomic, strong) WTRNavigationPresenter *navigationPresenter;

@property (weak, nonatomic) IBOutlet UIImageView *userImageView;
@property (weak, nonatomic) IBOutlet UITableView *divideListTableView;

@end
