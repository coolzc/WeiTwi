//
//  WTRTwitterCell.h
//  BuddhaSaid
//
//  Created by zhangcheng on 7/1/15.
//  Copyright (c) 2015 XYZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WTRTwitterCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

- (void)updateCellContent:(NSString *)content;

@end
