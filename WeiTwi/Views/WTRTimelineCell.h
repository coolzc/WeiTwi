//
//  WTRTwitterCell.h
//  BuddhaSaid
//
//  Created by zhangcheng on 7/1/15.
//  Copyright (c) 2015 XYZ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WTRWeiboStatusInfo.h"
#import "TTTAttributedLabel.h"

static NSString *const StatusPhotoCellReuseIdentifier = @"StatusPhotoCell";

@interface WTRTimelineCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *userImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *sourceLabel;
@property (weak, nonatomic) IBOutlet UILabel *producedTimeLabel;

@property (weak, nonatomic) IBOutlet TTTAttributedLabel *contentTextLabel;
@property (weak, nonatomic) IBOutlet TTTAttributedLabel *retweetTextLabel;

@property (weak, nonatomic) IBOutlet UICollectionView *photosCollectionView;

@property (weak, nonatomic) IBOutlet UILabel *commentCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *retweetCountLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *photosCollectionHeightConstraint;

- (void)updateCellStatuses:(WTRWeiboStatusInfo *)statusesInfo;
- (void)photosCollectionViewDelegate:(id<UICollectionViewDelegate, UICollectionViewDataSource>)delegate;
- (void)removePhotosCollectionView;
- (void)displayPhotosCollectionView;

@end
