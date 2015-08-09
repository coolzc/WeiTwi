//
//  BSWelcomeViewController.m
//  BuddhaSaid
//
//  Created by zhangcheng on 6/8/15.
//  Copyright (c) 2015 XYZ. All rights reserved.
//

#import "WTRWelcomeViewController.h"
#import "WTRWireframe.h"

@interface WTRWelcomeViewController ()

@end

@implementation WTRWelcomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)overlookButtonTouchUpInside:(id)sender {
    [WTRWireframe moveToHomeViewControllerFrom:self];
}


@end
