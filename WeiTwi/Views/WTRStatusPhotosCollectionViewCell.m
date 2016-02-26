//
//  WTRStatusPhotosCollectionViewCell.m
//  WeiTwi
//
//  Created by zhangcheng on 2/24/16.
//  Copyright © 2016 XYZ. All rights reserved.
//

#import "WTRStatusPhotosCollectionViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation WTRStatusPhotosCollectionViewCell

- (void)awakeFromNib {
}

- (void)updateWithPhoto:(NSURL *)photoUrl {
    [self.photoView sd_setImageWithURL:photoUrl placeholderImage:[UIImage imageNamed:@"tab_item_message_selected"]];
}

@end
