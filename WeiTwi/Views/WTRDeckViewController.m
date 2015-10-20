//
//  WTRDeckViewController.m
//  WeiTwi
//
//  Created by zhangcheng on 10/9/15.
//  Copyright © 2015 XYZ. All rights reserved.
//

#import "WTRDeckViewController.h"
#import "WTRDecListTableViewCell.h"
#import "UINib+WeiTwi.h"

static NSString *const DivideListCellReuseIdentifier = @"WTRDecListTableViewCell";

@interface WTRDeckViewController ()

@property (nonatomic, strong) NSArray *divideListArray;

@end

@implementation WTRDeckViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureView];
}

- (void)viewDidAppear:(BOOL)animated {
    NSLog(@" deckview after viewdidappear  in navigationviewcontroller count:%d",[self.navigationController.viewControllers count]);
    
}

- (NSArray *)presenters {
    return @[self.navigationPresenter];
}

#pragma mark - WTRUserGroupListDisplayInterface

- (void)displayUserGroupList:(NSArray *)deckList {
    self.divideListArray = deckList;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.navigationPresenter goBack];
}


#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WTRDecListTableViewCell *cell = [self.divideListTableView dequeueReusableCellWithIdentifier:DivideListCellReuseIdentifier forIndexPath:indexPath];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return [self.divideListArray count];
    return 5;
}

#pragma mark - Private Methods 

- (void)configureView {
    self.divideListTableView.delegate = self;
    self.divideListTableView.dataSource = self;
    self.divideListArray = [NSArray new];
    
    [self.divideListTableView registerNib:[UINib nibForUserGroupCell] forCellReuseIdentifier:DivideListCellReuseIdentifier];
}

@end
