//
//  WTRMyView.m
//  BuddhaSaid
//
//  Created by zhangcheng on 6/29/15.
//  Copyright (c) 2015 XYZ. All rights reserved.
//

#import "WTRMyView.h"

@implementation WTRMyView

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    CGSize size = self.bounds.size;
    CGFloat margin = 10;
    CGFloat radius = rintf(MIN(size.height - margin,
                             size.width - margin)/4);
    CGFloat xOffset, yOffset;
    CGFloat offset = rintf((size.height - size.width)/2);
    if (offset > 0) {
        xOffset = rint(margin / 2);
        yOffset = offset;
    } else {
        xOffset = -offset;
        yOffset = rint(margin / 2);
    }
    
    [[UIColor redColor] setFill];
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path addArcWithCenter:CGPointMake(radius * 2 + xOffset,
                                       radius + yOffset)
                    radius:radius
                startAngle:-M_PI
                  endAngle:0
                 clockwise:YES];
    [path addArcWithCenter:CGPointMake(radius * 3 + xOffset,
                                       radius * 2 + yOffset)
                    radius:radius
                startAngle:-M_PI_2
                  endAngle:M_PI_2
                 clockwise:YES];
    [path addArcWithCenter:CGPointMake(radius  + xOffset,
                                       radius * 2 + yOffset)
                    radius:radius
                startAngle:M_PI_2
                  endAngle:-M_PI_2
                 clockwise:YES];
    [path addArcWithCenter:CGPointMake(radius * 2+ xOffset,
                                       radius * 3 + yOffset)
                    radius:radius
                startAngle:0
                  endAngle:M_PI
                 clockwise:YES];
    [path closePath];
    [path fill];
}

@end
