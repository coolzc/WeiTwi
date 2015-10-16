//
//  WTRBaseViewController.m
//  WeiTwi
//
//  Created by zhangcheng on 10/10/15.
//  Copyright © 2015 XYZ. All rights reserved.
//

#import "WTRBaseViewController.h"
#import "WTRBasePresenter.h"

@interface WTRBaseViewController ()

@end

@implementation WTRBaseViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        [self privateInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self privateInit];
    }
    return self;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)loadView {
    [super loadView];
    for (WTRBasePresenter *presenter in [self presenters]) {
        presenter.mainViewController = self;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    for (WTRBasePresenter *presenter in [self presenters]) {
        [presenter viewDidLoad:self];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (self.needObserveKeyboardAppearance) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardWillShow:)
                                                     name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    }
    if (self.needTapAnywhereToHideKeyboard) {
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                     action:@selector(autoDismissKeyboardGestrureAction:)];
        [[NSNotificationCenter defaultCenter] addObserverForName:UIKeyboardWillShowNotification
                                                          object:nil
                                                           queue:[NSOperationQueue mainQueue]
                                                      usingBlock:^(NSNotification * _Nonnull note) {
                                                          [self.view addGestureRecognizer:tapGesture];
                                                      }];
        [[NSNotificationCenter defaultCenter] addObserverForName:UIKeyboardWillHideNotification
                                                          object:nil
                                                           queue:[NSOperationQueue mainQueue]
                                                      usingBlock:^(NSNotification * _Nonnull note) {
                                                          [self.view removeGestureRecognizer:tapGesture];
                                                      }];
    }
    if (self.needShowTabbar) {
        self.tabBarController.tabBar.hidden = NO;
    }
    for (WTRBasePresenter *presenter in [self presenters]) {
        [presenter view:self willAppear:animated];
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    for (WTRBasePresenter *presenter in [self presenters]) {
        [presenter view:self didAppear:animated];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if (self.needObserveKeyboardAppearance) {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    }
    for (WTRBasePresenter *presenter in [self presenters]) {
        [presenter view:self didDisappear:animated];
    }
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    for (WTRBasePresenter *presenter in [self presenters]) {
        [presenter view:self didDisappear:animated];
    }
}

- (NSArray *)presenters {
    return @[];
}

- (void)keyboardWillShow:(NSNotification *)notification {
}

- (void)keyboardWillHide:(NSNotification *)notification {
}

- (CGFloat)animateDuration:(CGFloat)duration {
    return self.needInstantAnimation ? 0.f : duration;
}

#pragma mark Private Methods

- (void)privateInit {
    _needShowTabbar = NO;
    _needInstantAnimation = NO;
    _needObserveKeyboardAppearance = NO;
    _needTapAnywhereToHideKeyboard = NO;
    _params = @{};
}

- (void)autoDismissKeyboardGestrureAction:(UITapGestureRecognizer *)gestrureRecognizer {
    [self.view endEditing:YES];
}

@end
