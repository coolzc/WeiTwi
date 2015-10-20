//
//  SlideMotion.h
//
//  Created by Sherlock on 4/7/14.
//

#import <UIKit/UIKit.h>

typedef enum {
  SlideMotionDirectionHorizontal = 0, // Horizontal slide (default)
  SlideMotionDirectionLeft = 1,
  SlideMotionDirectionRight = 2,
  SlideMotionDirectionVertical = 3,   // vertical slide
  SlideMotionDirectionUp = 4,
  SlideMotionDirectionDown = 5,
} SlideMotionDirection;

@protocol SlideMotionDataSource;
@protocol SlideMotionDelegate;


/**
 * This motion class is used when you want a slide effort on a view.
 * 
 * It will listen panning(slide) gesture on the view and give delegets calls when finger moves.
**/
@interface SlideMotion : NSObject

@property (nonatomic, assign) BOOL enabled;
@property (nonatomic, assign) BOOL shouldExclusive;

@property (nonatomic, assign) SlideMotionDirection direction;

@property (nonatomic, weak) id<SlideMotionDelegate> delegate;
@property (nonatomic, weak) id<SlideMotionDataSource> dataSource;

/**
 * Attach this motion to the view that need to slide.
**/
- (void)attachToView:(UIView *)view;

/**
 * Detach this motion from the given view.
 **/
- (void)detachFromView:(UIView *)view;

@end


@protocol SlideMotionDelegate <NSObject>

@optional
- (void)slideMotion:(SlideMotion *)slideMotion willBeginSlideView:(UIView *)view direction:(SlideMotionDirection)direction location:(CGPoint)location;
- (void)slideMotion:(SlideMotion *)slideMotion didBeginSlideView:(UIView *)view direction:(SlideMotionDirection)direction;
/**
 * If counld not slide, the motion will end immediately
**/
- (BOOL)slideMotion:(SlideMotion *)slideMotion shouldSlideView:(UIView *)view withOffset:(CGFloat)offset;
/**
 * @param offset: The offset value from the start position of sliding.
 * offset > 0 slide right/down; offset < 0 slide left/up;
**/
- (void)slideMotion:(SlideMotion *)slideMotion didSlideView:(UIView *)view withOffset:(CGFloat)offset;
- (void)slideMotion:(SlideMotion *)slideMotion willEndSlideView:(UIView *)view;
- (void)slideMotion:(SlideMotion *)slideMotion didEndSlideView:(UIView *)view velocity:(CGPoint)velocity;

- (BOOL)slideMotion:(SlideMotion *)slideMotion shouldReceiveTouch:(UITouch *)touch forSlideView:(UIView *)view;

@end


@protocol SlideMotionDataSource <NSObject>

@required
/**
 * Should return the motion area view that the slide happens
**/
- (UIView *)containerViewOfSlideMotion:(SlideMotion *)slideMotion;

@end
