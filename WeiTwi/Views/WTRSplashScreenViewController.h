//
//  WTRSplashScreenViewController.h
//  WeiTwi
//
//  Created by zhangcheng on 10/13/15.
//  Copyright © 2015 XYZ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WTRBaseViewController.h"
#import "WTRProgressViewInterface.h"
#import "WTRInitializationPresenter.h"

@interface WTRSplashScreenViewController : WTRBaseViewController <WTRProgressViewInterface>

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *splashImageTopContraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *splashImageLeftContraint;
@property (weak, nonatomic) IBOutlet UIImageView *splashImageView;
@property (weak, nonatomic) IBOutlet UILabel *textLabel;

@property (nonatomic, strong) WTRInitializationPresenter *initializaitonPresenter;

@end
