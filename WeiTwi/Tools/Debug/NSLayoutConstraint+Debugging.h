//
//  NSLayoutConstraint+Debugging.h
//  WeiTwi
//
//  Created by zhangcheng on 2/23/16.
//  Copyright © 2016 XYZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSLayoutConstraint (ObjcioLayoutConstraintsDebugging)

@property (readonly, nonatomic, copy) NSArray *creationCallStackSymbols;

@end