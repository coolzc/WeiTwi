//
//  WTRStatusPhotosCollectionViewCell.h
//  WeiTwi
//
//  Created by zhangcheng on 2/24/16.
//  Copyright © 2016 XYZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WTRStatusPhotosCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *photoView;

- (void)updateWithPhoto:(NSURL *)photoUrl;

@end
