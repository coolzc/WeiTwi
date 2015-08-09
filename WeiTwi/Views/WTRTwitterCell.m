//
//  WTRTwitterCell.m
//  BuddhaSaid
//
//  Created by zhangcheng on 7/1/15.
//  Copyright (c) 2015 XYZ. All rights reserved.
//

#import "WTRTwitterCell.h"

@implementation WTRTwitterCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)updateCellContent:(NSString *)content {
    self.titleLabel.text = content;
}

@end
