//
//  WTRProgressViewInterface.h
//  WeiTwi
//
//  Created by zhangcheng on 10/13/15.
//  Copyright © 2015 XYZ. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol WTRProgressViewInterface <NSObject>

@required
- (void)beginProgress;
- (void)endProgress;

@optional
- (void)updateProgress:(CGFloat)progress message:(NSString *)message;

@end
