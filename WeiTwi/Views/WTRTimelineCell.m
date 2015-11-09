//
//  WTRTwitterCell.m
//  BuddhaSaid
//
//  Created by zhangcheng on 7/1/15.
//  Copyright (c) 2015 XYZ. All rights reserved.
//

#import "WTRTimelineCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "NSString+WTRUtility.h"
#import "NSDateFormatter+WTRUtility.h"

@implementation WTRTimelineCell

- (void)awakeFromNib {
    // Initialization code
    self.contentTextLabel.lineBreakMode = NSLineBreakByWordWrapping;
    //image view
    self.userImageView.layer.cornerRadius = 10.f;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

- (void)updateCellStatuses:(WTRWeiboStatusInfo *)statusesInfo {
    self.nameLabel.text = statusesInfo.user.name;
    self.producedTimeLabel.text = [NSDateFormatter weiboDateConvertToCustomFormat:statusesInfo.createdAt];
    self.sourceLabel.text = statusesInfo.source;
    self.contentTextLabel.text = statusesInfo.text;
    [self.userImageView sd_setImageWithURL:[NSURL URLWithString:statusesInfo.user.profileImageUrl] placeholderImage:[UIImage imageNamed:@""]];
}

- (void)updateConstraints {
    CGFloat labelWidth = self.contentTextLabel.frame.size.width;
    CGRect lblTextSize = [self.contentTextLabel.text boundingRectWithSize:CGSizeMake(labelWidth, MAXFLOAT)
                                                                  options:NSStringDrawingUsesLineFragmentOrigin
                                                               attributes:@{NSFontAttributeName:self.contentTextLabel.font}
                                                                  context:nil];
    self.userContentTextLabelHeightContraint.constant = lblTextSize.size.height;
    [super updateConstraints];
}

#pragma mark - Private Methods



@end
