//
//  SlideMotion+Calculation.h
//
//  Created by Sherlock on 4/7/14.
//

#import "SlideMotion.h"

@interface SlideMotion (Calculation)

- (CGPoint)locationOfGesture:(UIPanGestureRecognizer *)gesture;

- (CGFloat)offsetOfGesture:(UIPanGestureRecognizer *)gesture fromLocation:(CGPoint)startLocation;

- (BOOL)shouldIgnoreGesture:(UIPanGestureRecognizer *)gesture;

@end
