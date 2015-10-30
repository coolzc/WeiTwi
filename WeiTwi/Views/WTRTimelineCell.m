//
//  WTRTwitterCell.m
//  BuddhaSaid
//
//  Created by zhangcheng on 7/1/15.
//  Copyright (c) 2015 XYZ. All rights reserved.
//

#import "WTRTimelineCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation WTRTimelineCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)updateCellContent:(NSDictionary *)content {
    self.contentTextLabel.text = content[@"text"];
    NSDictionary* userInfo = content[@"user"];
    NSString* profileImageUrl = [NSString new];
    if (userInfo[@"profile_image_url"]) {
        profileImageUrl = userInfo[@"profile_image_url"];
    }
    [self.userImageView sd_setImageWithURL:[NSURL URLWithString:profileImageUrl] placeholderImage:[UIImage imageNamed:@""]];
}

@end
