//
//  SlideMotion+Calculation.m
//
//  Created by Sherlock on 4/7/14.
//

#import "SlideMotion+Calculation.h"

#define TRIGGER_SENSITIVITY 1.3

@implementation SlideMotion (Calculation)

#pragma mark - Private Methods

- (CGPoint)locationOfGesture:(UIPanGestureRecognizer *)gesture {
  return [gesture locationInView:[self.dataSource containerViewOfSlideMotion:self]];
}

- (CGFloat)offsetOfGesture:(UIPanGestureRecognizer *)gesture fromLocation:(CGPoint)startLocation {
  CGPoint newLocation = [self locationOfGesture:gesture];
  CGFloat offset = 0;
  switch (self.direction) {
    case SlideMotionDirectionLeft:
    case SlideMotionDirectionRight:
    case SlideMotionDirectionHorizontal:
      offset = newLocation.x - startLocation.x;
      break;
      
    case SlideMotionDirectionUp:
    case SlideMotionDirectionDown:
    case SlideMotionDirectionVertical:
      offset = newLocation.y - startLocation.y;
      break;
      
    default:
      break;
  }
  return offset;
}

- (BOOL)shouldIgnoreGesture:(UIPanGestureRecognizer *)gesture {
  BOOL shouldIgnoreGesture = NO;
  CGPoint velocity = [gesture velocityInView:[self.dataSource containerViewOfSlideMotion:self]];
  switch (self.direction) {
    case SlideMotionDirectionLeft:
    case SlideMotionDirectionRight:
    case SlideMotionDirectionHorizontal:
      shouldIgnoreGesture = ABS(velocity.y * TRIGGER_SENSITIVITY) > ABS(velocity.x);
      break;
      
    case SlideMotionDirectionUp:
    case SlideMotionDirectionDown:
    case SlideMotionDirectionVertical:
      shouldIgnoreGesture = ABS(velocity.x * TRIGGER_SENSITIVITY) > ABS(velocity.y);
      break;
      
    default:
      break;
  }
  
  if (shouldIgnoreGesture) {
    return shouldIgnoreGesture;
  }
  
  switch (self.direction) {
    case SlideMotionDirectionLeft:
      shouldIgnoreGesture = (0 <= velocity.x);
      break;
      
    case SlideMotionDirectionRight:
      shouldIgnoreGesture = (0 >= velocity.x);
      break;
      
    case SlideMotionDirectionUp:
      shouldIgnoreGesture = (0 <= velocity.y);
      break;
      
    case SlideMotionDirectionDown:
      shouldIgnoreGesture = (0 >= velocity.y);
      break;
      
    default:
      break;
  }
  
  return shouldIgnoreGesture;
}

@end
