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

@interface WTRTimelineCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *userImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *sourceLabel;
@property (weak, nonatomic) IBOutlet UILabel *producedTimeLabel;

@property (weak, nonatomic) IBOutlet UIView *timelineContentView;
@property (weak, nonatomic) IBOutlet TTTAttributedLabel *contentTextLabel;
@property (weak, nonatomic) IBOutlet UIView *subStatusView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *userContentTextLabelHeightContraint;

@property (weak, nonatomic) IBOutlet TTTAttributedLabel *subStatusTextLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *subStatusTextLabelHeightConstraint;

@property (weak, nonatomic) IBOutlet UIImageView *image1View;
@property (weak, nonatomic) IBOutlet UIImageView *image2View;
@property (weak, nonatomic) IBOutlet UIImageView *image3View;
@property (weak, nonatomic) IBOutlet UIImageView *image4View;
@property (weak, nonatomic) IBOutlet UIImageView *image5View;
@property (weak, nonatomic) IBOutlet UIImageView *image6View;
@property (weak, nonatomic) IBOutlet UIImageView *image7View;
@property (weak, nonatomic) IBOutlet UIImageView *image8View;
@property (weak, nonatomic) IBOutlet UIImageView *image9View;

@property (weak, nonatomic) IBOutlet UILabel *commentCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *retweetCountLabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftVerticalLineToLeftConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightVerticalLineToRightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topHorizontalLineToTopConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomHorizontalLineToBottomConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *picturesViewHeightConstraint;

- (void)updateCellStatuses:(WTRWeiboStatusInfo *)statusesInfo;
- (void)updateCellHeightConstraintValues:(CGFloat)totalHeight statusTextHeightValue:(CGFloat)statusTextHeight reTweetTextHeightValue:(CGFloat)reTweetTextHeight picturesViewConstraintsValues:(NSArray *)viewConstraints;

@end
