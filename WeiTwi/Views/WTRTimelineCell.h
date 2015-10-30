//
//  WTRTwitterCell.h
//  BuddhaSaid
//
//  Created by zhangcheng on 7/1/15.
//  Copyright (c) 2015 XYZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WTRTimelineCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *userImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *sourceLabel;
@property (weak, nonatomic) IBOutlet UILabel *producedTimeLabel;

@property (weak, nonatomic) IBOutlet UIView *timelineContentView;
@property (weak, nonatomic) IBOutlet UILabel *contentTextLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *userContentTextLabelHeightContraint;

- (void)updateCellContent:(NSDictionary *)content;

@end
