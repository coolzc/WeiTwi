//
//  UILabel+WTRUtility.m
//  WeiTwi
//
//  Created by zhangcheng on 11/10/15.
//  Copyright © 2015 XYZ. All rights reserved.
//

#import "UILabel+WTRUtility.h"

@implementation UILabel (WTRUtility)

- (void)highLightTextWithRedColor:(NSRange)range {
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    [text addAttribute:NSForegroundColorAttributeName
                 value:[UIColor redColor]
                 range:range];
    self.attributedText = text;
}

@end
